# Wiring

## ESP32-S2 Mini (Lolin S2 Mini) ↔ EC11

| EC11 pin | Function | ESP32-S2 Mini GPIO |
|----------|----------|---------------------|
| CLK      | Encoder A | GPIO 34 |
| DT       | Encoder B | GPIO 36 |
| SW       | Push button | GPIO 37 |
| +        | VCC (3.3 V) | 3V3 |
| GND      | Ground    | GND |

- Use internal pull-up on CLK and DT (configured in ESPHome). No external resistors required for typical EC11.
- Encoder VCC can be 3.3 V from the ESP32; do not connect to 5 V unless the encoder is 5 V tolerant and you add level shifting.

## RGB LED (behind knob)

| LED (common cathode) | ESP32-S2 Mini |
|----------------------|----------------|
| Red anode            | GPIO 4 (via 220 Ω) |
| Green anode          | GPIO 5 (via 220 Ω) |
| Blue anode           | GPIO 6 (via 220 Ω) |
| Common cathode       | GND |

- Use a 5 mm common-cathode RGB LED. One 220 Ω current-limiting resistor per channel between GPIO and LED anode.
- The LED appears in Home Assistant as a light entity for feedback or night light (e.g. dim red at night).

## Power

- **WX-DC12003**: AC input on the board edge (contacts on the 23.5 mm side). **5 V / 0.7 A** output.
- Connect PSU 5 V and GND to ESP32 **VBUS** (or 5 V) and **GND** for power. The board regulates to 3.3 V internally.
- Do not run high voltage (mains) inside the 3D-printed housing; keep AC only at the PSU input side and use a proper enclosure or wall box for mains.

## Summary

1. PSU 5 V → ESP32 VBUS (or 5 V pin), PSU GND → ESP32 GND.
2. EC11 CLK → GPIO34, DT → GPIO36, SW → GPIO37, VCC → 3V3, GND → GND.
3. RGB LED: R → GPIO4, G → GPIO5, B → GPIO6 (each via 220 Ω); cathode → GND.
