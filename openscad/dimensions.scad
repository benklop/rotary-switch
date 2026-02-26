// Rotary Light Switch - US single-gang housing dimensions
// All units in mm unless noted

// ----- US device mount (single-gang) -----
// Faceplate screws go INTO the print; standard faceplate attaches here
faceplate_screw_spacing = 60.325;  // 2 3/8" center-to-center, vertical
// Outlet box mounting: screws go THROUGH the print into the box
electrical_box_screw_spacing = 83.344; // 3 9/32" center-to-center, vertical

// Minimal margin beyond the outermost (box) mounting holes; ~1/4" typical
margin_beyond_box_holes = 6.35;    // 1/4"

electrical_box_depth = 63.5;   // ~2.5" typical; for reference
wall_thickness = 2.0;
tolerance = 0.3;            // slot clearance for boards

// Front panel only: narrower and shorter, ~1/4" beyond box holes
// Height = box screw spacing + margin above and below
front_height = electrical_box_screw_spacing + 2 * margin_beyond_box_holes;  // ~96 mm
// Width = narrow; enough for knob and screw holes (no full faceplate width)
front_width = 44.45;       // ~1.75"; adjust to taste
front_center_x = front_width / 2;
front_center_y = front_height / 2;

// Screw hole positions (from front face center; y positive = up)
faceplate_hole_offset_y = faceplate_screw_spacing / 2;  // ±30.16 mm from center
electrical_box_hole_offset_y = electrical_box_screw_spacing / 2; // ±41.67 mm from center
// Inner (faceplate) holes: slightly small so 6-32 screws tap into plastic and hold
faceplate_screw_hole_dia = 3.6;   // pilot for 6-32 thread-cutting in plastic (~0.10")
// Outer (box) holes: clearance for screws that pass through into the box
mounting_screw_hole_dia = 4.0;             // #6-32 or M3  + 0.4 for clearance
// Back box: cylinder behind each faceplate mounting hole (screw pilot from front)
faceplate_screw_boss_depth = 10;           // cylinder depth into box (~10 mm)
faceplate_screw_boss_od = 8;               // outer diameter at front; tapers to hole at back
// Tabs for electrical box mounting holes (max 1/2" each dimension)
mounting_tab_width = 12.7;          // 1/2" max width of tab with box-mount hole
mounting_tab_length = 12.7;         // 1/2" length of tab (corner cutout depth)

// ----- EC11 rotary encoder -----
ec11_body_dia = 11;
ec11_shaft_dia = 6;        // Splined shaft 6 mm
ec11_mount_hole_dia = 7.0; // Encoder mounting hole 7 mm 
ec11_mount_pitch = 5;
ec11_shaft_length = 15;
ec11_nut_flat = 8;         // M6 nut flat-to-flat approx
ec11_nut_thickness = 2.5;
encoder_slot_depth = 8;    // cavity behind front for encoder body

// ----- RGB LED (behind knob: feedback / night light) -----
led_dia = 5;               // 5 mm round tri-color LED
led_depth = 7;             // cavity depth for LED body + leads
led_hole_dia = 5;          // opening in front for light (slightly under LED dome)
led_offset_y = -9.5;         // LED center below shaft (y); visible under knob

// ----- ESP32-S2 Mini (Lolin S2 Mini) -----
esp32_width = 34.4;
esp32_height = 25.4;
esp32_slot_clearance = tolerance;

// ----- WX-DC12003 power supply -----
psu_length = 23.5;         // long side (contacts on this side)
psu_width = 18.1;
psu_slot_clearance = tolerance;
psu_height = 12;           // typical PCB height; adjust from datasheet if needed

// ----- Front panel ↔ back box attachment (M3) -----
// 4× M3×10 countersunk screws from front panel into M3×6 heat-set inserts in back box
m3_clearance_dia = 3.5;           // through-hole for M3 screw
m3_cs_head_dia = 8.0;            // countersunk head diameter (M3 flat/countersunk)
m3_cs_angle = 90;                // countersink angle (degrees)
m3_insert_od = 4.5;              // heat-set insert outer diameter (M3×6 typical)
m3_insert_depth = 6;              // insert length
m3_boss_height = 2 + m3_insert_depth;  // min height at front for insert; back_box uses full depth
// Four mounting positions (x, y) from center; must lie inside back_box_height
mount_offset_x = 15;             // ± from center
mount_offset_y = 22;             // ± from center (inside back_box_height/2)

// Slot to pass power wiring through
wire_slot_width = 1.5;
wire_slot_height = 10;
wire_slot_offset = 2;

// ----- Back box -----
// Height = distance between faceplate mounting holes so it fits in the switch box
back_box_height = faceplate_screw_spacing;  // 2 3/8" = 60.325 mm max
// Depth: minimal for encoder rear + components
back_box_internal_depth = 35;    // internal depth from mating face to back wall
back_box_total_depth = back_box_internal_depth + wall_thickness;  // full depth (walls)
round_radius = 1.5;              // back and corner round/fillet (replaces chamfer)
m3_boss_rear_cylinder_height = 2.0;  // raised cylinder behind M3 CS hole for strength
m3_boss_cylinder_od = 10;        // outer diameter of raised cylinder behind M3 hole
divider_thickness = 2.0;         // center divider (separates MCU top from PSU bottom)
divider_bottom_compartment_height = 18;  // mm from inner bottom to divider; PSU + wire holes in bottom
// Wire pass-through on back (PSU side, bottom) for 16 AWG live/neutral (side by side)
wire_hole_dia = 4;             // 16 AWG with insulation fits through
wire_hole_y = -23;               // vertical position (in bottom compartment)
wire_hole_x1 = -8.5;               // left hole (x)
wire_hole_x2 = -3.5;               // right hole, a few mm from x1
psu_side_bottom = true;          // PSU + AC wires in bottom compartment
