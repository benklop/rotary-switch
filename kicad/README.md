## KiCad: Rotary switch UI PCB

This folder contains a small PCB intended to mount:

- An **EC11/EC11E-style rotary encoder with push switch**
- A **5 mm through-hole common-cathode RGB LED**
- **3× current-limit resistors** for the LED
- A **1×8 2.54 mm header** for wiring to the ESP32-S2 Mini

### Project files

- `rotary_switch_ui.kicad_pro`
- `rotary_switch_ui.kicad_sch`
- `rotary_switch_ui.kicad_pcb`

### Mechanical reference

The PCB footprint placement is aligned to the OpenSCAD model:

- **Encoder center** at `(0, 0)` mm
- **LED center** at `(0, -9.5)` mm (from `openscad/dimensions.scad` `led_offset_y`)

### Recommended footprints (to assign in schematic)

If you open the schematic and run **Update PCB from Schematic**, assign these footprints first so KiCad can match by reference designator:

- `SW1` (encoder): `Rotary_Encoder:RotaryEncoder_Alps_EC11E-Switch_Vertical_H20mm`
- `D1` (LED): `LED_THT:LED_D5.0mm-4_RGB`
- `R1`, `R2`, `R3` (resistors): `Resistor_SMD:R_0805_2012Metric` (or switch to THT if preferred)
- `J1` (to ESP32): `Connector_PinHeader_2.54mm:PinHeader_1x08_P2.54mm_Vertical`

### Header pinout (J1)

1. `+3V3` (optional; typically not needed for a bare EC11)
2. `GND`
3. `ENC_A` (encoder A → ESP32 GPIO34 per `docs/wiring.md`)
4. `ENC_B` (encoder B → ESP32 GPIO36)
5. `ENC_BTN` (push button → ESP32 GPIO37)
6. `LED_R_IN` (→ R1 → LED_R; ESP32 GPIO4)
7. `LED_G_IN` (→ R2 → LED_G; ESP32 GPIO5)
8. `LED_B_IN` (→ R3 → LED_B; ESP32 GPIO6)

# Rotary front panel PCB

Small PCB to mount the EC11 encoder, 5 mm RGB LED, and current-limiting resistors for the [rotary light switch](../README.md) project. Connects to the ESP32-S2 Mini via a 8-pin header.

## Contents

- **rotary-front.kicad_pro** – KiCad 8 project
- **rotary-front.kicad_pcb** – Board with footprints placed (encoder, LED, 3× 0805 resistors, 1×8 pin header). No schematic yet; create one and then **Update PCB from Schematic**.

## Schematic (create in Eeschema)

Create a new schematic in this project and add:

| Ref | Symbol / part | Footprint | Value / notes |
|-----|----------------|-----------|----------------|
| U1 | **Device:RotaryEncoder_Switch** | **Rotary_Encoder:RotaryEncoder_Alps_EC11E-Switch_Vertical_H20mm** | EC11 with switch |
| D1 | **LED:LED_RGB_CommonCathode** or 4-pin connector | **LED_THT:LED_D5.0mm-4_RGB** | 5 mm common-cathode RGB |
| R1 | **Device:R** | **Resistor_SMD:R_0805_2012Metric** | **470 Ω** (red channel) |
| R2 | **Device:R** | **Resistor_SMD:R_0805_2012Metric** | **430 Ω** (green) |
| R3 | **Device:R** | **Resistor_SMD:R_0805_2012Metric** | **430 Ω** (blue) |
| J1 | **Connector:Conn_01x08** | **Connector_PinHeader_2.54mm:PinHeader_1x08_P2.54mm_Vertical** | To ESP32 |

### Net list (wire to J1)

Use these net names so the PCB matches [../docs/wiring.md](../docs/wiring.md):

| J1 pin | Net name   | ESP32-S2 Mini |
|--------|------------|----------------|
| 1      | +3V3 (opt) | 3V3 |
| 2      | GND        | GND |
| 3      | ENC_A      | GPIO 34 |
| 4      | ENC_B      | GPIO 36 |
| 5      | ENC_BTN    | GPIO 37 |
| 6      | LED_R_IN   | GPIO 4 (via R1 470 Ω) |
| 7      | LED_G_IN   | GPIO 5 (via R2 430 Ω) |
| 8      | LED_B_IN   | GPIO 6 (via R3 430 Ω) |

- Connect **encoder** pins to ENC_A, ENC_B, ENC_BTN, and GND (check your EC11 datasheet for pin order; Alps EC11E footprint uses A, B, C, S1, S2 — map A/B/S1/S2 to ENC_A/ENC_B/ENC_BTN and GND as appropriate; no VCC is required for the encoder itself).
- Connect **LED** common cathode to **GND**; connect R, G, B anodes to the **R**, **G**, **B** nets (i.e. through R1, R2, R3 to the same-named J1 pins). Verify 5 mm RGB pinout (common cathode vs anode, R/G/B order) from your LED datasheet.

Then: **Tools → Assign footprint symbols**, assign the footprints above, **File → Update PCB from Schematic**, and in PCB Editor route the nets (or use the existing placement).

## PCB layout

- **Board size:** 50 mm × 35 mm (Edge.Cuts).
- **Encoder** at top center (shaft position aligned with front-panel 6 mm hole when the board is mounted).
- **LED** below the encoder (matches `led_offset_y = -9.5 mm` in the OpenSCAD dimensions).
- **J1** at bottom for cable to ESP32.

If your front panel or enclosure differs, move footprints in PCB Editor and adjust Edge.Cuts as needed.

## BOM (per board)

| Ref | Part | Value / spec |
|-----|------|----------------|
| U1 | Alps EC11 or compatible rotary encoder with switch, vertical, 6 mm shaft | 15 mm shaft, splined |
| D1 | 5 mm RGB LED, common cathode | 4-pin |
| R1 | Resistor 0805 | **470 Ω** |
| R2 | Resistor 0805 | **430 Ω** |
| R3 | Resistor 0805 | **430 Ω** |
| J1 | Pin header 1×8, 2.54 mm | Straight, THT |

## Manufacturing

- Single-sided (or two-layer) 1.6 mm FR4; 0.2 mm min trace/space is fine.
- After assembly, mount the PCB behind the 3D-printed front face with the encoder shaft through the 7 mm hole and the LED in the LED cavity; then follow the main [assembly](../docs/assembly.md) for wiring to the ESP32 and PSU.
