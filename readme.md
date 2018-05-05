## Extended Weapon Jamming

#### Version: 0

Adds a little bit more complex logic to ACE jamming effect.

CR:
- Remake fnc_manageMagzine to use addPrimaryWeaponItem and removePrimaryWeaponItem with magazine/UGL classname to add/remove. It should solve all problems with Zeroing, UGLs, Attachements and so on.
- Place magz to previous positions by https://github.com/acemod/ACE3/blob/master/addons/common/functions/fnc_addToInventory.sqf
- Add sound on actions
- Add some animation?

Bugs:

FR v.1:
- Delayed fire
- Unmanned automatic fire
- Customizble jam chance in addition to ACE's overheat based one
- Custom listing of weapon classes and jamming chance for them


### Description

Mod extends ACE weapon jamming (from ACE Overheating) with additional logic. 

Features:
Weapon may suffer 5 types of malfunction and each requires correct user actions to fix it.  

Usage:
Bind Inspect Weapon key at (Settings -> Controls -> Addon Options).
When weapon got jammed - use Inspect Weapon keybind or Self-interaction - Equipment - Inspect Weapon action.

Note:
Mod doesn't override ACE logic/functions, but extends it in parallel, so all ACE settings are still applied (e.g. Shift + R or Reload to unjam). But you may unbind ACE Shift+R combo and use dzn_EJAM instead.
