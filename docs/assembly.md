# Assembly

1. **Print the housing**  
   Use `openscad/housing.scad`; export STL and print. See [openscad/README.md](../openscad/README.md) for dimensions and print notes.

2. **Flash ESPHome**  
   - Copy `esphome/secrets.yaml.example` to `secrets.yaml` and set WiFi and (optionally) API/OTA keys.  
   - Run `esphome run esphome/rotary-lightswitch.yaml` and flash the ESP32-S2 Mini (hold GPIO0, press RST to enter flash mode).

3. **Encoder and LED**  
   - Attach the encoder to the front face with the shaft on the side with the countersinks. Tighten the nut until secure. Use the washer that came with the encoder on the outside to protect the plastic while tightening the nut.  
   - Press-fit the LED into the front face so the lens faces the same way as the encoder shaft.  
   - Connect the ground pins of the LED and the encoder to each other.  
   - Solder a resistor to each of the R, G, and B legs of the LED, using the correct resistor for each (R: 470 Ω, G and B: 430 Ω each).  
   - Attach wires to each of the remaining signal legs on the encoder (ENC_A, ENC_B, ENC_BTN), the shared ground, and the R/G/B resistors.  
   - Wire these to the ESP32-S2: ENC_A → GPIO34, ENC_B → GPIO36, ENC_BTN → GPIO37, GND → GND; R → GPIO4, G → GPIO5, B → GPIO6 (each via its resistor); LED cathode → GND. See [wiring.md](wiring.md).

4. **PSU**  
   - Solder 18 gauge wires to the live and neutral holes on the PSU. Use **white for neutral** and **black for live**.  
   - Strip and tin the other end of these wires so they don’t fray or break when tightened in wire nuts.  
   - Tie a knot in the live/neutral wires close to the PSU board as strain relief for assembly.  
   - Solder a **red** wire to the ground connection and a **black** wire to the 5 V connection of the PSU.  
   - Connect the red lead to **GND** and the black lead to **VBUS** on the ESP32-S2 Mini.

5. **Assembly**  
   TBD

6. **Install in the wall**  
   - Power off at the breaker.  
   - Feed the PSU AC input to the appropriate mains (via a qualified installation if required).  
   - Mount the assembly to the outlet box using the **3 9/32"** mounting holes.  
   - Screw the **standard faceplate** to the housing using the **2 3/8"** screw positions.

7. **Home Assistant**  
   - Add the ESPHome device to Home Assistant.  
   - Create helpers per [homeassistant/blueprints/automation/README.md](../homeassistant/blueprints/automation/README.md): for `rotary_dimmer_rgb.yaml`, an input_select (`normal`, `hue`, `color_temp`), a hue sub-mode input_select (`saturation`, `hue`), and a timer (e.g. 30 s).  
   - Import `rotary_dimmer_rgb.yaml` (or `rotary_dimmer_rgb_with_fan.yaml` if you control a fan) and create an automation: light, **Encoder Speed** sensor, button binary sensors, helpers, and optional knob LED.
