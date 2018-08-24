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

private _weaponMags = (getArray (configFile >> "CfgWeapons" >> primaryWeapon player >> "magazines")) apply { toLower(_x) };
private _mag = [];
{
	if (toLower(_x select 0) in _weaponMags) exitWith {	_mag = _x; };
} forEach (magazinesAmmo player);

private _result = !(_mag isEqualTo []); 

(_result)