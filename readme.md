## Extended Weapon Jamming

#### Version: 0

Adds a little bit more complex logic to ACE jamming effect.

CR:
- Remake fnc_manageMagzine to use addPrimaryWeaponItem and removePrimaryWeaponItem with magazine/UGL classname to add/remove. It should solve all problems with Zeroing, UGLs, Attachements and so on.
- Place magz to previous positions by https://github.com/acemod/ACE3/blob/master/addons/common/functions/fnc_addToInventory.sqf
- Add sound on actions
- Add some animation?

Bugs:
- UGL magazines are handled wrongly: On weapon removing/adding - UGL round is loaded, so next time weapon is removed - round disappears. Should be handled like this -- check UGL loaded before removing weapon, if loaded - save round, on adding weapon back - remove auto-loaded UGL and add saved one (or empty) to gun, removed ugl should be added to inventory
- [No way to fix] Weapon zeroing is reseting on attach/detach due to weapon re-add
- [Fixed] Attachements states won't be saved

