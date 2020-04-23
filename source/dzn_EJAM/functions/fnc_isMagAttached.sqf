/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_isMagAttached

Description:
	Process selected action from Weapon Malfunction menu

Parameters:
	nothing

Returns:
	_isMagAttached - Is magazine attached to primary weapon <BOOL>

Examples:
    (begin example)
		call dzn_EJAM_fnc_isMagAttached;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

private _result = (weaponState player select 3) != "";

(_result)