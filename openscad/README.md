# Rotary Light Switch – OpenSCAD (front panel + back box)

Two **separate printable components** that attach with 4× M3×10 countersunk screws into M3×6 heat-set inserts in the back box.

## Components

### 1. Front panel (`front_lid.scad`)

Flat plate with hole positions for US single-gang: **narrower and shorter**, ~1/4" beyond the outlet box mounting holes.

- **Faceplate screws** (2 3/8" c/c): 2.6 mm holes so 6-32 screws tap into plastic.
- **Outlet box mounting** (3 9/32" c/c): clearance holes.
- **Encoder**: 6 mm shaft hole; **RGB LED**: 4 mm light opening below.
- **4× M3 countersunk** holes for attaching the back box (M3×10 CS from front into inserts).

### 2. Back box (`back_box.scad`)

Box behind the front panel: **height = distance between faceplate mounting holes** (2 3/8" = 60.325 mm) so it fits in the available space in the light switch box. Minimal depth for encoder rear and boards.

- **4× M3×6 heat-set inserts** at the same positions as the front panel M3 holes (press in from inside).
- **Center divider** separating microcontroller (right / +x) from power supply and 120 V wiring (left / −x).
- **2× wire holes** on the back (PSU side) for 16 AWG live and neutral to the PSU module.

## Dimensions (see `dimensions.scad`)

- Panel: `front_width` (~44 mm), `front_height` (~96 mm), `margin_beyond_box_holes` (1/4").
- Back box: `back_box_height` = faceplate screw spacing (60.325 mm), `back_box_internal_depth` (26 mm), `divider_thickness` (2 mm), `wire_hole_dia` (4 mm).
- M3: `m3_clearance_dia`, `m3_cs_head_dia`, `m3_insert_od`, `m3_insert_depth`, `mount_offset_x` / `mount_offset_y`.

## Usage

1. Open `front_lid.scad` or `back_box.scad` in OpenSCAD (each includes `dimensions.scad`).
2. Adjust values in `dimensions.scad` if needed.
3. Render (F6) and export STL for each component.

## Print settings

- **Front panel**: print with front face down (holes up); no supports. Faceplate holes for 6-32 tap; M3 holes are countersunk.
- **Back box**: orient so the mating face (with the four bosses) is down or so the back wall is down; add supports if the divider or bosses need them. After printing, install M3×6 heat-set inserts in the four boss holes (heat and press in).

## Assembly

1. Install heat-set inserts in the back box (4× M3×6 in the boss holes).
2. Mount encoder (and LED) on the front panel; route wires into the back box.
3. Place ESP32 on the MCU side of the divider, PSU on the PSU side; pass 16 AWG through the two back holes to the PSU.
4. Mate the back box to the front panel and secure with 4× M3×10 countersunk screws from the front.
5. Mount to the outlet box and attach the standard faceplate. See `docs/assembly.md` for full build.
