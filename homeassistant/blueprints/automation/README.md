# Rotary Encoder Dimmer Blueprints

Use these blueprints with the ESPHome **rotary-lightswitch** firmware in this repo. Rotation speed comes from the on-device **Encoder Speed** sensor (det/s).

**No Home Assistant helpers are required.** Flash the firmware, import the blueprint, then pick the **light** (and **fan** for the fan blueprint) plus the **rotary ESPHome device**. Mode (`normal` / `hue` / `color_temp` / `fan`), hue sub-mode (`saturation` / `hue`), and the idle timeout are handled on the ESP32 (`select` + `script` + **Mode Idle Arm** / **Mode Idle Cancel** buttons). Idle duration is the `idle_timeout` substitution in [esphome/rotary-lightswitch.yaml](../../esphome/rotary-lightswitch.yaml).

On-device entity suffixes (for debugging): `_encoder_speed`, `_button_single` / `_button_double` / `_button_long`, `_knob_led`, `_rotary_mode`, `_hue_adjust`, `_mode_idle_arm`, `_mode_idle_cancel`.

---

## Blueprint: `rotary_dimmer_rgb.yaml` (speed-sensitive light + hue + color temp)

**Hue mode** starts in **saturation**; **single-press** in hue mode toggles saturation ↔ hue (does not toggle the room light).

**Colour temperature** uses `light.turn_on` **`color_temp_kelvin`** on the main light. The **knob LED** is RGB-only (warm/cool proxy in CT mode).

**Long press**: Firmware fires **Button Long** ~500 ms into the hold so CT mode starts while you are still pressing.

### Setup

1. Flash [esphome/rotary-lightswitch.yaml](../../esphome/rotary-lightswitch.yaml).
2. Import `rotary_dimmer_rgb.yaml`, create the automation: **Light**, **rotary device**, optional “use Knob LED”, optional tuning numbers (defaults are fine).
3. If upgrading from an older blueprint, **re-create** the automation so inputs match.

### Behavior

- **Single / double / long press** and **rotate**: as in the in-blueprint description (normal / hue / CT; double-press hue in/out).

---

## Blueprint: `rotary_dimmer_rgb_with_fan.yaml` (light + fan + hue + CT)

Same RGB / Kelvin / hue behaviour as the RGB-only blueprint, plus **fan** mode on the device’s mode select.

**Double-press vs fan**: Optional **fan button** binary sensor — if set, double-press is for hue and the fan button toggles fan mode; if omitted, double-press toggles fan mode.

### Setup

1. Same firmware as above (mode select includes `fan`).
2. Import `rotary_dimmer_rgb_with_fan.yaml`: **Light**, **fan**, **rotary device**, optional **fan button**, optional knob LED and tuning inputs.
3. Remove any legacy `homeassistant/packages/rotary_dimmer_light.yaml` merge if you still had helpers defined there.

### Behavior

- As described in the blueprint (fan LED colours, CT, hue, etc.).
