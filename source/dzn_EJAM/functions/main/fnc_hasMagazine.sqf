/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_hasMagazine

Description:
	Returns true if player has magazine to current primary weapon.

Parameters:
	nothing

Returns:
	_hasMagazine - Does player has magazine <BOOL>

Examples:
    (begin example)
		_hasMagazine = call dzn_EJAM_fnc_hasMagazine; // true
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

private _weaponMags = ([primaryWeapon player] call CBA_fnc_compatibleMagazines) apply { toLower(_x) };

// --- Loop through player's magazines and find any compatible
private _hasAnyMagazine = (magazinesAmmo player) findIf { toLower(_x # 0) in _weaponMags } > -1;

(_hasAnyMagazine)
