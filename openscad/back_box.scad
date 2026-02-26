// Rotary Light Switch - back box (separate component)
// Attaches to front panel with 4× M3×10 countersunk screws into M3×6 heat-set inserts.
// Divider separates MCU (top) from PSU + 120V (bottom). Two wire holes on back in bottom for live/neutral.

include <dimensions.scad>

// --- Helpers ---
boss_radius = (m3_insert_od + 4) / 2;
r = round_radius;  // fillet radius for rounded edges/corners
rib_width = 2.5;   // rib thickness (perpendicular to wall)
rib_boss_overlap = 0.5;  // rib extends into boss by this much for a solid union

module m3_insert_boss() {
  // Boss recessed by m3_boss_rear_cylinder_height so back box front face is flush for lip; stepped hole for screw + insert
  z_front = back_box_total_depth - m3_boss_rear_cylinder_height;  // front face of boss (recessed)
  boss_h = back_box_total_depth - m3_boss_rear_cylinder_height;
  insert_h = m3_insert_depth * 1.5;
  difference() {
    cylinder(d = m3_insert_od + 4, h = boss_h, $fn = 32);
    // Screw clearance through first 2 mm from boss front face
    translate([0, 0, z_front - 1.5])
      cylinder(d1 = m3_insert_od + 0.1, d2 = m3_insert_od + 1, h = 1.5, $fn = 24);
    // Insert cavity starting 2 mm behind boss front face
    translate([0, 0, z_front - insert_h])
      cylinder(d = m3_insert_od + 0.1, h = insert_h, $fn = 24);
  }
}

// Rib from boss to wall; height matches recessed boss so rib doesn't extend past front face
rib_height = back_box_total_depth - m3_boss_rear_cylinder_height;

module boss_rib_x(boss_x, boss_y, toward_positive) {
  inner_x = toward_positive ? (front_width/2 - wall_thickness) : (-front_width/2 + wall_thickness);
  span = abs(inner_x - boss_x) - boss_radius;          // free gap from boss surface to wall
  len = span + rib_boss_overlap;                       // extend rib into boss by overlap
  if (len > 0) {
    x_start = toward_positive
      ? boss_x + boss_radius - rib_boss_overlap        // from inside boss toward +x wall
      : inner_x;                                       // from wall toward inside boss
    translate([x_start, boss_y - rib_width/2, 0])
      cube([len, rib_width, rib_height]);
  }
}

module boss_rib_y(boss_x, boss_y, toward_positive) {
  inner_y = toward_positive ? (back_box_height/2 - wall_thickness) : (-back_box_height/2 + wall_thickness);
  span = abs(inner_y - boss_y) - boss_radius;          // free gap from boss surface to wall
  len = span + rib_boss_overlap;                       // extend rib into boss by overlap
  if (len > 0) {
    y_start = toward_positive
      ? boss_y + boss_radius - rib_boss_overlap        // from inside boss toward +y wall
      : inner_y;                                       // from wall toward inside boss
    translate([boss_x - rib_width/2, y_start, 0])
      cube([rib_width, len, rib_height]);
  }
}

// --- Back box body: perimeter walls + back wall (height = faceplate spacing only) ---
module back_box_shell() {
  inner_w = front_width - 2 * wall_thickness;
  inner_h = back_box_height - 2 * wall_thickness;
  difference() {
    // Outer box: no taller than faceplate screw spacing so it fits in the switch box
    translate([-front_width/2, -back_box_height/2, 0])
      cube([front_width, back_box_height, back_box_internal_depth + wall_thickness]);
    // Interior cavity
    translate([-inner_w/2, -inner_h/2, wall_thickness])
      cube([inner_w, inner_h, back_box_internal_depth + 1]);
  }
}

// Corner chunk to subtract: sharp corner (cube) minus quarter-cylinder. Leaves convex fillet.
// Chunk extends in +x and +y from origin (the corner point).
module vertical_corner_chunk() {
  difference() {
    cube([r + 0.02, r + 0.02, back_box_total_depth + 2]);
    intersection() {
      cylinder(r = r, h = back_box_total_depth + 2, $fn = 32);
      cube([r + 0.02, r + 0.02, back_box_total_depth + 2]);
    }
  }
}

// Edge chunk to subtract along back edge (axis X): bar minus quarter-cylinder. Leaves convex fillet.
// Bar extends in +y and +z from origin (the edge line at y=0, z=0).
module back_edge_chunk_x(len) {
  difference() {
    cube([len, r + 0.02, r + 0.02]);
    translate([0, r, r]) rotate([0, 90, 0]) intersection() {
      cylinder(r = r, h = len, center = true, $fn = 32);
      cube([len, r + 0.02, r + 0.02]);
    }
  }
}
// Edge chunk for edge along Y (bar in x,z).
module back_edge_chunk_y(len) {
  difference() {
    cube([r + 0.02, len, r + 0.02]);
    translate([r, 0, r]) rotate([90, 0, 0]) intersection() {
      cylinder(r = r, h = len, center = true, $fn = 32);
      cube([r + 0.02, len, r + 0.02]);
    }
  }
}

module corner_rounds() {
  fw = front_width;
  bh = back_box_height;
  rr = r + 0.02;  // chunk size so we offset by this to place chunk inside the box
  // 4 vertical corners: subtract corner chunk (cube minus quarter-cylinder) so convex fillet remains.
  // Chunk must extend inward from each corner so we actually cut the box; origin at corner would cut only empty space.
  translate([ fw/2 - rr,  bh/2 - rr, -1]) vertical_corner_chunk();                    // top-right
  translate([-fw/2 + rr,  bh/2 - rr, -1]) mirror([1, 0, 0]) vertical_corner_chunk(); // top-left
  translate([ fw/2 - rr, -bh/2 + rr, -1]) mirror([0, 1, 0]) vertical_corner_chunk(); // bottom-right
  translate([-fw/2 + rr, -bh/2 + rr, -1]) mirror([1, 1, 0]) vertical_corner_chunk();  // bottom-left
}

// --- Horizontal divider (MCU top vs PSU bottom); bottom compartment 20 mm to divider ---
module divider() {
  h = back_box_internal_depth + wall_thickness;
  inner_w = front_width - 2 * wall_thickness;
  divider_y_bottom = -back_box_height/2 + wall_thickness + divider_bottom_compartment_height;
  difference() {
    translate([-inner_w/2, divider_y_bottom, 0])
      cube([inner_w, divider_thickness, h]);
    // Front-center cutout for encoder body (EC11) in case it extends into divider region
    translate([ inner_w / 2 - wall_thickness - wire_slot_offset, divider_y_bottom - 0.5, back_box_total_depth - wire_slot_height - 0.5])
      cube([wire_slot_width , divider_thickness + 1, wire_slot_height + 1]);
  }
}

// --- Faceplate screw boss: cylinder behind each faceplate mounting hole ---
// Cylinder ~10 mm deep with mounting_screw_hole_dia through-hole; back tapers in to meet front wall
module faceplate_screw_boss() {
  z_front = back_box_total_depth;  // inner face of front wall
  z_back  = z_front - faceplate_screw_boss_depth;
  z_center = (z_front + z_back) / 2;
  h = faceplate_screw_boss_depth;
  difference() {
    // Tapered cylinder: full OD at front, tapers to hole diameter at back (meets wall)
    union() {
      translate([0, 0, z_center - h])
        cylinder(
          d1 = mounting_screw_hole_dia, d2 = faceplate_screw_boss_od,
          h = h, center = true, $fn = 32
        );
      translate([0, 0, z_center])
        cylinder(
          d1 = faceplate_screw_boss_od, d2 = faceplate_screw_boss_od,
          h = h, center = true, $fn = 32
        );
    }
    union() {
      // Through-hole for screw
      translate([0, 0, z_center])
        faceplate_screw_clearance_hole();
      // remove the external part of the boss
      translate([-faceplate_screw_boss_od/2,-faceplate_screw_boss_od/2, z_back / 2])
        cube([faceplate_screw_boss_od, faceplate_screw_boss_od/2, z_back * 2]);
    }
  }
}

module faceplate_screw_clearance_hole() {
  cylinder(d = mounting_screw_hole_dia, h = faceplate_screw_boss_depth * 2, center = true, $fn = 24);
}

module clearance_holes() {
    translate([0,  faceplate_hole_offset_y, back_box_total_depth]) faceplate_screw_clearance_hole();
    translate([0, -faceplate_hole_offset_y, back_box_total_depth]) faceplate_screw_clearance_hole();
}

// --- Wire pass-through holes on back (PSU side only) ---
module wire_holes() {
  z_back_center = wall_thickness / 2;
  translate([wire_hole_x1, wire_hole_y, z_back_center]) cylinder(d = wire_hole_dia, h = wall_thickness + 2, center = true, $fn = 24);
  translate([wire_hole_x2, wire_hole_y, z_back_center]) cylinder(d = wire_hole_dia, h = wall_thickness + 2, center = true, $fn = 24);
}

// --- Full back box ---
module back_box() {
  difference() {
    union() {
      back_box_shell();
      // 4 bosses (full wall height) + ribs to adjacent walls
      translate([ mount_offset_x,  mount_offset_y, 0]) m3_insert_boss();
      translate([ mount_offset_x, -mount_offset_y, 0]) m3_insert_boss();
      translate([-mount_offset_x,  mount_offset_y, 0]) m3_insert_boss();
      translate([-mount_offset_x, -mount_offset_y, 0]) m3_insert_boss();
      boss_rib_x( mount_offset_x,  mount_offset_y, true);  boss_rib_y( mount_offset_x,  mount_offset_y, true);
      boss_rib_x( mount_offset_x, -mount_offset_y, true);  boss_rib_y( mount_offset_x, -mount_offset_y, false);
      boss_rib_x(-mount_offset_x,  mount_offset_y, false); boss_rib_y(-mount_offset_x,  mount_offset_y, true);
      boss_rib_x(-mount_offset_x, -mount_offset_y, false); boss_rib_y(-mount_offset_x, -mount_offset_y, false);
      divider();
      // Faceplate screw bosses: cylinders behind faceplate mounting holes (taper to wall)
      translate([0,  faceplate_hole_offset_y, 0]) rotate(180) faceplate_screw_boss();
      translate([0, -faceplate_hole_offset_y, 0]) faceplate_screw_boss();
    }
    clearance_holes();
    wire_holes();
    corner_rounds();
  }
}

back_box();
