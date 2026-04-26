# 3d-shelves

One-off, 3D printable OpenSCAD shelves. Each design is custom-tailored to a specific bar, rail, ledge, or other mounting target.

## 77-inch industrial shelves

A family of shelves designed to hang over a 77-inch industrial bar (the bar slots between two drop walls under the shelf). Each shelf has:

- 10 mm thick top surface
- 50 mm tall × 5 mm thick rear back wall (rounded top)
- 3 × 2 mm front retaining ledge (rounded)
- Drop wall A (rear): 5 mm thick, hangs 50 mm
- Drop wall B (front): 22 mm thick, hangs 10 mm, sits 16 mm in front of A
- Three zip-tie channels under the shelf, 8 × 3 mm cross-section, rounded 1 mm: one 10 mm from the left edge, one centered, one 10 mm from the right edge

Designs come in two depths (150 mm standard, 200 mm deep) × four widths (100 / 150 / 200 / 300 mm).

### Standard depth (150 mm)

#### 100 mm wide

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-100mm_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-100mm_rear.png) |

**Download STL:** [77-inch-industrial-shelves-100mm.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-100mm.stl)

#### 150 mm wide

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-150mm_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-150mm_rear.png) |

**Download STL:** [77-inch-industrial-shelves-150mm.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-150mm.stl)

#### 200 mm wide

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-200mm_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-200mm_rear.png) |

**Download STL:** [77-inch-industrial-shelves-200mm.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-200mm.stl)

#### 300 mm wide

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-300mm_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-300mm_rear.png) |

**Download STL:** [77-inch-industrial-shelves-300mm.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-300mm.stl)

### Deep (200 mm)

#### 100 mm wide × 200 mm deep

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-100mm-deep_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-100mm-deep_rear.png) |

**Download STL:** [77-inch-industrial-shelves-100mm-deep.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-100mm-deep.stl)

#### 150 mm wide × 200 mm deep

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-150mm-deep_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-150mm-deep_rear.png) |

**Download STL:** [77-inch-industrial-shelves-150mm-deep.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-150mm-deep.stl)

#### 200 mm wide × 200 mm deep

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-200mm-deep_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-200mm-deep_rear.png) |

**Download STL:** [77-inch-industrial-shelves-200mm-deep.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-200mm-deep.stl)

#### 300 mm wide × 200 mm deep

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-300mm-deep_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-300mm-deep_rear.png) |

**Download STL:** [77-inch-industrial-shelves-300mm-deep.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/77-inch-industrial-shelves-300mm-deep.stl)

## Files

| File | Description |
|------|-------------|
| `bar_shelf.scad` | Shared shelf design (library). Reads `shelf_width_override` and `shelf_depth_override`; defaults to 150 × 150 mm. |
| `77-inch-industrial-shelves-{100,150,200,300}mm.scad` | Standard-depth (150 mm) wrappers |
| `77-inch-industrial-shelves-{100,150,200,300}mm-deep.scad` | Deep (200 mm) wrappers |
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
