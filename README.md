# 3d-shelves

One-off, 3D printable OpenSCAD shelves. Each design is custom-tailored to a specific bar, rail, ledge, or other mounting target.

## Shelf profiles

A *profile* describes the bar / rail / lip the shelf hangs over. The shelf top surface, back wall, and front ledge stay the same across profiles; only the two drop walls under the shelf change to fit a different bar.

These six numbers fully define a profile in `bar_shelf.scad`:

| Variable | Meaning |
|----------|---------|
| `shelf_back_depth_mm`     | Distance from the shelf's back edge to the back face of the bar (= how far the shelf overhangs behind the bar). *Currently named `drop_a_offset_from_back_mm` in code — pending rename.* |
| `drop_a_thickness_mm`     | Y-thickness (front-to-back) of the rear drop wall. |
| `rear_wall_height_mm`     | How far the rear drop wall hangs below the shelf. |
| `border_ridge_mm`         | Front-to-back thickness of the bar (the gap between the two drop walls). |
| `border_depth_mm`         | Y-thickness of the front drop wall. |
| `border_height_mm`        | How far the front drop wall hangs below the shelf. |

### 77-inch industrial

| Parameter | Value |
|-----------|------:|
| `shelf_back_depth_mm`  | 65 mm |
| `drop_a_thickness_mm`  | 5 mm  |
| `rear_wall_height_mm`  | 50 mm |
| `border_ridge_mm`      | 16 mm |
| `border_depth_mm`      | 22 mm |
| `border_height_mm`     | 10 mm |

### 72-inch Cosco

| Parameter | Value | Source |
|-----------|------:|:------|
| `shelf_back_depth_mm`  | 65 mm              | inherited from 77-inch industrial |
| `drop_a_thickness_mm`  | 5 mm               | inherited from 77-inch industrial |
| `rear_wall_height_mm`  | 5 mm               | Cosco-specific |
| `border_ridge_mm`      | 25.4 mm            | 1″ |
| `border_depth_mm`      | 19.05 mm           | ¾″ |
| `border_height_mm`     | 9.525 mm           | ⅜″ |

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

## 72-inch Cosco shelves

Same shelf design as the 77-inch industrial set, but tuned for a 72-inch Cosco rail (1″ bar with a ¾″ × ⅜″ front lip; see [Shelf profiles → 72-inch Cosco](#72-inch-cosco) for the dimension table). Available in two depths × four widths.

### Standard depth (150 mm)

#### 100 mm wide

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-100mm_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-100mm_rear.png) |

**Download STL:** [72-inch-cosco-shelves-100mm.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-100mm.stl)

#### 150 mm wide

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-150mm_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-150mm_rear.png) |

**Download STL:** [72-inch-cosco-shelves-150mm.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-150mm.stl)

#### 200 mm wide

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-200mm_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-200mm_rear.png) |

**Download STL:** [72-inch-cosco-shelves-200mm.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-200mm.stl)

#### 300 mm wide

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-300mm_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-300mm_rear.png) |

**Download STL:** [72-inch-cosco-shelves-300mm.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-300mm.stl)

### Deep (200 mm)

#### 100 mm wide × 200 mm deep

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-100mm-deep_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-100mm-deep_rear.png) |

**Download STL:** [72-inch-cosco-shelves-100mm-deep.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-100mm-deep.stl)

#### 150 mm wide × 200 mm deep

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-150mm-deep_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-150mm-deep_rear.png) |

**Download STL:** [72-inch-cosco-shelves-150mm-deep.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-150mm-deep.stl)

#### 200 mm wide × 200 mm deep

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-200mm-deep_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-200mm-deep_rear.png) |

**Download STL:** [72-inch-cosco-shelves-200mm-deep.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-200mm-deep.stl)

#### 300 mm wide × 200 mm deep

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-300mm-deep_front.png) | ![Rear](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-300mm-deep_rear.png) |

**Download STL:** [72-inch-cosco-shelves-300mm-deep.stl](https://github.com/JeremyProffitt/3d-shelves/releases/latest/download/72-inch-cosco-shelves-300mm-deep.stl)

## Files

| File | Description |
|------|-------------|
| `bar_shelf.scad` | Shared shelf design (library). Reads `shelf_width_override`, `shelf_depth_override`, `border_ridge_override`, `border_depth_override`, `border_height_override`, `rear_wall_height_override`. Defaults to the 77-inch industrial profile, 150 × 150 mm. |
| `77-inch-industrial-shelves-{100,150,200,300}mm.scad` | 77-inch standard-depth (150 mm) wrappers |
| `77-inch-industrial-shelves-{100,150,200,300}mm-deep.scad` | 77-inch deep (200 mm) wrappers |
| `72-inch-cosco-profile.scad` | Cosco profile overrides — included by every Cosco wrapper |
| `72-inch-cosco-shelves-{100,150,200,300}mm.scad` | Cosco standard-depth (150 mm) wrappers |
| `72-inch-cosco-shelves-{100,150,200,300}mm-deep.scad` | Cosco deep (200 mm) wrappers |
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

## Angled pen and square-pocket organizer

280 x 200 mm industrial rail shelf with 20 pen holes (4 across x 5 high) and six 2-inch square pockets. Openings face upward at 45 degrees; all pockets are 4 inches deep with closed ends.

| Front view | Rear view |
|---|---|
| ![Front](https://github.com/JeremyProffittOrg/3d-shelves/releases/latest/download/77-inch-industrial-shelves-280mm-deep-organizer_front.png) | ![Rear](https://github.com/JeremyProffittOrg/3d-shelves/releases/latest/download/77-inch-industrial-shelves-280mm-deep-organizer_rear.png) |

[Design details](77-inch-industrial-shelves-280mm-deep-organizer.md) · [OpenSCAD source](77-inch-industrial-shelves-280mm-deep-organizer.scad) · [STL](https://github.com/JeremyProffittOrg/3d-shelves/releases/latest/download/77-inch-industrial-shelves-280mm-deep-organizer.stl)

Printer fit, supports and load capacity need review for this taller design; the bare-shelf print recommendations above do not apply automatically.
