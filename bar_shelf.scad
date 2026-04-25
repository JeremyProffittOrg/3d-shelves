/**
 * bar_shelf.scad — One-off shelf designed to fit over a bar.
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
 * | shelf_body   | [0,    0,    0]  | [25.4, 150,  10]  | (sits on bar)     |
 * | back_wall    | [0,  145,   10]  | [25.4,   5,  50]  | shelf_body top    |
 * | front_ledge  | [0,    0,   10]  | [25.4,   2,   3]  | shelf_body top    |
 * | drop_wall_a  | [0,   80,  -50]  | [25.4,   5,  50]  | shelf_body bottom |
 * | drop_wall_b  | [0,   42,  -10]  | [25.4,  22,  10]  | shelf_body bottom |
 */

$fn = 64;

// ===========================================
// DIMENSIONS (all values in millimeters)
// ===========================================

// --- shelf body ---
// shelf_width_mm can be overridden by a wrapper file by setting
// `shelf_width_override = <mm>;` BEFORE doing `include<bar_shelf.scad>`.
shelf_width_mm     = is_undef(shelf_width_override) ? 150 : shelf_width_override;
shelf_depth_mm     = 150;
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
drop_a_thickness_mm        = 5;   // Y dimension
drop_a_drop_mm             = 50;  // Hangs 50mm below shelf bottom
drop_a_round_mm            = 1;   // Edge fillet

// --- drop wall B (front drop wall, hangs below shelf) ---
// 16mm in front of wall A (gap between wall A's front face and wall B's back face)
drop_b_gap_to_a_mm  = 16;
drop_b_thickness_mm = 22;  // Y dimension
drop_b_drop_mm      = 10;  // Hangs 10mm below shelf bottom
drop_b_round_mm     = 1;

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
drop_b_back_y  = drop_a_front_y - drop_b_gap_to_a_mm;           // 64
drop_b_front_y = drop_b_back_y  - drop_b_thickness_mm;          // 42

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
 * Bounding:    [0, 0, 0] to [25.4, 150, 10]
 * Notes:       Bottom-front and bottom-back edges are filleted with radius
 *              shelf_bottom_round_mm. Top is left sharp so the back_wall and
 *              front_ledge meet it cleanly. Two zip-tie slots are subtracted
 *              from the body (running through the full X width).
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
 * Bounding:    [0, 145, 10] to [25.4, 150, 60]
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
 * Bounding:    [0, 0, 10] to [25.4, 2, 13]
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
 * Position:   [0, drop_a_front_y, -drop_a_drop_mm]
 * Bounding:   [0, 80, -50] to [25.4, 85, 0]
 */
module drop_wall_a() {
    drop_wall(drop_a_front_y, drop_a_back_y, drop_a_drop_mm, drop_a_round_mm);
}

/**
 * drop_wall_b (front drop wall)
 *
 * Position:   [0, drop_b_front_y, -drop_b_drop_mm]
 * Bounding:   [0, 42, -10] to [25.4, 64, 0]
 */
module drop_wall_b() {
    drop_wall(drop_b_front_y, drop_b_back_y, drop_b_drop_mm, drop_b_round_mm);
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

assembly();
