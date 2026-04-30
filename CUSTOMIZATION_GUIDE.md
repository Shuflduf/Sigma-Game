# Blade Runner 2049 Aesthetic Customization Guide

## Quick Overview
Your Sigma Game now has enhanced Blade Runner 2049 cyberpunk aesthetics with:
- Advanced environmental settings (fog, glow, color grading)
- Dynamic neon lighting system
- Flickering lights with pattern variation
- Multiple material types (metal, concrete, neon, reflective)
- Comprehensive architectural details

## How to Customize

### 1. Adjusting Neon Colors

#### Change Existing Neon Materials
Open `world.tscn` and find the material definitions. Modify the emission colors:

```gdscript
# Example: Change cyan to yellow neon
[sub_resource type="StandardMaterial3D" id="MatNeonCyan"]
emission = Color(1.0, 1.0, 0.0, 1.0)  # Yellow instead of cyan
emission_energy_multiplier = 2.2
```

#### Suggested Color Combinations:
- **Cool Cyberpunk**: Cyan (#00FFFF) + Magenta (#FF00FF) + Purple (#8000FF)
- **Warm Cyberpunk**: Orange (#FF8000) + Pink (#FF1080) + Red (#FF0080)
- **Mixed**: Cyan + Pink + Purple + Green

### 2. Adjusting Lighting Intensity

#### Global Brightness
In `world.tscn`, modify the `EnvCyberpunk` environment:

```gdscript
# Increase overall glow
glow_intensity = 3.5  # Default: 3.2 (higher = more bloom)

# Adjust ambient light
ambient_light_energy = 0.7  # Default: 0.5 (higher = brighter)
```

#### Individual Light Sources
Each spotlight and omnilight can be modified:

```gdscript
# Example: Increase spotlight intensity
[node name="MainSpotlight" type="SpotLight3D"]
light_energy = 1.5  # Default: 1.2 (higher = brighter)
spot_range = 100.0  # Default: 80.0 (larger = wider coverage)
```

### 3. Adjusting Fog Atmosphere

#### More Fog (Heavier Atmosphere)
```gdscript
# In EnvCyberpunk environment:
fog_density = 0.1  # Default: 0.05 (higher = more fog)
fog_air_density = 0.15  # Default: 0.1
fog_height_density = 0.3  # Default: 0.2
```

#### Less Fog (Clearer View)
```gdscript
fog_density = 0.02  # Reduce fog
fog_air_density = 0.05
```

### 4. Flickering Light Behavior

#### Modify Flickering Patterns
In the scene, select a `FlickeringLight` node and adjust:

```gdscript
# flicker_speed: How fast the light flickers (0.1-1.0)
# - Lower = slower flicker
# - Higher = faster flicker

# min_energy: Minimum brightness (0.0-1.0)
# - Lower = darker when off

# max_energy: Maximum brightness (0.8-2.0)
# - Higher = brighter when on
```

### 5. Rotating Light Effects

#### Modify Rotating Spotlight
Select the `RotatingLight` node and adjust:

```gdscript
# rotation_speed: How fast it rotates
# - 2.0 = 1 rotation per 3.14 seconds
# - 4.0 = twice as fast

# pulse_speed: How fast the light pulses
# - 2.0 = 2 pulses per second
# - 1.0 = 1 pulse per second
```

### 6. Color Grading (Overall Look)

#### Make Scene Brighter
```gdscript
adjustment_brightness = 1.3  # Default: 1.15
adjustment_contrast = 1.5    # Default: 1.4
```

#### Make Scene More Saturated
```gdscript
adjustment_saturation = 0.9  # Default: 0.8 (higher = more color)
```

#### Make Scene Darker/Moodier
```gdscript
adjustment_brightness = 0.95  # Darken
adjustment_contrast = 1.5     # Keep punchy
background_color = Color(0.005, 0.002, 0.01, 1.0)  # Darker background
```

### 7. Adding New Neon Elements

#### Create a New Neon Material
1. In `world.tscn`, add a new sub_resource:

```gdscript
[sub_resource type="StandardMaterial3D" id="MatNeonCustom"]
albedo_color = Color(0.1, 0.0, 0.15, 1.0)
emission_enabled = true
emission = Color(1.0, 0.2, 0.5, 1.0)  # Custom color
emission_energy_multiplier = 2.0
```

2. Use it on a new geometry element:

```gdscript
[node name="CustomNeonBox" type="CSGBox3D" parent="DetailElements"]
size = Vector3(10, 2, 0.3)
material = SubResource("MatNeonCustom")
```

#### Add Neon Light Source
1. Add a new OmniLight:

```gdscript
[node name="CustomNeonLight" type="OmniLight3D" parent="Lights/NeonAccentLights"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, X, Y, Z)
light_color = Color(1.0, 0.2, 0.5, 1.0)  # Match neon color
light_energy = 0.6
omni_range = 20.0
```

### 8. Building Customization

#### Add More Neon Stripes to a Building
```gdscript
[node name="BuildingX_NeonCustom" type="CSGBox3D" parent="Buildings/BuildingX"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, X, Y, Z)
size = Vector3(WIDTH, HEIGHT, DEPTH)
material = SubResource("MatNeonMAGENTA")  # or any neon material
operation = 2  # Subtract operation
```

### 9. Window Lighting Patterns

#### Change Window Brightness
Find window definitions and modify emission:

```gdscript
# Brighter windows
[sub_resource type="StandardMaterial3D" id="MatLitWindow"]
emission = Color(0.5, 0.7, 1.0, 1.0)  # Brighter blue
emission_energy_multiplier = 1.0  # Increased from 0.6
```

#### Warmer Window Light
```gdscript
emission = Color(1.0, 0.8, 0.4, 1.0)  # Warm white/orange
```

### 10. Performance Optimization

#### Reduce Lights (Better FPS)
- Remove some OmniLights from `Lights/AmbientLights`
- Reduce light ranges on distant lights
- Disable flickering lights if FPS is low

#### Reduce Fog (Faster Rendering)
```gdscript
fog_density = 0.02  # Lower value
```

#### Disable SSAO (Faster)
```gdscript
ssao_enabled = false  # Set to false in EnvCyberpunk
```

## Advanced Tips

### Creating Color Transitions
You can create gradual color changes by modifying light colors in scripts:

```gdscript
# In a script attached to a light
func _process(delta):
    var t = fmod(get_tree().get_frame(delta), 2.0) / 2.0
    light_color = Color(0, t, 1-t, 1).normalized()  # Cyan to Pink transition
```

### Dynamic Light Intensity Based on Player Position
```gdscript
# Calculate distance to player
var distance = global_position.distance_to(player.global_position)
light_energy = range_lerp(distance, 0, 100, 1.0, 0.1)  # Dims with distance
```

### Synchronizing Multiple Flickering Lights
Use the same seed for multiple lights to flicker in sync:

```gdscript
seed(12345)  # Same seed in multiple scripts = synchronized flicker
```

## Debugging Tips

### Check Glow is Working
- If you don't see neon glow, increase `glow_intensity` in environment
- Check that `emission_enabled = true` on materials
- Verify light colors match emissive materials

### Lights Not Showing
- Check `light_energy` is > 0
- Verify `light_color` is not pure black
- Check shadow settings aren't culling the light

### Scene Too Dark
- Increase `ambient_light_energy`
- Increase `adjustment_brightness`
- Add more ambient lights

### Scene Too Bright
- Decrease `glow_intensity`
- Lower individual light energies
- Decrease `adjustment_brightness`

## Quick Presets

### Preset 1: "Dark Rain" (Movie-like)
```gdscript
fog_density = 0.08
glow_intensity = 2.8
adjustment_contrast = 1.5
adjustment_brightness = 0.95
```

### Preset 2: "Neon Paradise" (Vibrant)
```gdscript
fog_density = 0.02
glow_intensity = 3.5
adjustment_saturation = 1.0
adjustment_brightness = 1.25
```

### Preset 3: "Industrial" (Harsh)
```gdscript
fog_density = 0.03
glow_intensity = 2.2
adjustment_contrast = 1.6
ssao_intensity = 2.5
```

---

For more details, see `README_AESTHETICS.md`
