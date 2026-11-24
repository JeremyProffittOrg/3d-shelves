import { spawnSync } from 'node:child_process';
if (process.argv[2]?.endsWith('.3mf')) {
 const result = spawnSync('python', ['-c', `import sys,zipfile,json,xml.etree.ElementTree as ET,posixpath
z=zipfile.ZipFile(sys.argv[1]); cfg=json.loads(z.read('Metadata/project_settings.config'))
ns={'m':'http://schemas.microsoft.com/3dmanufacturing/core/2015/02'}
prod='{http://schemas.microsoft.com/3dmanufacturing/production/2015/06}'
identity=[1,0,0,0,1,0,0,0,1,0,0,0]
def transform(p,t):
 return [sum(p[j]*t[j*3+i] for j in range(3))+t[9+i] for i in range(3)]
def matrix(e):
 t=list(map(float,e.get('transform','').split())) if e.get('transform') else identity
 assert all(abs(sum(t[i*3+k]*t[j*3+k] for k in range(3))-(1 if i==j else 0))<0.00001 for i in range(3) for j in range(3)), 'non-rigid transform changes functional dimensions'
 return t
def points(path,oid):
 doc=ET.fromstring(z.read(path)); obj=doc.find('m:resources/m:object[@id="'+oid+'"]',ns)
 assert obj is not None, 'missing object'
 for v in obj.findall('m:mesh/m:vertices/m:vertex',ns): yield [float(v.get(k)) for k in ('x','y','z')]
 for c in obj.findall('m:components/m:component',ns):
  childpath=c.get(prod+'path',path).lstrip('/')
  for p in points(childpath,c.get('objectid')): yield transform(p,matrix(c))
doc=ET.fromstring(z.read('3D/3dmodel.model')); vertices=[]
for item in doc.findall('m:build/m:item',ns):
 if item.get('printable','1')=='1': vertices.extend(transform(p,matrix(item)) for p in points('3D/3dmodel.model',item.get('objectid')))
assert vertices,'no printable mesh'
lo=[min(p[i] for p in vertices) for i in range(3)]; hi=[max(p[i] for p in vertices) for i in range(3)]
area=[list(map(float,v.split('x'))) for v in cfg['printable_area']]; bedlo=[min(p[i] for p in area) for i in range(2)]+[0]; bedhi=[max(p[i] for p in area) for i in range(2)]+[float(cfg['printable_height'])]
result={'printer':cfg.get('printer_model'),'bounds':[lo,hi],'bed':[bedlo,bedhi],'supports':cfg.get('enable_support'),'pass':False}
print(json.dumps(result))
assert all(lo[i]>=bedlo[i]-0.01 and hi[i]<=bedhi[i]+0.01 for i in range(3)), 'model outside build volume'
assert abs(lo[2])<0.01,'model not resting on build plate'
assert cfg.get('printer_model') in ['Bambu Lab H2D','Bambu Lab H3C'],'wrong printer profile'
assert all(abs(a-b)<0.02 for a,b in zip(sorted([hi[0]-lo[0],hi[1]-lo[1]]),[230,280])) and abs(hi[2]-lo[2]-257.884736)<0.02,'unexpected dimensions'
# The single-material mesh must fit at least one individual nozzle reach area.
regions=cfg.get('extruder_printable_area',[])
if regions:
 boxes=[[list(map(float,p.split('x'))) for p in s.split(',')] for s in regions if s]
 assert any(all(lo[i]>=min(p[i] for p in box)-0.01 and hi[i]<=max(p[i] for p in box)+0.01 for i in range(2)) for box in boxes),'model outside all individual nozzle reach areas'
result['pass']=True;print(json.dumps(result))
`, process.argv[2]], {windowsHide:true, encoding:'utf8'});
 process.stdout.write(result.stdout ?? '');
 process.stderr.write(result.stderr ?? '');
 if (result.error) console.error(result.error.message);
 process.exit(result.status ?? 1);
}
import fs from 'node:fs';
import assert from 'node:assert/strict';
const path = process.argv[2] ?? 'build/stl/77-inch-industrial-shelves-280mm-deep-organizer.stl';
const b = fs.readFileSync(path);
const n = b.readUInt32LE(80);
assert.equal(b.length,84+50*n,'binary STL length');
const vertices=[], triangles=[], lookup=new Map(), edges=new Map();
const lo=[Infinity,Infinity,Infinity], hi=[-Infinity,-Infinity,-Infinity];
for(let i=0;i<n;i++) {
 const t=[];
 for(let j=0;j<3;j++) {
  const p=[0,1,2].map(k=>b.readFloatLE(84+i*50+12+j*12+k*4));
  p.forEach((x,k)=>{lo[k]=Math.min(lo[k],x);hi[k]=Math.max(hi[k],x)});
  const key=p.map(x=>Math.round(x*10000)).join(',');
  if(!lookup.has(key)){lookup.set(key,vertices.length);vertices.push(p)}
  t.push(lookup.get(key));
 }
 assert.equal(new Set(t).size,3,'nondegenerate triangle');triangles.push(t);
 for(let j=0;j<3;j++) {
  const a=t[j],c=t[(j+1)%3],key=a<c?a+','+c:c+','+a;
  const entry=edges.get(key)??{count:0,balance:0,faces:[]};
  entry.count++;entry.balance+=a<c?1:-1;entry.faces.push(i);edges.set(key,entry);
 }
}
const parent=triangles.map((_,i)=>i);
function find(i){while(parent[i]!==i){parent[i]=parent[parent[i]];i=parent[i]}return i}
for(const e of edges.values()) {
 assert.equal(e.count,2,'watertight: two faces per edge');
 assert.equal(e.balance,0,'consistent winding');
 parent[find(e.faces[0])]=find(e.faces[1]);
}
assert.equal(new Set(parent.map((_,i)=>find(i))).size,1,'single connected solid');
const sub=(a,b)=>a.map((x,i)=>x-b[i]);
const dot=(a,b)=>a.reduce((s,x,i)=>s+x*b[i],0);
const cross=(a,b)=>[a[1]*b[2]-a[2]*b[1],a[2]*b[0]-a[0]*b[2],a[0]*b[1]-a[1]*b[0]];
const c=Math.SQRT1_2, d=[0,c,-c], y0=230-(127+107.95)*c,z0=10+31.75+107.95*c;
function firstHit(origin,dir) {
 let nearest=Infinity;
 for(const t of triangles) {
  const [a,b,c]=t.map(i=>vertices[i]),e1=sub(b,a),e2=sub(c,a),h=cross(dir,e2),det=dot(e1,h);
  if(Math.abs(det)<1e-10)continue;
  const inv=1/det,s=sub(origin,a),u=dot(s,h)*inv;if(u < -1e-6 || u>1.000001)continue;
  const q=cross(s,e1),v=dot(dir,q)*inv;if(v < -1e-6 || u+v>1.000001)continue;
  const dist=dot(e2,q)*inv;if(dist>1e-5)nearest=Math.min(nearest,dist);
 }
 return nearest;
}
let rays=0;
function depthAt(u,v,depth) {
 const point=[u,y0+v*c-d[1],z0+v*c-d[2]];
 const hit=firstHit(point,d)-1;
 assert.ok(Math.abs(hit-depth)<0.025,'pocket/face depth '+[u,v,hit,depth]);rays++;
}
// Probe center and inner rim of every opening, then adjacent solid material.
for(let col=0;col<4;col++)for(let row=0;row<5;row++){
 const u=16.175+25.4*col,v=12.7+25.4*row;
 for(const [du,dv] of [[0,0],[6.2,0],[-6.2,0],[0,6.2],[0,-6.2]])depthAt(u+du,v+dv,101.6);
 depthAt(u+6.5,v,0);depthAt(u,v+6.5,0);
}
for(let col=0;col<3;col++)for(let row=0;row<2;row++){
 const u=105.075+57.15*col+25.4,v=9.525+57.15*row+25.4;
 for(const [du,dv] of [[0,0],[25.3,25.3],[-25.3,25.3],[25.3,-25.3],[-25.3,-25.3]])depthAt(u+du,v+dv,101.6);
 depthAt(u+25.5,v,0);depthAt(u,v+25.5,0);
}
for(let k=0;k<3;k++){assert.ok(Math.abs(lo[k]-[0,0,-50][k])<0.01);assert.ok(Math.abs(hi[k]-[280,230,10+31.75+(127+107.95)*c][k])<0.01)}
// Mounting gap is clear, rear wall starts at y=160 and front wall at y=122.
assert.ok(Math.abs(firstHit([75,150,-5],[0,1,0])-10)<0.01);
assert.ok(Math.abs(firstHit([75,150,-5],[0,-1,0])-6)<0.01);
// Five front pockets: square 48.38 mm openings and 100 mm vertical depth.
for(let col=0;col<5;col++) {
 const x=6.35+col*(48.38+6.35)+48.38/2,y=6.35+48.38/2;
 for(const [dx,dy] of [[0,0],[24,24],[-24,24],[24,-24],[-24,-24]]) {
  assert.ok(Math.abs(firstHit([x+dx,y+dy,117.35],[0,0,-1])-101)<0.025,'front pocket depth');rays++;
 }
 assert.ok(Math.abs(firstHit([x+24.3,y,117.35],[0,0,-1])-1)<0.025,'front pocket side wall');
}
// A pen can leave the lowest row along its axis without hitting the front bins.
for(let col=0;col<4;col++) {
 const u=16.175+25.4*col,v=12.7;
 assert.equal(firstHit([u,y0+v*c-c,z0+v*c+c],[0,-c,c]),Infinity,'pen access blocked');
}
console.log(JSON.stringify({pass:true,triangles:n,components:1,watertight:true,bounds:[lo,hi],penHoles:20,squarePockets:6,frontPockets:5,frontPocketDepth:100,pocketDepth:101.6,measurementRays:rays,railGap:16},null,2));
