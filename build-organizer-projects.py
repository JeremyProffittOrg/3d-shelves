"""Build printer-specific organizer projects through the installed Bambu CLI.
No printer communication occurs. Generated files stay under build/organizer.
"""
import json
import os
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parent
NAME = '77-inch-industrial-shelves-280mm-deep-organizer'
STUDIO = Path('C:/Program Files/Bambu Studio/bambu-studio.exe')
PROFILES = STUDIO.parent / 'resources/profiles/BBL'
OUTPUT = ROOT / 'build/organizer'

def resolved(kind, name):
    data = json.loads((PROFILES / kind / (name + '.json')).read_text(encoding='utf-8'))
    config = resolved(kind, data['inherits']) if data.get('inherits') else {}
    config.update(data)
    config['inherits'] = ''
    return config

def build(model):
    target = OUTPUT / model.lower()
    target.mkdir(parents=True, exist_ok=True)
    machine = resolved('machine', 'Bambu Lab ' + model + ' 0.4 nozzle')
    process = resolved('process', '0.20mm Standard @BBL ' + model)
    filament = resolved('filament', 'Generic PLA @BBL ' + model)
    machine['printer_settings_id'] = machine['name']
    process['print_settings_id'] = process['name']
    process['enable_support'] = '1'
    process['support_type'] = 'normal(auto)'
    process['enable_prime_tower'] = '0'
    filament['filament_settings_id'] = [filament['name']]
    for name, config in [('machine', machine), ('process', process), ('filament', filament)]:
        (target / (name + '.json')).write_text(json.dumps(config, indent=2), encoding='utf-8')
    args = [str(STUDIO), '--load-settings', str(target / 'machine.json') + ';' + str(target / 'process.json'),
            '--load-filaments', str(target / 'filament.json'), '--arrange', '1',
            '--slice', '0', '--export-3mf', NAME + '-' + model.lower() + '.3mf',
            '--outputdir', str(target), str(ROOT / 'build/stl' / (NAME + '.stl'))]
    flags = subprocess.CREATE_NO_WINDOW if os.name == 'nt' else 0
    with (target / 'cli.log').open('w', encoding='utf-8') as log:
        job = subprocess.Popen(args, cwd=target, stdout=log, stderr=subprocess.STDOUT, creationflags=flags)
        (target / 'job.json').write_text(json.dumps({'pid': job.pid, 'args': args}), encoding='utf-8')
        try:
            code = job.wait(timeout=600)
        except subprocess.TimeoutExpired:
            job.kill()
            job.wait()
            raise RuntimeError(model + ': slicer exceeded 600 seconds')
    result = json.loads((target / 'result.json').read_text(encoding='utf-8'))
    print(json.dumps({'model': model, 'exit': code, 'result': result}), flush=True)
    if code or result.get('return_code'):
        raise RuntimeError(model + ': Bambu CLI failed; see ' + str(target / 'result.json'))
    output = target / (NAME + '-' + model.lower() + '.3mf')
    subprocess.run(['node', str(ROOT / 'verify-organizer.mjs'), str(output)], cwd=ROOT, check=True, creationflags=flags)
    return output

if __name__ == '__main__':
    models = sys.argv[1:] or ['H2D', 'H3C']
    if any(m not in ('H2D', 'H3C') for m in models):
        raise SystemExit('Supported models: H2D H3C')
    for model in models:
        build(model)
