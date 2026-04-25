# 3d-shelves

One-off, 3D printable OpenSCAD shelves. Each design is custom-tailored to a specific bar, rail, ledge, or other mounting target.

All shelves below are designed to hang over a bar (the bar slots between two drop walls under the shelf) and have:

- 150 mm deep × 10 mm thick top surface
- 50 mm tall × 5 mm thick rear back wall (rounded top)
- 3 × 2 mm front retaining ledge (rounded)
- Drop wall A (rear): 5 mm thick, hangs 50 mm
- Drop wall B (front): 22 mm thick, hangs 10 mm, sits 16 mm in front of A
- Three zip-tie channels under the shelf, 8 × 3 mm cross-section, rounded 1 mm: one 10 mm from the left edge, one centered, one 10 mm from the right edge

The four designs differ only in width.

## Designs

### bar_shelf_100mm — 100 mm wide

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/bar_shelf_100mm_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/bar_shelf_100mm_rear.png) |

**Download STL:** [bar_shelf_100mm.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/bar_shelf_100mm.stl)

### bar_shelf_150mm — 150 mm wide

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/bar_shelf_150mm_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/bar_shelf_150mm_rear.png) |

**Download STL:** [bar_shelf_150mm.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/bar_shelf_150mm.stl)

### bar_shelf_200mm — 200 mm wide

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/bar_shelf_200mm_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/bar_shelf_200mm_rear.png) |

**Download STL:** [bar_shelf_200mm.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/bar_shelf_200mm.stl)

### bar_shelf_300mm — 300 mm wide

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/bar_shelf_300mm_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/bar_shelf_300mm_rear.png) |

**Download STL:** [bar_shelf_300mm.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/bar_shelf_300mm.stl)

## Files

| File | Description |
|------|-------------|
| `bar_shelf.scad` | Shared shelf design (library). Reads `shelf_width_override` if set; otherwise renders 150 mm wide. |
| `bar_shelf_100mm.scad` | 100 mm wide wrapper |
| `bar_shelf_150mm.scad` | 150 mm wide wrapper |
| `bar_shelf_200mm.scad` | 200 mm wide wrapper |
| `bar_shelf_300mm.scad` | 300 mm wide wrapper |
| `build.bat` / `build.sh` | Build all STLs and PNG previews into `build/` |
| `.github/workflows/build-release.yml` | CI: builds artifacts and publishes the `latest` GitHub release on every push to `main` |

## Build locally

```bash
# Linux/macOS
./build.sh

# Windows
build.bat
```

Outputs land in `build/stl/` and `build/images/`.

## Print settings

- Material: PLA or PETG
- Layer height: 0.2 mm
- Infill: 20–30 %
- Supports: none required
- Orientation: shelf top face down (drop walls pointing up)

## Conventions

See [CLAUDE.md](CLAUDE.md) for project conventions (coordinate system, naming, modular design, documentation).
