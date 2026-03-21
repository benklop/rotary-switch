# Rotary Light Switch

3D-printed single-gang US rotary light switch using an EC11 encoder and ESP32-S2 Mini, with a standard faceplate and knob. Control a dimmable/color light from Home Assistant: toggle, dim, hue, and color temperature. Optional RGB LED behind the knob for feedback or night light (controllable as a light in HA).

## Contents

- **openscad/** – Housing (single-gang, 2 3/8" faceplate screws, 3 9/32" box mount). No printed faceplate; use a standard toggle/rotary-dimmer plate.
- **esphome/** – ESPHome config for Lolin S2 Mini: rotary encoder + push button, exposed to Home Assistant.
- **homeassistant/blueprints/automation/** – Speed-sensitive RGB blueprints (`rotary_dimmer_rgb.yaml`, `rotary_dimmer_rgb_with_fan.yaml`): Encoder Speed sensor, Kelvin CT on the light, saturation-first hue mode. With the optional fan button configured, double-press is hue and the fan button toggles fan; without it, double-press toggles fan mode. See [homeassistant/blueprints/automation/README.md](homeassistant/blueprints/automation/README.md).
- **docs/** – Wiring, BOM, assembly.

## Quick start

1. Print the housing (`openscad/`), flash ESPHome (`esphome/`), wire encoder and PSU (see [docs/wiring.md](docs/wiring.md)).
2. Mount encoder, boards, and knob in the housing; install in the wall with a standard faceplate.
3. In Home Assistant, add the device, create the helpers for your blueprint (mode input_select, hue sub-mode select for RGB blueprints, optional fan button entity, 30 s timer — see [homeassistant/blueprints/automation/README.md](homeassistant/blueprints/automation/README.md)), then create an automation from `rotary_dimmer_rgb.yaml` or `rotary_dimmer_rgb_with_fan.yaml`.

See [docs/assembly.md](docs/assembly.md) and [docs/bom.md](docs/bom.md) for full steps and parts.

## Hardware

- EC11 rotary encoder (15 mm shaft, **splined** 6 mm)
- ESP32-S2 Mini (Lolin S2 Mini), [pinout](https://done.land/components/microcontroller/families/esp/esp32/developmentboards/esp32-s2/s2mini/)
- WX-DC12003 5 V 700 mA PSU (23.5×18.1 mm)
- Lutron knob (5.5 mm split-shaft type; heat and form to fit 6 mm splined encoder—see docs); standard single-gang faceplate

## License

Use and modify as you like; no warranty.
