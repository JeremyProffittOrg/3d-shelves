#!/usr/bin/env bash
# Build STL files and PNG previews for every wrapper SCAD file.
# Wrappers are bar_shelf_*.scad. The library file bar_shelf.scad is skipped.

set -euo pipefail

OPENSCAD="${OPENSCAD:-openscad}"
OUT_STL=build/stl
OUT_IMG=build/images

mkdir -p "$OUT_STL" "$OUT_IMG"

CAMERA_FRONT="0,0,0,55,0,45,0"
CAMERA_REAR="0,0,0,55,0,225,0"
IMG_SIZE="800,600"

for f in 77-inch-industrial-shelves-*.scad 72-inch-cosco-shelves-*.scad; do
    base="${f%.scad}"
    echo "=== Building $base ==="
    "$OPENSCAD" -o "$OUT_STL/$base.stl" "$f"
    "$OPENSCAD" -o "$OUT_IMG/${base}_front.png" --camera=$CAMERA_FRONT --imgsize=$IMG_SIZE --autocenter --viewall --colorscheme=Tomorrow "$f"
    "$OPENSCAD" -o "$OUT_IMG/${base}_rear.png"  --camera=$CAMERA_REAR  --imgsize=$IMG_SIZE --autocenter --viewall --colorscheme=Tomorrow "$f"
done

echo
echo "=== Build complete ==="
ls -la "$OUT_STL" "$OUT_IMG"
