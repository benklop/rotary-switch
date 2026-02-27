# Wiring

## ESP32-S2 Mini (Lolin S2 Mini) ↔ Encoder

| Encoder net | Function | ESP32-S2 Mini GPIO |
|-------------|----------|---------------------|
| ENC_A       | Encoder A | GPIO 34 |
| ENC_B       | Encoder B | GPIO 36 |
| ENC_BTN     | Push button | GPIO 37 |
| GND         | Ground    | GND |

- Enable the ESP32-S2’s internal pull-ups on ENC_A and ENC_B in firmware (see ESPHome config). No external pull-up resistors are provided on the PCB.
- The EC11 is a passive mechanical gray-code encoder; it does not need a VCC connection.

## RGB LED (behind knob)

| LED (common cathode) | ESP32-S2 Mini |
|----------------------|----------------|
| Red anode            | GPIO 4 (via 470 Ω) |
| Green anode          | GPIO 5 (via 430 Ω) |
| Blue anode           | GPIO 6 (via 430 Ω) |
| Common cathode       | GND |

- Use a 5 mm common-cathode RGB LED. R: 470 Ω between GPIO4 and anode; G and B: 430 Ω each between GPIO5/GPIO6 and anodes.
- The LED appears in Home Assistant as a light entity for feedback or night light (e.g. dim red at night).

## Power

- **WX-DC12003**: AC input on the board edge (contacts on the 23.5 mm side). **5 V / 0.7 A** output.
- Connect PSU 5 V and GND to ESP32 **VBUS** (or 5 V) and **GND** for power. The board regulates to 3.3 V internally.
- Do not run high voltage (mains) inside the 3D-printed housing; keep AC only at the PSU input side and use a proper enclosure or wall box for mains.

## Summary

1. PSU 5 V → ESP32 VBUS (or 5 V pin), PSU GND → ESP32 GND.
2. ENC_A → GPIO34, ENC_B → GPIO36, ENC_BTN → GPIO37, GND → GND.
3. RGB LED: R → GPIO4 via 470 Ω; G → GPIO5, B → GPIO6 (each via 430 Ω); cathode → GND.
