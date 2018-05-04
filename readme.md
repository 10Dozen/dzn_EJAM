## Extended Weapon Jamming

#### Version: 0

Adds a little bit more complex logic to ACE jamming effect.

CR:
- Remake fnc_manageMagzine to use addPrimaryWeaponItem and removePrimaryWeaponItem with magazine/UGL classname to add/remove. It should solve all problems with Zeroing, UGLs, Attachements and so on.
- Place magz to previous positions by https://github.com/acemod/ACE3/blob/master/addons/common/functions/fnc_addToInventory.sqf
- Add sound on actions
- Add some animation?

Bugs:
