# Assembly

1. **Print the housing**  
   Use `openscad/housing.scad`; export STL and print. See [openscad/README.md](../openscad/README.md) for dimensions and print notes.

2. **Flash ESPHome**  
   - Copy `esphome/secrets.yaml.example` to `secrets.yaml` and set WiFi and (optionally) API/OTA keys.  
   - Run `esphome run esphome/rotary-lightswitch.yaml` and flash the ESP32-S2 Mini (hold GPIO0, press RST to enter flash mode).

3. **Wire the encoder and PSU**  
   - Connect EC11 CLK → GPIO34, DT → GPIO36, SW → GPIO37, VCC → 3V3, GND → GND.  
   - Connect PSU 5 V and GND to ESP32 VBUS and GND.  
   See [wiring.md](wiring.md).

4. **Mount inside the housing**  
   - Mount the EC11 from behind the front face; secure with its nut. Pass the shaft through the 6 mm hole.  
   - **RGB LED**: Seat the 5 mm RGB LED in the cavity below the shaft (light opening faces the front). Solder R, G, B anodes to GPIO4, 5, 6 (each through a 220 Ω current-limiting resistor) and cathode to GND. The LED is exposed in Home Assistant as a light for feedback or night light.  
   - Place the ESP32-S2 Mini and WX-DC12003 in their slots; fix with double-sided tape or screws if you added mounting holes.  
   - Route wires; avoid pinching.  
   - **Knob fitment**: Lutron knobs are for 5.5 mm split shaft; the EC11 splined shaft is 6 mm. Disassemble one encoder, heat the knob (e.g. with hot air or boiling water), and use the encoder shaft to form the knob bore for a snug fit. Reassemble the encoder and attach the modified knob; secure with the knob nut.

5. **Install in the wall**  
   - Power off at the breaker.  
   - Feed the PSU AC input to the appropriate mains (via a qualified installation if required).  
   - Mount the assembly to the outlet box using the **3 9/32"** mounting holes.  
   - Screw the **standard faceplate** to the housing using the **2 3/8"** screw positions.

6. **Home Assistant**  
   - Add the ESPHome device to Home Assistant.  
   - Create an input_select (options: `normal`, `hue`, `color_temp`) and a timer (e.g. 30 s).  
   - Import the blueprint from `homeassistant/blueprints/automation/rotary_dimmer_light.yaml` and create an automation: select the light, encoder direction and button action sensors, mode helper, and exit timer.
