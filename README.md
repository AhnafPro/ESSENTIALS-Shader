# ESSENTIALS Shader
#### A lightweight Minecraft shader with only essential VFX to simulate realistic effects such as _shadows_, _sun rays_, etc., to run on integrated GPUs.
There are lots of lightweight shaders, and they are said to preserve FPS well, but ESSENTIALS shader takes it to the next level with fake sunrays/moonrays, semi-realistic water, block-specific surface sheen, depth-based fogs, and much more.
##### **TARGET:** The main target of this project is to make shaders also for iGPU users by brutally optimizing all the visual effects.

## ✨ Features

**Lighting**
- Warm sunlight, cool skylight
- Dynamic day/night cycle
- Weather darkening during rain
- Nether specific lighting

**Shadows**
- Soft shadows
- Shadow optimization

**Atmosphere**
- Depth-based fog
- Fake sun rays & moon rays
- Custom sky gradient
- Sunrise/sunset

**Water**
- Fresnel transparency effect
- Subtle wave animation
- Deep/shallow color mixing



## ⚙️ Benchmarks
The shader was tested on a bare-bones bottlenecked device to prove the optimizations.
| Component | Spec |
|---|---|
| **CPU** | Intel Core i5-3340 @ 3.10GHz |
| **RAM** | 4 GB DDR3 |
| **GPU** | Intel HD Graphics 2500 (iGPU) |
