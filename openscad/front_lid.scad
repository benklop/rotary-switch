// Rotary Light Switch - front panel only (printable)
// Mounts to electrical box with 3 9/32" holes; faceplate attaches with 2 3/8" screws.
// Panel is narrower and shorter: ~1/4" beyond the box mounting holes.

include <dimensions.scad>

// Corner radius for front panel (1/8")
corner_radius = 25.4 / 8;  // 3.175 mm
// Smoothness of rounded corners (affects exported STL, not just preview)
// Smaller $fs = smoother arcs; ~0.3 mm is good for print quality
fillet_fragment_size = 0.3;

// --- Helpers ---
module screw_hole(d = mounting_screw_hole_dia, h = 20) {
  cylinder(d = d, h = h, center = true, $fn = 24);
}

module encoder_shaft_hole() {
  // Round hole for 6 mm splined shaft; shaft passes through to knob
  cylinder(d = ec11_mount_hole_dia + 0.2, h = wall_thickness + 2, center = true, $fn = 32);
}

module led_light_hole() {
  // Opening in front so LED glow is visible behind knob
  translate([0, led_offset_y, 0])
    cylinder(d = led_hole_dia + 0.2, h = wall_thickness + 2, center = true, $fn = 24);
}

// M3 countersunk through-hole for back box attachment (screw from front at z=0, head flush)
module m3_cs_through_hole() {
  // Through-hole from front (z=0) through plate and raised cylinder (to z=wall_thickness+cylinder_height)
  translate([0, 0, (wall_thickness + m3_boss_rear_cylinder_height) / 2])
    cylinder(d = m3_clearance_dia, h = wall_thickness + m3_boss_rear_cylinder_height + 2, center = true, $fn = 24);
  // Countersink (90°) at front face (z=0) so head sits flush
  translate([0, 0, wall_thickness / 2])
    cylinder(r1 = (m3_cs_head_dia + 0.4 ) / 2, r2 = m3_clearance_dia / 2, h = wall_thickness + 0.5, center = true, $fn = 24);
}

// Raised cylinder on back face (box side), which prints facing up; extends in +z from z=wall_thickness
module m3_boss_rear_cylinder() {
  translate([0, 0, wall_thickness + m3_boss_rear_cylinder_height / 2])
    cylinder(d = m3_boss_cylinder_od, h = m3_boss_rear_cylinder_height, center = true, $fn = 32);
}

// 2D corner cutout shape (rectangle) for outline
module corner_cutout_2d() {
  cutout_x = (front_width - mounting_tab_width) / 2;
  cutout_y = mounting_tab_length;
  square([cutout_x + 0.01, cutout_y + 0.01]);
}

// 3D corner cutout for difference (kept for any 3D use)
module corner_cutout() {
  cutout_x = (front_width - mounting_tab_width) / 2;
  cutout_y = mounting_tab_length;
  cube([cutout_x + 0.01, cutout_y + 0.01, wall_thickness + 2], center = false);
}

// --- Front panel (flat plate with holes, lip recess, raised M3 bosses) ---
module front_plate() {
  cutout_x = (front_width - mounting_tab_width) / 2;
  difference() {
    union() {
      // Panel: build tabbed outline first, then round all remaining corners
      linear_extrude(wall_thickness) {
        $fs = fillet_fragment_size;
        offset(r = -corner_radius) offset(delta = corner_radius)   // fillet concave (tab meets body)
        offset(r = corner_radius) offset(delta = -corner_radius)  // round convex (tab ends, outer)
        difference() {
          square([front_width, front_height], center = true);
          union() {
            translate([-front_width/2,  front_height/2 - mounting_tab_length]) corner_cutout_2d(); // top-left
            translate([ front_width/2 - cutout_x,  front_height/2 - mounting_tab_length]) corner_cutout_2d(); // top-right
            translate([-front_width/2, -front_height/2]) corner_cutout_2d(); // bottom-left
            translate([ front_width/2 - cutout_x, -front_height/2]) corner_cutout_2d(); // bottom-right
          }
        }
      }
      // Raised cylinders on back face (box side, prints up) for strength and to keep countersink within thickness
      translate([ mount_offset_x,  mount_offset_y, 0]) m3_boss_rear_cylinder();
      translate([ mount_offset_x, -mount_offset_y, 0]) m3_boss_rear_cylinder();
      translate([-mount_offset_x,  mount_offset_y, 0]) m3_boss_rear_cylinder();
      translate([-mount_offset_x, -mount_offset_y, 0]) m3_boss_rear_cylinder();
    }

    // Encoder shaft hole (center)
    translate([0, 0, 0])
      encoder_shaft_hole();
    // RGB LED light opening (behind knob)
    led_light_hole();
    // Faceplate screw holes (6-32 bite into plastic; use smaller pilot)
    translate([0, faceplate_hole_offset_y, 0]) screw_hole(d = faceplate_screw_hole_dia, h = wall_thickness + 2);
    translate([0, -faceplate_hole_offset_y, 0]) screw_hole(d = faceplate_screw_hole_dia, h = wall_thickness + 2);
    // Outlet box mounting holes (screws go THROUGH into box; clearance)
    translate([0, electrical_box_hole_offset_y, 0]) screw_hole(h = wall_thickness + 2);
    translate([0, -electrical_box_hole_offset_y, 0]) screw_hole(h = wall_thickness + 2);
    // 4× M3 countersunk holes for back box (M3×10 CS into heat-set inserts)
    translate([ mount_offset_x,  mount_offset_y, 0]) m3_cs_through_hole();
    translate([ mount_offset_x, -mount_offset_y, 0]) m3_cs_through_hole();
    translate([-mount_offset_x,  mount_offset_y, 0]) m3_cs_through_hole();
    translate([-mount_offset_x, -mount_offset_y, 0]) m3_cs_through_hole();
  }
}

front_plate();
