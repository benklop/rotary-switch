# Rotary Encoder Dimmer Blueprints

Use these blueprints with the ESPHome rotary-lightswitch device to control a dimmable/color light (and optionally a fan). Both blueprints use the **Encoder Speed** sensor for speed-sensitive steps.

---

## Blueprint: `rotary_dimmer_rgb.yaml` (speed-sensitive light + hue + color temp)

**Hue mode** starts in **saturation** control so whites gain visible colour before you adjust hue; **single-press** in hue mode toggles between saturation and hue (it does **not** toggle the light).

**Colour temperature** uses `light.turn_on` **`color_temp_kelvin`** on the **main light**, with **Kelvin** step sizes. The **knob LED** is **RGB-only** (no CT channel): CT mode is shown with **approximate warm↔cool RGB**, not `color_temp` on that entity.

**Long press**: Flash the rotary firmware from this repo so **Button Long** fires about **500 ms after press while you are still holding** (not on release). That way the automation (and knob LED) enter CT mode as soon as the hold is recognized.

### Setup

1. **Helpers**:
   - **Input select (mode)**: Options `normal`, `hue`, `color_temp`.
   - **Input select (hue sub-mode)**: Options `saturation`, `hue` (e.g. “Rotary hue adjust”).
   - **Timer**: e.g. 30 s for hue/CT exit after inactivity.

2. **Import** `rotary_dimmer_rgb.yaml` and create the automation: **light**, the ESPHome **rotary device** (one picker), optional “use Knob LED”, **both** input_select helpers, timer, and **Kelvin** CT step inputs. Encoder Speed, Button Single/Double/Long, and Knob LED are taken from the device (entity ids must end with `_encoder_speed`, `_button_single` / `_button_double` / `_button_long`, `_knob_led` — default for this repo’s firmware).

   If you upgrade from an older blueprint version, **delete and re-create** the automation (or re-import the blueprint and save) so inputs match the new schema.

### Behavior

- **Single press**: Toggle light in normal and CT mode; in hue mode, switch between saturation adjust and hue adjust.
- **Double press**: Enter/exit hue mode (sub-mode resets to saturation when entering or leaving).
- **Long press**: Enter/exit color temperature mode.
- **Rotate**: Speed-sensitive brightness, saturation, hue, or CT depending on mode and hue sub-mode.

---

## Blueprint: `rotary_dimmer_rgb_with_fan.yaml` (speed-sensitive light + fan + hue + color temp)

Same **RGB** and **Kelvin CT** behaviour as `rotary_dimmer_rgb.yaml` (saturation-first hue mode, single-press sat↔hue, `color_temp_kelvin` on the main light, knob LED as RGB proxy).

**Double-press vs fan**: If you configure the optional **fan button** binary sensor, **double-press** toggles **hue** mode and the **fan button** toggles **fan** mode. If you leave the fan button empty, **double-press** toggles **fan** mode instead (RGB hue is then unavailable unless you add a fan button in ESPHome/HA).

### Setup

1. **Helpers**:
   - **Input select (mode)**: Options `normal`, `hue`, `fan`, `color_temp`.
   - **Input select (hue sub-mode)**: Options `saturation`, `hue`.
   - **Timer**: e.g. 30 s, for leaving hue, fan, or CT mode after inactivity.

2. **Import** `rotary_dimmer_rgb_with_fan.yaml`.

3. **Create automation from blueprint**: **Light**, **fan**, ESPHome **rotary device**, optional **fan button** binary sensor (only if you use a separate control for fan mode), optional “use Knob LED”, **both** mode and hue sub-mode input_selects, exit timer, and Kelvin CT steps. Encoder/button/Knob LED entities are resolved from the rotary device as in the RGB-only blueprint.

   Re-create the automation after a blueprint upgrade if inputs no longer match.

### Behavior

- **Single press**: Toggle light in normal and CT mode; in hue mode, saturation ↔ hue (does not toggle the light).
- **Double press** (fan button configured): Enter/exit hue from normal or CT; exit fan to normal if you were in fan mode.
- **Double press** (no fan button): Enter/exit fan mode; rotate in fan mode changes fan percentage with speed-sensitive steps.
- **Fan button** (when configured): Enter/exit fan mode.
- **Long press**: Enter/exit colour-temperature mode (`color_temp_kelvin` on the main light).
- **Feedback LED (optional)**:
  - Normal mode: off
  - Hue mode: mirrors main light colour (HS→RGB)
  - Fan mode: red (off), yellow (low/medium), green (high)
  - CT mode: warm↔cool RGB proxy (same curve as the non-fan RGB blueprint)
