# Claude Code Guidelines for 3d-shelves Project

## Project Overview

This repository contains OpenSCAD designs for one-off, 3D printable shelves. Each shelf is custom-tailored to a specific bar, ledge, monitor, rail, or other mounting target. Designs are intended for FDM printing in PLA or PETG.

Every design in this repo is a "one off" — it solves a specific problem in a specific room. There is no library of reusable parts; each `.scad` file is a complete, self-contained shelf.

---

## 1. README.md Maintenance

The `README.md` must always be kept up-to-date and include rendered images of each shelf design.

### Required Images

For **each** `.scad` file in the project, the README must display two images:

1. **Front-angle view**: Camera positioned at 45° azimuth, 45° elevation
2. **Rear-angle view**: Camera positioned at 225° azimuth, 45° elevation (the "flipped" view)

### Image Specifications

- Format: PNG
- Resolution: 800x600 pixels minimum
- Background: Transparent or neutral gray
- Naming convention: `<scad_filename>_front.png` and `<scad_filename>_rear.png`

### Camera Settings

OpenSCAD camera parameter format: `--camera=translateX,translateY,translateZ,rotX,rotY,rotZ,distance`

Use `--autocenter --viewall` to automatically frame the entire model.

Camera angles:
- **Front view**: `rotX=55, rotY=0, rotZ=45`
- **Rear view**: `rotX=55, rotY=0, rotZ=225`

### README Structure

```markdown
## Designs

### [Shelf Name]

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/<owner>/<repo>/releases/latest/download/<design>_front.png) | ![Rear](https://github.com/<owner>/<repo>/releases/latest/download/<design>_rear.png) |

[Description of what bar/rail/surface this shelf attaches to and what it holds]

**Documentation**: [design.md](<design>.md)

**Download STL**: [design.stl](https://github.com/<owner>/<repo>/releases/latest/download/<design>.stl)
```

---

## 2. OpenSCAD Coding Conventions

### Coordinate System Convention

All shelf designs use the following coordinate system (document this at the top of each file):

```openscad
/**
 * Coordinate System:
 *   X = Width  (positive = right) — across the shelf
 *   Y = Depth  (positive = back, away from viewer) — front to back of shelf
 *   Z = Height (positive = up)
 *
 * Origin: Front-left-bottom corner of the shelf body (top of the shelf surface
 *         is at Z = shelf_thickness_mm; anything hanging below the shelf has
 *         negative Z).
 */
```

### Dimension Variables

All measurements must be defined as named constants at the top of the file. **Never use hardcoded numbers in geometry.**

#### Naming Convention

Variables follow this pattern: `<scope>_<description>_mm`

- **Object-specific dimensions**: Prefix with the module/component name
  - `shelf_width_mm`, `back_wall_thickness_mm`, `drop_a_drop_mm`
- **Shared/global dimensions**: Use descriptive prefix
  - `wall_thickness_mm`, `edge_round_mm`
- **Always use `_mm` suffix** to indicate units

#### Example

```openscad
// ===========================================
// DIMENSIONS (all values in millimeters)
// ===========================================

// --- Shelf body ---
shelf_width_mm     = 25.4;   // 1 inch
shelf_depth_mm     = 150;
shelf_thickness_mm = 10;

// --- Back wall ---
back_wall_height_mm    = 50;
back_wall_thickness_mm = 5;
```

### Modular Function Design

Every distinct component must be defined in its own module:

```openscad
module shelf_body() { ... }
module back_wall() { ... }
module drop_wall_a() { ... }
module drop_wall_b() { ... }
module front_ledge() { ... }
```

### Position and Alignment Documentation

Each module must include a comment block describing position, bounding box, alignment, and what it connects to.

### Component Index Table

Include a master index of all components at the top of the file:

```openscad
/**
 * COMPONENT INDEX
 *
 * | Component        | Origin [X,Y,Z]  | Size [W,D,H]    | Attaches To      |
 * |------------------|-----------------|-----------------|------------------|
 * | shelf_body       | [0, 0, 0]       | [25.4, 150, 10] | (mounting bar)   |
 * | back_wall        | [0, 145, 10]    | [25.4, 5, 50]   | shelf_body top   |
 * | drop_wall_a      | [0, 80, -50]    | [25.4, 5, 50]   | shelf_body bot.  |
 * | drop_wall_b      | [0, 42, -10]    | [25.4, 22, 10]  | shelf_body bot.  |
 */
```

### Debug and Visualization Modules

Every SCAD file must include:

```openscad
module debug_axes(length = 50) {
    color("red")   cylinder(h=length, r=1, $fn=16);                  // Z
    color("green") rotate([0,90,0]) cylinder(h=length, r=1, $fn=16); // X
    color("blue")  rotate([-90,0,0]) cylinder(h=length, r=1, $fn=16);// Y
}

module assembly_colored() {
    color("gray")    shelf_body();
    color("blue")    back_wall();
    color("orange")  drop_wall_a();
    color("orange")  drop_wall_b();
    color("yellow")  front_ledge();
}
```

### Assembly Module

```openscad
module assembly() {
    shelf_body();
    back_wall();
    drop_wall_a();
    drop_wall_b();
    front_ledge();
}

assembly();
```

---

## 3. Documentation Files

### Per-Design Documentation

For each `.scad` file, create and maintain a corresponding `.md` file in the **same directory**.

| SCAD File | Documentation File |
|-----------|-------------------|
| `bar_shelf.scad` | `bar_shelf.md` |

### Documentation File Structure

Each `<name>.md` must contain:
- Overview (what bar/rail this shelf fits, what it holds)
- Dimensions table (every `*_mm` variable, its value, and what it controls)
- ASCII diagrams (top, side, front views)
- Components section (one entry per module)
- Assembly notes (print orientation, infill, material)
- Changelog

### Keeping Documentation in Sync

Whenever a `.scad` file is modified:
1. Update the corresponding `<name>.md` (same directory)
2. Update the component index in both files
3. Update ASCII diagrams if positions changed
4. Update `README.md` if the design's purpose or images changed

---

## 4. Build Scripts and Generated Files

The repo should contain `build.bat` (Windows) and `build.sh` (Linux/macOS) that:
1. Find all `.scad` files in the project
2. Generate STL files for each design
3. Generate front/rear PNG images
4. Output to a `build/` directory

Camera settings:
- `--autocenter --viewall`
- Front view: `--camera=0,0,0,55,0,45,0`
- Rear view: `--camera=0,0,0,55,0,225,0`
- Image size: `--imgsize=800,600`
- STL format: `--export-format=binstl`

### .gitignore

```
build/
*.stl
*.png
!assets/*.png
```

Generated artifacts go to GitHub releases, not the repo.

---

## 5. Workflow Summary

1. **Design**: Create a new `.scad` file for the new shelf (one file per shelf)
2. **Document**: Create `<name>.md` with dimensions, diagrams, and notes
3. **Build locally**: Run `build.bat` / `build.sh` to generate STL + previews
4. **README**: Add a section linking the design's docs and release artifacts
5. **Release**: GitHub Actions generates artifacts and attaches them to a release

---

## 6. Required Updates Checklist

When creating or modifying a `.scad` file:

- [ ] Coordinate system documented at top
- [ ] All dimensions as named variables (no hardcoded numbers)
- [ ] Variables follow `<scope>_<description>_mm` convention
- [ ] Component index table updated
- [ ] Each module has position/bounding-box comments
- [ ] Debug modules included (axes, colored assembly)
- [ ] `<name>.md` created/updated in same directory
- [ ] `README.md` updated with new design entry
