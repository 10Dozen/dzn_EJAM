## Extended Weapon Jamming

#### Version: 2

Adds a little bit more complex logic to ACE jamming effect.

Roadmap to v.2:

- Delayed fire malfunction
- Unmanned automatic fire malfunction
- Customizble jam chance in addition to ACE's overheat based one
- Custom listing of weapon classes and jamming chance for them
- Option to enforce unjamming by dzn_EJAM
- Add hint on Inspect Weapon if gun is ok
- Add Inspect Weapon action icon
- Pistol jamming
- (bug) Reset variables if primary weapon is not in list of jammed (primary weapon was changed)

#### Notes:
https://github.com/acemod/ACE3/blob/master/addons/interact_menu/functions/fnc_removeActionFromObject.sqf


### Description

Mod extends ACE weapon jamming (from ACE Overheating) with additional logic. 
Client-side only.

Features:
Primary weapons may suffer 5 types of malfunction (feed failures, dud, extraction and ejection failures) and each requires correct user actions to be fixed.

Usage:
Bind Inspect Weapon key at (Settings -> Controls -> Addon Options) - default is Ctrl+R.
When weapon got jammed - use Inspect Weapon keybind or (Self-interaction - Equipment - Inspect Weapon) action to open extended unjamming interface.

Note:
- Currently loaded magazine will be dropped to the ground on Magazine Detach action if there is no space in player's inventory.
- Mod doesn't override ACE logic/functions, but extends it in the parallel way, so all ACE settings are still applied (e.g. Shift+R keybind or Reload to unjam setting). But you can unbind ACE Shift+R combo and use dzn_EJAM's instead.
- Weapon from different mods may behave differently (e.g. CUP guns doesn't hide detached magazine).
- For testing you can use next code to jam your weapon: [player, primaryWeapon player] call ace_overheating_fnc_jamWeapon

Credits:
10Dozen - scripting;
hyper's youtube channel (https://www.youtube.com/channel/UCSezUnbvCLYBXuUlPcXU_QQ) - sound.

License: APL-SA
