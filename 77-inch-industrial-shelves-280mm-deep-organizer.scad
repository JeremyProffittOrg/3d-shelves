/**
 * 77-inch-industrial-shelves-280mm-deep-organizer.scad — 280 x 230 rail shelf with angled organizer.
 *
 * Coordinate System:
 *   X = Width  (positive = right) — across the shelf
 *   Y = Depth  (positive = back)  — front (Y=0) to back (Y=shelf_depth_mm)
 *   Z = Height (positive = up)
 *
 * Origin: Front-left-bottom corner of the shelf body.
 *   - Top of the shelf surface is at Z = shelf_thickness_mm.
 *   - Drop walls hang below the shelf at negative Z.
 *   - Back wall stands above the shelf at Z > shelf_thickness_mm.
 *
 * COMPONENT INDEX
 *
 * | Component    | Origin [X,Y,Z]   | Size [W,D,H]      | Attaches To       |
 * |--------------|------------------|-------------------|-------------------|
 * | shelf_body   | [0,    0,    0]  | [280, 230,  10]  | (sits on bar)     |
 * | back_wall    | [0,  225,   10]  | [280,   5,  50]  | shelf_body top    |
 * | front_ledge  | [0,    0,   10]  | [280,   2,   3]  | shelf_body top    |
 * | drop_wall_a  | [0,  160,  -50]  | [280,   5,  50]  | shelf_body bottom |
 * | drop_wall_b  | [0,  122,  -10]  | [280,  22,  10]  | shelf_body bottom |
 */

$fn = 64;

// ===========================================
// DIMENSIONS (all values in millimeters)
// ===========================================

// --- shelf body ---
// shelf_width_mm and shelf_depth_mm can be overridden by a wrapper file by
// setting `shelf_width_override` / `shelf_depth_override` BEFORE doing
// `include<bar-shelf.scad>`.
shelf_width_mm     = is_undef(shelf_width_override) ? 280 : shelf_width_override;
shelf_depth_mm     = is_undef(shelf_depth_override) ? 230 : shelf_depth_override;
shelf_thickness_mm = 10;
shelf_bottom_round_mm = 2;   // Fillet on bottom-front and bottom-back edges

// --- back wall (above shelf) ---
back_wall_height_mm    = 50;
back_wall_thickness_mm = 5;
back_wall_top_round_mm = 2;  // Round on top edges

// --- front ledge (small lip on top of shelf, front edge) ---
front_ledge_depth_mm  = 2;   // Y dimension
front_ledge_height_mm = 3;   // Z dimension above shelf top
front_ledge_round_mm  = 0.75;

// --- drop wall A (rear drop wall, hangs below shelf) ---
// "65mm from the back edge": back face of wall A is 65mm in from the shelf's back edge.
drop_a_offset_from_back_mm = 65;
drop_a_thickness_mm = 5;   // Y dimension
rear_wall_height_mm = is_undef(rear_wall_height_override) ? 50 : rear_wall_height_override;
drop_a_round_mm     = 1;   // Edge fillet

// --- front border (the front lip / bar feature the shelf catches on) ---
// border_ridge_mm  = front-to-back thickness of the bar where it sits between
//                    the two drop walls (was: drop_b_gap_to_a_mm).
// border_depth_mm  = Y-thickness of the front drop wall (was: drop_b_thickness_mm).
// border_height_mm = how far the front drop wall hangs below the shelf
//                    (was: drop_b_drop_mm).
border_ridge_mm  = is_undef(border_ridge_override)  ? 16 : border_ridge_override;
border_depth_mm  = is_undef(border_depth_override)  ? 22 : border_depth_override;
border_height_mm = is_undef(border_height_override) ? 10 : border_height_override;
drop_b_round_mm  = 1;

// --- zip tie slots (three slots under the shelf) ---
// Each slot is 8mm wide (X) by 3mm high (Z), running in Y from 10mm before
// the front-most drop wall to 10mm after the rear-most drop wall. Each
// slot's bottom is flush with the shelf bottom (Z = 0) and opens through
// the underside. Long edges (running in Y) are rounded with radius 1mm.
//
// There are three slots: one 10mm from the left edge, one centered in X,
// and one 10mm from the right edge.
zip_tie_slot_x_mm     = 8;   // X dimension of each slot
zip_tie_slot_z_mm     = 3;   // Z dimension of each slot
zip_tie_round_mm      = 1;
zip_tie_offset_mm     = 10;  // Distance between slot Y end and nearest wall face
zip_tie_edge_inset_mm = 10;  // Distance from shelf X edge to outer slot edge

// --- derived Y positions for drop walls (Y=0 = front, Y=shelf_depth_mm = back) ---
drop_a_back_y  = shelf_depth_mm - drop_a_offset_from_back_mm;   // 85
drop_a_front_y = drop_a_back_y  - drop_a_thickness_mm;          // 80
drop_b_back_y  = drop_a_front_y - border_ridge_mm;              // 64
drop_b_front_y = drop_b_back_y  - border_depth_mm;              // 42

// --- derived positions for the zip tie slots ---
zip_tie_slot_y_front = drop_b_front_y - zip_tie_offset_mm;  // 32
zip_tie_slot_y_back  = drop_a_back_y  + zip_tie_offset_mm;  // 95

// ===========================================
// MODULES
// ===========================================

/**
 * shelf_body
 *
 * Position:    Origin [0, 0, 0]
 * Bounding:    [0, 0, 0] to [280, 230, 10]
 * Notes:       Bottom-front and bottom-back edges are filleted with radius
 *              shelf_bottom_round_mm. Top is left sharp so the back_wall and
 *              front_ledge meet it cleanly. Three zip-tie slots are subtracted
 *              from the body (running front-to-back under the shelf).
 */
module shelf_body() {
    r = shelf_bottom_round_mm;
    hull() {
        // Bottom-front rounded edge: cylinder running along X
        translate([0, r, r])
            rotate([0, 90, 0])
                cylinder(h=shelf_width_mm, r=r);
        // Bottom-back rounded edge
        translate([0, shelf_depth_mm - r, r])
            rotate([0, 90, 0])
                cylinder(h=shelf_width_mm, r=r);
        // Top-front sharp edge
        translate([0, 0, shelf_thickness_mm - 0.01])
            cube([shelf_width_mm, 0.01, 0.01]);
        // Top-back sharp edge
        translate([0, shelf_depth_mm - 0.01, shelf_thickness_mm - 0.01])
            cube([shelf_width_mm, 0.01, 0.01]);
    }
}

/**
 * zip_tie_slot — one rounded zip-tie channel located at X=[x_min, x_min+W].
 *
 * Cross-section is zip_tie_slot_x_mm (X) by zip_tie_slot_z_mm (Z); bottom
 * flush with shelf bottom (Z = 0); long edges rounded with zip_tie_round_mm.
 * Runs in Y from zip_tie_slot_y_front to zip_tie_slot_y_back.
 */
module zip_tie_slot(x_min) {
    r = zip_tie_round_mm;
    x_max = x_min + zip_tie_slot_x_mm;
    z_max = zip_tie_slot_z_mm;
    y_len = zip_tie_slot_y_back - zip_tie_slot_y_front;
    hull() {
        for (x = [x_min + r, x_max - r], z = [r, z_max - r]) {
            translate([x, zip_tie_slot_y_front, z])
                rotate([-90, 0, 0])
                    cylinder(h = y_len, r = r);
        }
    }
}

/**
 * zip_tie_slots — three slots: 10mm from left, centered, 10mm from right.
 */
module zip_tie_slots() {
    zip_tie_slot(zip_tie_edge_inset_mm);                                          // left
    zip_tie_slot((shelf_width_mm - zip_tie_slot_x_mm) / 2);                       // middle
    zip_tie_slot(shelf_width_mm - zip_tie_edge_inset_mm - zip_tie_slot_x_mm);     // right
}

/**
 * back_wall
 *
 * Position:    Origin [0, shelf_depth_mm - back_wall_thickness_mm, shelf_thickness_mm]
 * Bounding:    [0, 225, 10] to [280, 230, 60]
 * Notes:       Sits flush on top of the rear edge of the shelf.
 *              Top edges (front-top and back-top, running along X) are rounded.
 *              Bottom is sharp where it meets the shelf top.
 */
module back_wall() {
    r = back_wall_top_round_mm;
    base_z = shelf_thickness_mm;
    top_z  = base_z + back_wall_height_mm;
    front_y = shelf_depth_mm - back_wall_thickness_mm;
    back_y  = shelf_depth_mm;

    hull() {
        // Bottom slab — sharp, sits on shelf top
        translate([0, front_y, base_z])
            cube([shelf_width_mm, back_wall_thickness_mm, 0.01]);
        // Top-front rounded edge: cylinder along X
        translate([0, front_y + r, top_z - r])
            rotate([0, 90, 0])
                cylinder(h=shelf_width_mm, r=r);
        // Top-back rounded edge
        translate([0, back_y - r, top_z - r])
            rotate([0, 90, 0])
                cylinder(h=shelf_width_mm, r=r);
    }
}

/**
 * front_ledge
 *
 * Position:    Origin [0, 0, shelf_thickness_mm]
 * Bounding:    [0, 0, 10] to [280, 2, 13]
 * Notes:       Small upturned lip along the front edge of the shelf to keep
 *              items from sliding off. 3mm tall, 2mm thick (Y), with rounded
 *              top edges.
 */
module front_ledge() {
    r = front_ledge_round_mm;
    base_z = shelf_thickness_mm;
    top_z  = base_z + front_ledge_height_mm;

    hull() {
        // Bottom — sharp, flush with shelf top
        translate([0, 0, base_z])
            cube([shelf_width_mm, front_ledge_depth_mm, 0.01]);
        // Top-front rounded edge
        translate([0, r, top_z - r])
            rotate([0, 90, 0])
                cylinder(h=shelf_width_mm, r=r);
        // Top-back rounded edge
        translate([0, front_ledge_depth_mm - r, top_z - r])
            rotate([0, 90, 0])
                cylinder(h=shelf_width_mm, r=r);
    }
}

/**
 * drop_wall — generic hanging wall under the shelf with rounded bottom edges.
 *
 * Top of the wall extends slightly UP into the shelf body to ensure a clean
 * union with shelf_body (no flicker / no rounded top corners visible).
 */
module drop_wall(y_front, y_back, drop, r) {
    overlap = 2;  // Extends into shelf body for clean union
    hull() {
        // Bottom-front rounded edge
        translate([0, y_front + r, -drop + r])
            rotate([0, 90, 0])
                cylinder(h=shelf_width_mm, r=r);
        // Bottom-back rounded edge
        translate([0, y_back - r, -drop + r])
            rotate([0, 90, 0])
                cylinder(h=shelf_width_mm, r=r);
        // Top — sharp, extends into shelf
        translate([0, y_front, overlap - 0.01])
            cube([shelf_width_mm, y_back - y_front, 0.01]);
    }
}

/**
 * drop_wall_a (rear drop wall)
 *
 * Position:   [0, drop_a_front_y, -rear_wall_height_mm]
 * Bounding:   [0, 160, -50] to [280, 165, 0]
 */
module drop_wall_a() {
    drop_wall(drop_a_front_y, drop_a_back_y, rear_wall_height_mm, drop_a_round_mm);
}

/**
 * drop_wall_b (front drop wall)
 *
 * Position:   [0, drop_b_front_y, -border_height_mm]
 * Bounding:   [0, 122, -10] to [280, 144, 0]
 */
module drop_wall_b() {
    drop_wall(drop_b_front_y, drop_b_back_y, border_height_mm, drop_b_round_mm);
}

// ===========================================
// DEBUG / VISUALIZATION
// ===========================================

module debug_axes(length = 50) {
    color("red")   cylinder(h=length, r=1, $fn=16);                  // Z
    color("green") rotate([0,90,0])  cylinder(h=length, r=1, $fn=16);// X
    color("blue")  rotate([-90,0,0]) cylinder(h=length, r=1, $fn=16);// Y
}

module assembly_colored() {
    color("gray")    shelf_body();
    color("steelblue") back_wall();
    color("gold")    front_ledge();
    color("orange")  drop_wall_a();
    color("orange")  drop_wall_b();
}

// ===========================================
// ASSEMBLY
// ===========================================

module assembly() {
    difference() {
        union() {
            shelf_body();
            back_wall();
            front_ledge();
            drop_wall_a();
            drop_wall_b();
        }
        zip_tie_slots();
    }
}


// ORGANIZER DIMENSIONS: face coordinates u across, v uphill, w inward.
pen_columns = 4;
pen_rows = 5;
pen_diameter_mm = 12.7;
pen_clear_gap_mm = 12.7;
pocket_depth_mm = 101.6;
organizer_wall_mm = 6.35;
organizer_lift_mm = 31.75;
front_bin_count = 5;
front_bin_depth_mm = 20;
front_bin_wall_mm = 6.35;
front_bin_floor_mm = 6.35;
front_bin_size_mm = (shelf_width_mm - (front_bin_count+1)*front_bin_wall_mm)/front_bin_count;
front_bin_floor_z_mm = shelf_thickness_mm + front_bin_floor_mm;
front_bin_top_z_mm = front_bin_floor_z_mm + front_bin_depth_mm;
organizer_angle_deg = 45;
organizer_join_mm = 0.5;
cut_overshoot_mm = 1;
bin_size_mm = 50.8;
bin_clear_gap_mm = 6.35;
bin_columns = 3;
bin_rows = 2;
pen_pitch_mm = pen_diameter_mm + pen_clear_gap_mm;
pen_span_x_mm = pen_columns * pen_diameter_mm + (pen_columns - 1) * pen_clear_gap_mm;
pen_span_v_mm = pen_rows * pen_diameter_mm + (pen_rows - 1) * pen_clear_gap_mm;
bin_span_x_mm = bin_columns * bin_size_mm + (bin_columns - 1) * bin_clear_gap_mm;
bin_span_v_mm = bin_rows * bin_size_mm + (bin_rows - 1) * bin_clear_gap_mm;
organizer_face_height_mm = pen_span_v_mm + 2 * organizer_wall_mm;
organizer_body_depth_mm = pocket_depth_mm + organizer_wall_mm;
organizer_cos = cos(organizer_angle_deg);
organizer_sin = sin(organizer_angle_deg);
organizer_footprint_mm = organizer_face_height_mm * organizer_cos + organizer_body_depth_mm * organizer_sin;
organizer_front_y_mm = shelf_depth_mm - organizer_footprint_mm;
organizer_face_z_mm = shelf_thickness_mm + organizer_lift_mm + organizer_body_depth_mm * organizer_cos;
organizer_peak_z_mm = organizer_face_z_mm + organizer_face_height_mm * organizer_sin;
organizer_back_y_mm = organizer_front_y_mm + organizer_footprint_mm;
organizer_edge_x_mm = (shelf_width_mm - pen_span_x_mm - organizer_wall_mm - bin_span_x_mm) / 2;
bin_start_x_mm = organizer_edge_x_mm + pen_span_x_mm + organizer_wall_mm;
bin_start_v_mm = (organizer_face_height_mm - bin_span_v_mm) / 2;

assert(organizer_front_y_mm >= front_ledge_depth_mm);
assert(organizer_back_y_mm <= shelf_depth_mm);
assert(organizer_front_y_mm >= front_bin_size_mm + 2*front_bin_wall_mm);
assert(organizer_face_z_mm > front_bin_top_z_mm);
assert(organizer_edge_x_mm >= organizer_wall_mm);
assert(bin_start_v_mm >= organizer_wall_mm);

// COMPONENT INDEX (in addition to the unchanged shelf components above):
// organizer_outer: [0,63.8653,9.5] to [280,230,207.8847]; joins shelf and absorbs back wall.
// front_bins: five 48.38 mm square openings, 20 mm vertical depth; top Z=36.35.
// pen_voids: 20 diameter-12.7 blind bores; 101.6 axial depth; v=12.7..114.3.
// bin_voids: 6 square-50.8 blind pockets; 101.6 axial depth; 6.35 clear gaps.
// organizer_block: outer less voids, closed ends and solid support to shelf.

// Maps face-local (u,v,w) into XYZ. Positive w goes rearward and downward.
// Origin [0,organizer_front_y_mm,organizer_face_z_mm]; attaches cutters to face.
module organizer_frame() {
    multmatrix([[1,0,0,0],
                [0,organizer_cos,organizer_sin,organizer_front_y_mm],
                [0,organizer_sin,-organizer_cos,organizer_face_z_mm],
                [0,0,0,1]]) children();
}

// Extruded side polygon, full shelf width; underside overlaps shelf by 0.5 mm.
// Bound [0,front,9.5]..[280,back,peak]; closed roof/back and solid foot.
module organizer_outer() {
    multmatrix([[0,0,1,0],[1,0,0,0],[0,1,0,0],[0,0,0,1]])
        linear_extrude(height=shelf_width_mm)
            polygon([
                [organizer_front_y_mm, shelf_thickness_mm-organizer_join_mm],
                [organizer_front_y_mm, organizer_face_z_mm],
                [organizer_front_y_mm+organizer_face_height_mm*organizer_cos, organizer_peak_z_mm],
                [organizer_back_y_mm, organizer_peak_z_mm-organizer_body_depth_mm*organizer_cos],
                [organizer_back_y_mm, shelf_thickness_mm-organizer_join_mm]
            ]);
}

// Twenty blind bores, four columns and five rows on the left of the face.
// Each cutter starts 1 mm outside the face and ends exactly 101.6 mm inward.
module pen_voids() {
    organizer_frame()
        for (col=[0:pen_columns-1], row=[0:pen_rows-1])
            translate([organizer_edge_x_mm+pen_diameter_mm/2+col*pen_pitch_mm,
                       organizer_wall_mm+pen_diameter_mm/2+row*pen_pitch_mm,
                       -cut_overshoot_mm])
                cylinder(d=pen_diameter_mm,h=pocket_depth_mm+cut_overshoot_mm);
}

// Six square pockets occupy the remaining face, three columns by two rows.
// Local bound [bin_start_x,bin_start_v,-1] to [270.175,117.475,101.6].
module bin_voids() {
    organizer_frame()
        for (col=[0:bin_columns-1], row=[0:bin_rows-1])
            translate([bin_start_x_mm+col*(bin_size_mm+bin_clear_gap_mm),
                       bin_start_v_mm+row*(bin_size_mm+bin_clear_gap_mm),
                       -cut_overshoot_mm])
                cube([bin_size_mm,bin_size_mm,pocket_depth_mm+cut_overshoot_mm]);
}

// Integral organizer: blind pockets do not cut through the shelf or rail mount.
module organizer_block() {
    difference() {
        organizer_outer();
        pen_voids();
        bin_voids();
    }
}

// Front row joins the full shelf width to the angled organizer with no rear gap.
// Bound [0,0,9.5]..[280,64.3653,36.35]. Five blind square cutters open upward.
module front_bins() {
    difference() {
        translate([0,0,shelf_thickness_mm-organizer_join_mm])
            cube([shelf_width_mm,organizer_front_y_mm+organizer_join_mm,
                  front_bin_top_z_mm-shelf_thickness_mm+organizer_join_mm]);
        for (col=[0:front_bin_count-1])
            translate([front_bin_wall_mm+col*(front_bin_size_mm+front_bin_wall_mm),
                       front_bin_wall_mm,front_bin_floor_z_mm])
                cube([front_bin_size_mm,front_bin_size_mm,front_bin_depth_mm+cut_overshoot_mm]);
    }
}

module organizer_assembly_colored() {
    color("steelblue") assembly();
    color("lightgray") organizer_block();
    color("gold") front_bins();
}

module organizer_assembly() {
    union() {
        assembly();
        organizer_block();
        front_bins();
    }
}

organizer_assembly();
