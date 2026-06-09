# ESSENTIALS Shader
![banner](https://cdn.modrinth.com/data/cached_images/aa6955a05831cace7be8e478db74a41c997227c1_0.webp)
#### A lightweight Minecraft shader with only essential VFX to simulate realistic effects such as _shadows_, _sun rays_, etc., to run on integrated GPUs.
There are lots of lightweight shaders, and they are said to preserve FPS well, but ESSENTIALS shader takes it to the BARE BONES next level with fake sunrays/moonrays, semi-realistic water, depth-based fogs, and much more. Yeah, it's probably the worst shader you have come across, but it will surely do what it was made for.
##### **TARGET:** The main target of this project is to make shaders also for iGPU users by BRUTALLY optimizing all the visual effects.

[Features](#-features) | [Benchmarks](#️-benchmarks) | [Installation](#-installation)

## ✨ Features

**Lighting**
- Warm sunlight, cool skylight
- Dynamic day/night cycle
- Nether specific lighting
- Fake sun rays & moon rays

**Shadows**
- Soft shadows
- Shadow distortion optimization

**Atmosphere**
- End dimension support
- Nether dimension support
- Simple fog
- Aurora effect (End)

**Water**
- Fresnel transparency effect
- Subtle wave animation
- Deep/shallow color mixing
- Sun specular highlight



## ⚙️ Benchmarks
The shader was tested on a HP Pro office computer from 2012 to prove the point of it's performance.
| Component | Spec | Dimension | 8 chunks | 12 chunks |
|---|---|---|---|---|
| CPU | Intel Core i5-3340 @ 3.10GHz | Overworld | 76 fps | 64 fps |
| RAM | 4 GB DDR3 (1 GB allocated) | Nether | 63 fps | 55 fps |
| GPU | Intel HD Graphics 2500 (iGPU) | End | 119 fps | 102 fps |

## 📦 Installation
1. Download the shader zip
2. Open Minecraft and go to **Options → Video Settings → Shader Packs**
3. Click **Open Shader Pack Folder**
4. Drop the downloaded zip into the folder
5. Select **ESSENTIALS Shader** from the list
6. Done

Compatible with [OptiFine](https://optifine.net/adloadx?f=OptiFine_1.21.4_HD_U_J2.jar) 1.8.9+ and [Iris](https://irisshaders.dev/download) (Higly Reccomended) 1.16+. _Click to visit the download page._
