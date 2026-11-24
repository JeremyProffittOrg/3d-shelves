# 280 x 230 mm industrial rail shelf with angled organizer

Integral organizer on the existing industrial rail shelf. All openings face forward and upward at 45 degrees. Pockets have closed ends. The 16 mm rail gap, drop walls, rear wall, retaining lip and zip-tie channels use the original shelf geometry.

## Dimensions
- Shelf footprint: 280 x 230 mm.
- Complete bounding box: X 0..280, Y 0..230, Z -50..207.8847 mm (257.8847 mm total height).
- Organizer face: 280 mm across x 127 mm along the slope.
- Pens: 4 columns x 5 rows, 20 holes; 12.7 mm diameter, 12.7 mm clear gaps (25.4 mm pitch).
- Square pockets: 3 columns x 2 rows; 50.8 x 50.8 mm clear openings; 6.35 mm clear gaps.
- All pockets: 101.6 mm deep along the 45-degree axis, with 6.35 mm minimum end material.
- The clarification "yes" was interpreted as 4 across x 5 high, not a 5-inch overall vertical height.

- Front row: five 48.38 x 48.38 mm square openings, 20 mm vertically from floor to opening; 6.35 mm walls and floors.
- Front rim at Z 36.35 mm. Angled organizer raised 31.75 mm so its lowest openings remain accessible.

## Views
Front (face-local view):
```
 o o o o    +-----+ +-----+ +-----+
 o o o o    |     | |     | |     |
 o o o o    +-----+ +-----+ +-----+
 o o o o    +-----+ +-----+ +-----+
 o o o o    |     | |     | |     |
            +-----+ +-----+ +-----+
 [__] [__] [__] [__] [__]  front bins open upward
```
Side (front at left):
```
             /\
   openings /  \ closed back
           /    \
           |     |
    =======|=====|=== shelf
            | |      rail capture walls
```
Top: 280 x 230 mm shelf; organizer spans full width and Y 63.8653..230 mm. The original rear wall at Y 225..230 mm is integrated into the organizer body.

## Components
- shelf_body, back_wall, front_ledge, drop_wall_a, drop_wall_b, zip_tie_slots: original shelf geometry, sized 280 x 230 mm.
- organizer_frame: local-to-world transform. Local v runs uphill; local w runs down and rearward into the pockets.
- organizer_outer: closed extruded polygon with a flat foot; overlaps shelf by 0.5 mm.
- pen_voids: twenty cylindrical blind cutters.
- bin_voids: six square blind cutters.
- organizer_block: outer body minus pocket cutters.
- front_bins: five square top-opening pockets, 20 mm usable vertical depth, across the full front width.
- organizer_assembly: union of shelf, raised angled organizer and front bins.
- debug_axes, assembly_colored and organizer_assembly_colored: inspection helpers.

## Assembly and printing
Single integral mesh. No glue or bolts are needed between organizer and shelf. Material, load capacity, supports and print orientation require printer-specific review. Do not reuse the original bare-shelf no-support recommendation for this taller organizer. H2D and H3C projects are built from installed 0.4 mm nozzle profiles with 0.20 mm Standard process, Generic PLA and automatic supports. The 280 mm width leaves more placement clearance than the original 300 mm model. No printing is performed. The rail fit has not been physically tested with the added load.

## Verification
Run from C:/dev/archive/3d-shelves:
```bat
"C:\Program Files\OpenSCAD\openscad.com" --export-format=binstl -o "build\stl\77-inch-industrial-shelves-280mm-deep-organizer.stl" "77-inch-industrial-shelves-280mm-deep-organizer.scad"
node verify-organizer.mjs
```
The mesh check tests manifold edges, consistent face winding, one connected component, bounds, 182 pocket/face depth probes, and the rail capture gap. Previews are generated through OpenSCAD CLI; Bambu Studio is opened through its CLI only.

## Changelog
2026-11-23: Added the original 300 x 200 mm shelf with 20 angled pen holes and six angled square pockets.
2026-11-23: Reduced width to 280 mm, preserved pocket and rail dimensions, and added printer-specific project generation and fit verification.

## Dimension variable reference

| Variable | Value / derivation (mm) |
|---|---|
| shelf_width_mm | is_undef(shelf_width_override) ? 280 : shelf_width_override |
| shelf_depth_mm | is_undef(shelf_depth_override) ? 230 : shelf_depth_override |
| shelf_thickness_mm | 10 |
| shelf_bottom_round_mm | 2 |
| back_wall_height_mm | 50 |
| back_wall_thickness_mm | 5 |
| back_wall_top_round_mm | 2 |
| front_ledge_depth_mm | 2 |
| front_ledge_height_mm | 3 |
| front_ledge_round_mm | 0.75 |
| drop_a_offset_from_back_mm | 65 |
| drop_a_thickness_mm | 5 |
| rear_wall_height_mm | is_undef(rear_wall_height_override) ? 50 : rear_wall_height_override |
| drop_a_round_mm | 1 |
| border_ridge_mm | is_undef(border_ridge_override)  ? 16 : border_ridge_override |
| border_depth_mm | is_undef(border_depth_override)  ? 22 : border_depth_override |
| border_height_mm | is_undef(border_height_override) ? 10 : border_height_override |
| drop_b_round_mm | 1 |
| zip_tie_slot_x_mm | 8 |
| zip_tie_slot_z_mm | 3 |
| zip_tie_round_mm | 1 |
| zip_tie_offset_mm | 10 |
| zip_tie_edge_inset_mm | 10 |
| pen_diameter_mm | 12.7 |
| pen_clear_gap_mm | 12.7 |
| pocket_depth_mm | 101.6 |
| organizer_wall_mm | 6.35 |
| organizer_lift_mm | 31.75 |
| front_bin_depth_mm | 20 |
| front_bin_wall_mm | 6.35 |
| front_bin_floor_mm | 6.35 |
| front_bin_size_mm | (shelf_width_mm - (front_bin_count+1)*front_bin_wall_mm)/front_bin_count |
| front_bin_floor_z_mm | shelf_thickness_mm + front_bin_floor_mm |
| front_bin_top_z_mm | front_bin_floor_z_mm + front_bin_depth_mm |
| organizer_join_mm | 0.5 |
| cut_overshoot_mm | 1 |
| bin_size_mm | 50.8 |
| bin_clear_gap_mm | 6.35 |
| pen_pitch_mm | pen_diameter_mm + pen_clear_gap_mm |
| pen_span_x_mm | pen_columns * pen_diameter_mm + (pen_columns - 1) * pen_clear_gap_mm |
| pen_span_v_mm | pen_rows * pen_diameter_mm + (pen_rows - 1) * pen_clear_gap_mm |
| bin_span_x_mm | bin_columns * bin_size_mm + (bin_columns - 1) * bin_clear_gap_mm |
| bin_span_v_mm | bin_rows * bin_size_mm + (bin_rows - 1) * bin_clear_gap_mm |
| organizer_face_height_mm | pen_span_v_mm + 2 * organizer_wall_mm |
| organizer_body_depth_mm | pocket_depth_mm + organizer_wall_mm |
| organizer_footprint_mm | organizer_face_height_mm * organizer_cos + organizer_body_depth_mm * organizer_sin |
| organizer_front_y_mm | shelf_depth_mm - organizer_footprint_mm |
| organizer_face_z_mm | shelf_thickness_mm + organizer_lift_mm + organizer_body_depth_mm * organizer_cos |
| organizer_peak_z_mm | organizer_face_z_mm + organizer_face_height_mm * organizer_sin |
| organizer_back_y_mm | organizer_front_y_mm + organizer_footprint_mm |
| organizer_edge_x_mm | (shelf_width_mm - pen_span_x_mm - organizer_wall_mm - bin_span_x_mm) / 2 |
| bin_start_x_mm | organizer_edge_x_mm + pen_span_x_mm + organizer_wall_mm |
| bin_start_v_mm | (organizer_face_height_mm - bin_span_v_mm) / 2 |

## Printer-specific project build

Internal build helper: `python build-organizer-projects.py H2D H3C`. It resolves installed preset inheritance, enables automatic supports, disables the unneeded prime tower for this single-material part, arranges and slices, then checks the exported 3MF against the actual printer build volume and individual nozzle reach. No print is transmitted. Files are written under `build/organizer/h2d/` and `build/organizer/h3c/`.

Command-line reference: https://github.com/bambulab/BambuStudio/wiki/Command-Line-Usage

2026-11-23: Added five 20 mm deep top-opening square front bins. Extended shelf depth to 230 mm, moved organizer flush to the rear and raised it 31.75 mm to retain access. Uses normal automatic supports for the broad flat underside.


2026-11-23: Front compartments reduced to 20 mm usable vertical depth at the user’s request. Remaining geometry unchanged.
