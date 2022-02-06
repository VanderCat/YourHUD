# YourHUD `Beta`<sup>`TM`</sup>
<p align="center">
    <img alt="logo" src="https://github.com/VanderCat/YourHUD/blob/main/img/WorkshopIcon.png?raw=true" width="196">
</p>
<p align="center">
    place here a very cool description
</p>

![A Hud](https://github.com/VanderCat/YourHUD/blob/main/img/HUD.jpg?raw=true)
## Description
A customizable ToonHUD-esque (TF2 Custom) HUD.
You can change position, size, font, colors, in-game.
Also i tried to match clip/ammo part to it's HL2 original state ([with a very very hard to understand code though](https://github.com/VanderCat/YourHUD/blob/main/lua/autorun/client/HUDmain.lua#L167))

I made this mod because i was in need a more "pro" hud i could not find myself.

## Features
- HUD guess how to render ammo/clip/alt counter
    - this works in 99% however there's some exceptions (like [SLAM](https://github.com/VanderCat/YourHUD/blob/main/img/GuessIssue.jpg?raw=true))
- Health change watcher ([IMG1](https://github.com/VanderCat/YourHUD/blob/main/img/hpRecover.jpg?raw=true) [IMG2](https://github.com/VanderCat/YourHUD/blob/main/img/hpLose.jpg?raw=true))
- Player list on top 
- you can enable and/or disable drawing of HL2's hud or YourHUD ([IMG1](https://github.com/VanderCat/YourHUD/blob/main/img/SettingsVisibility.jpg?raw=true))
- Fully customizable
    - [Position](https://github.com/VanderCat/YourHUD/blob/main/img/SettingsOffsets.jpg?raw=true)
    - [Size](https://github.com/VanderCat/YourHUD/blob/main/img/SettingsFonts.jpg?raw=true)
    - [Font](https://github.com/VanderCat/YourHUD/blob/main/img/SettingsFonts.jpg?raw=true)
    - [Colors](https://github.com/VanderCat/YourHUD/blob/main/img/SettingsColors.jpg?raw=true)

## Planned Features
- TF2-esque playername showcase
- Show player state (dead or alive) on mini scoreboard
- Change HUD elements align

# Broken
- To use coolvetica default font you need to download and install it in system (bcs it's not free 😒)
    - You can just alter font in settings though
    - or [download](https://dl.dafont.com/dl/?f=coolvetica) it and install (Coolvetica RG)

# Installation
Just clone the repo to addons folder
```sh
%SteamLibrary%/GarrysMod/garrysmod/addons/
```
or download .zip and extract the folder to provided filepath

# License
Copyright © 2022 VanderCat

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.