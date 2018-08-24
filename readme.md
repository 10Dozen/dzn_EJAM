## Extended Weapon Jamming

#### Version: 2

Adds a little bit more complex logic to ACE jamming effect.

#### Notes:


### Description
Mod adds weapon jamming to vanilla A3 or extends ACE jamming (from ACE Overheating) with additional logic. 
Client-side, but when installed on the server - settings may be forced.

Features:
- Primary weapons may suffer 5 types of malfunction (feed failures, dud, extraction and ejection failures) and each requires correct user actions to be fixed.
- Unjamming from UI or "blind", using the hotkeys
- Jam chance and Malfunction frequency may be configured
- Specific guns may have specific jam chances and malfunction type frequency.

Usage:
- Bind hotkeys at (Settings -> Controls -> Addon Options)
- Check mod settings in the (Settings -> Addon Options -> dzn Extended Jamming)
- When weapon got jammed - use Inspect Weapon keybind or (Self-interaction - Equipment - Inspect Weapon) action to open extended unjamming interface. Or use hotkeys for "blind" fixing.

Note:
- Currently loaded magazine will be dropped to the ground on Magazine Detach action if there is no space in player's inventory.
- Mod can override ACE unjamming logic if forced in the settings.
- Weapon from different mods may behave differently (e.g. CUP guns doesn't hide detached magazine).
- For testing you can use next code to jam your weapon: [player, primaryWeapon player] call ace_overheating_fnc_jamWeapon

Credits:
10Dozen - scripting;
hyper's youtube channel (https://www.youtube.com/channel/UCSezUnbvCLYBXuUlPcXU_QQ) - sound.

License: APL-SA
