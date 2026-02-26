# Rotary Light Switch

3D-printed single-gang US rotary light switch using an EC11 encoder and ESP32-S2 Mini, with a standard faceplate and knob. Control a dimmable/color light from Home Assistant: toggle, dim, hue, and color temperature. Optional RGB LED behind the knob for feedback or night light (controllable as a light in HA).

## Contents

- **openscad/** – Housing (single-gang, 2 3/8" faceplate screws, 3 9/32" box mount). No printed faceplate; use a standard toggle/rotary-dimmer plate.
- **esphome/** – ESPHome config for Lolin S2 Mini: rotary encoder + push button, exposed to Home Assistant.
- **homeassistant/blueprints/automation/** – Blueprints: single = toggle, rotate = dim, long = color temp (30 s timeout). **Default**: double = hue mode. **Alternate** (`rotary_dimmer_light_with_fan.yaml`): double = fan speed (4 detents per step, red/yellow/green feedback).
- **docs/** – Wiring, BOM, assembly.

## Quick start

1. Print the housing (`openscad/`), flash ESPHome (`esphome/`), wire encoder and PSU (see [docs/wiring.md](docs/wiring.md)).
2. Mount encoder, boards, and knob in the housing; install in the wall with a standard faceplate.
3. In Home Assistant, add the device, create an input_select (normal/hue/color_temp or normal/fan/color_temp for the fan variant) and a 30 s timer, then create an automation from the chosen blueprint (see [homeassistant/blueprints/automation/README.md](homeassistant/blueprints/automation/README.md)).

See [docs/assembly.md](docs/assembly.md) and [docs/bom.md](docs/bom.md) for full steps and parts.

## Hardware

- EC11 rotary encoder (15 mm shaft, **splined** 6 mm)
- ESP32-S2 Mini (Lolin S2 Mini), [pinout](https://done.land/components/microcontroller/families/esp/esp32/developmentboards/esp32-s2/s2mini/)
- WX-DC12003 5 V 700 mA PSU (23.5×18.1 mm)
- Lutron knob (5.5 mm split-shaft type; heat and form to fit 6 mm splined encoder—see docs); standard single-gang faceplate

## License

Use and modify as you like; no warranty.
