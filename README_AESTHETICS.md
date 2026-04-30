# Blade Runner 2049 City Aesthetic Guide

## Overview
This document outlines the visual improvements applied to create a Blade Runner 2049-inspired cyberpunk city environment.

## Key Visual Elements Implemented

### 1. **Enhanced Materials**
- **MatReflectiveMetal**: Highly metallic surfaces with 0.95 metallic and 0.15 roughness for reflective surfaces
- **MatWeatheredConcrete**: Concrete with normal maps for weathered appearance
- **MatLitWindow**: Emissive windows with soft blue glow (0.3, 0.5, 1.0)
- **MatNeonCyan, Magenta, Purple, Pink, Orange**: High-emission neon materials with 1.8-2.5 multipliers
- **MatEminentNeon**: Extra bright neon for accent lighting (2.5 multiplier)

### 2. **Atmospheric Effects**
- **Volumetric Fog**: 
  - Density: 0.05
  - Air Density: 0.1
  - Height-based fog for depth perception
  - Aerial Perspective: 0.15
  
- **Smoke Volumes**: Semi-transparent smoke materials scattered around key locations
  - Creates depth and atmosphere
  - Allows light rays to be visible

### 3. **Advanced Lighting System**
- **Multiple Light Layers**:
  - Directional Light: Ultra-dark mood (0.1, 0.05, 0.15) at 0.2 energy
  - Spotlight Array: 4 main spotlights for dramatic beams
  - OmniLights: Building-mounted lights in neon colors
  - Flickering Lights: Script-based flickering for signs
  - Street Lights: Directed neon light from street level
  - Background Lights: Directional accent lighting for depth
  - City Glow Lights: Massive range lights for ambient glow

### 4. **Environment Settings (Improved)**
- **Background Color**: Ultra-dark (0.01, 0.005, 0.02)
- **Ambient Light**: Cold (0.08, 0.03, 0.12) at 0.5 energy
- **Glow Settings**:
  - Intensity: 3.2 (increased for more bloom)
  - HDR Threshold: 0.3 (lower = brighter glow on neon)
  - HDR Scale: 1.5 (for bloom spread)
- **SSAO**: 
  - Radius: 2.0 (more pronounced shadows)
  - Intensity: 2.0 (darker corners)
- **Color Grading**:
  - Brightness: 1.15 (slight lift)
  - Contrast: 1.4 (punchy look)
  - Saturation: 0.8 (desaturated for cyberpunk)

### 5. **Architectural Elements**
- **Tall Buildings**: Main towers with neon accents and lit windows
- **Bridge Structures**: Metallic walkways with neon railings
- **Neon Signage**: 3D neon boxes and advertisement boards
- **Industrial Details**: Pipes, vents, and mechanical elements
- **Vertical Cables**: Connecting buildings with neon glow
- **Antennas & Towers**: Tall radio towers with neon coloring
- **Satellite Dishes**: Reflective metallic details on rooftops

### 6. **Lighting Color Palette**
- **Cyan**: (0.0, 1.0, 1.0) - Primary cool color
- **Magenta**: (1.0, 0.0, 1.0) - Secondary cool color
- **Purple**: (0.8, 0.0, 1.0) - Accent color
- **Pink/Magenta**: (1.0, 0.1, 0.8) - Warm accent
- **Orange**: (1.0, 0.5, 0.0) - Warm neon
- **Green**: (0.0, 1.0, 0.5) - Accent neon

## Scene Hierarchy

```
World
├── WorldEnvironment (Cyberpunk environment)
├── DirectionalLight3D (Primary moon light)
├── PlayerSpotlight (Dynamic player light)
├── Ground (Dark floor plane)
├── Player (Player camera and controller)
├── Buildings
│   ├── BuildingA_MainTower
│   ├── BuildingB_MiddleHigh
│   ├── BuildingC_Right
│   ├── BuildingD_Left
│   ├── BuildingE_BackLeft
│   ├── BuildingF_BackRight
│   ├── BridgePlatform
│   └── VerticalCables
├── Lights
│   ├── MainSpotlight
│   ├── LeftSpotlight
│   ├── RightSpotlight
│   ├── RotatingLight (script-controlled)
│   ├── BuildingLights (OmniLights)
│   ├── FlickeringLights (script-controlled)
│   ├── AmbientLights
│   ├── StreetLights
│   ├── ExtraAdditionalLights
│   ├── EnhancedLighting (Background directional lights)
│   ├── CityGlowLights (Large range glow lights)
│   ├── CustomLights (Additional spotlights)
│   └── NeonAccentLights (Neon-specific glow)
├── DetailElements
│   ├── AdvertisementBoards
│   ├── NeonGridLines
│   ├── NeonPylons
│   ├── ArchitecturalDetails
│   ├── DecorativeNeonShapes
│   ├── AdditionalNeonSignage
│   ├── VerticalNeonEdges
│   ├── RooftopDetails
│   └── IndustrialDetails
├── FogVolume (Atmospheric smoke volumes)
├── AnimatedPlatforms
├── AdditionalPlatforms
└── LargeStructures
```

## Tips for Further Enhancement

### Suggested Improvements:
1. **Particle Effects**
   - Add rain particles with wind effect
   - Steam vents from rooftops
   - Dust particles in light shafts

2. **Dynamic Elements**
   - Animated neon signs (flickering patterns)
   - Flying vehicles/drones
   - Scrolling advertisement text

3. **Sound Design**
   - Ambient city noise (distant traffic, machinery)
   - Rain ambience
   - Neon hum/buzz on emissive lights

4. **Post-Processing**
   - Chromatic aberration (subtle)
   - Film grain overlay
   - Vignette effect

5. **Ray Tracing**
   - Enable ray tracing for reflections on metal surfaces
   - Ray-traced shadows for more dramatic lighting

## Settings Summary

### Key Config Values:
```
Environment:
  - Glow Intensity: 3.2
  - Glow HDR Threshold: 0.3
  - Background: (0.01, 0.005, 0.02)
  - Ambient Light: (0.08, 0.03, 0.12) @ 0.5 energy
  - SSAO Intensity: 2.0
  - Fog Density: 0.05

Neon Materials:
  - Emission Multiplier: 1.8-2.5
  - Metallic: 0.0
  - Roughness: 0.0

Metal Surfaces:
  - Metallic: 0.8-0.95
  - Roughness: 0.15-0.3
  - Clearcoat: 0.3 (optional)
```

## Performance Notes
- This scene uses multiple lights (20+) for visual richness
- Volumetric fog is enabled for atmospheric depth
- SSAO adds visual quality but has performance cost
- Consider reducing light count on lower-end devices
- Disable flickering scripts for simpler lighting

---
Created for Sigma Game - Blade Runner 2049 Aesthetic Update
