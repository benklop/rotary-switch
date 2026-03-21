# Rotary Encoder Dimmer Blueprints

Use these blueprints with the ESPHome rotary-lightswitch device to control a dimmable/color light (and optionally a fan).

---

## Blueprint: `rotary_dimmer_light.yaml` (light + hue + color temp)

### Setup

1. **Create helpers in Home Assistant** (Settings → Devices & Services → Helpers):
   - **Input select**: Create an input_select with options `normal`, `hue`, `color_temp` (e.g. name "Rotary dimmer mode").
   - **Timer**: Create a timer (e.g. 30 seconds duration, name "Rotary dimmer exit").

2. **Import the blueprint** (Settings → Automations → Blueprints → Import) and select `rotary_dimmer_light.yaml`.

3. **Create automation from blueprint**: Choose your light, the encoder direction and button action text sensors (from the ESPHome device), the mode input_select, and the exit timer. Adjust step sizes and timeout if desired.

### Behavior

- **Single press**: Toggle light on/off.
- **Rotate (normal mode)**: Dim or brighten.
- **Double press**: Enter hue mode; rotate to change hue. Exit after timeout or double-press again.
- **Long press**: Enter color temperature mode; rotate to change CT. Exit after timeout or long-press again.

Lights that don't support color or color temperature will only respond to toggle and brightness.

---

## Blueprint: `rotary_dimmer_light_with_fan.yaml` (light + fan + color temp)

Alternate version: **double-press** switches to **fan speed** control instead of hue. It takes **4 detents** to move between each fan speed (off → low → medium → high). The **feedback light** (e.g. knob LED) shows **red** (off), **yellow** (low/medium), **green** (max) when you change speed.

### Setup

1. **Create helpers** (Settings → Devices & Services → Helpers):
   - **Input select**: Options `normal`, `fan`, `color_temp` (e.g. "Rotary dimmer mode").
   - **Input number**: Name e.g. "Rotary fan detent", min **0**, max **15**, step **1**. This tracks detent position (0–15); every 4 detents = one speed step.
   - **Timer**: e.g. 30 s, for leaving fan/CT mode.

2. **Import the blueprint** and select `rotary_dimmer_light_with_fan.yaml`.

3. **Create automation from blueprint**: Select the **light**, **fan**, and **feedback light** (the ESPHome "Knob LED" or any RGB light). Choose the encoder direction and button action sensors, mode input_select, **fan detent counter** input_number, and exit timer.

4. **(Optional)** Set the fan detent counter’s initial value to match the current fan (e.g. 0 = off, 4–7 = low, 8–11 = medium, 12–15 = high) so the next rotation doesn’t jump.

### Behavior

- **Single press**: Toggle light on/off.
- **Rotate (normal mode)**: Dim or brighten.
- **Double press**: Enter **fan mode**; rotate to change speed (4 detents per step). Feedback light: red = off, yellow = low/medium, green = max. Exit after timeout or double-press again.
- **Long press**: Enter color temperature mode; rotate to change CT. Exit after timeout or long-press again.

Fan speeds are mapped to percentages: off (0%), low (33%), medium (66%), high (100%). Use a fan that supports percentage or equivalent presets.

---

## Blueprint: `rotary_dimmer_rgb_with_fan.yaml` (speed-sensitive light + fan + color temp)

Speed-sensitive variant that uses the ESPHome `Encoder Speed` sensor like `rotary_dimmer_light.yaml`, but with fan mode behavior inspired by the fan blueprint.

### Setup

1. **Create helpers** (Settings -> Devices & Services -> Helpers):
    - **Input select**: Options `normal`, `fan`, `color_temp`.
    - **Timer**: e.g. 30 s, used to leave fan/CT mode after inactivity.

2. **Import the blueprint** and select `rotary_dimmer_rgb_with_fan.yaml`.

3. **Create automation from blueprint**: Select the **light**, **fan**, optional **feedback light** (knob LED), **Encoder Speed** sensor, button binary sensors (single/double/long), mode input_select, and exit timer.

### Behavior

- **Single press**: Toggle light on/off.
- **Rotate (normal mode)**: Brightness up/down, with slow/medium/fast steps based on encoder speed.
- **Double press**: Enter/exit **fan mode**; rotate to change fan percentage with speed-sensitive step size.
- **Long press**: Enter/exit **color temperature mode**; rotate to change CT with speed-sensitive step size.
- **Fan/CT timeout**: Returns to normal mode after inactivity (timer resets on rotation).
- **Feedback LED (optional)**:
   - Normal mode: off
   - Fan mode: red (off), yellow (low/medium), green (high)
   - CT mode: cool blue-white <-> warm amber
