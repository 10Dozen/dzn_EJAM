/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_setJamCause

Description:
	Selects and applies Jam cause of current primary weapon

Parameters:
	nothing

Returns:
	nothing

Examples:
    (begin example)
		call dzn_EJAM_fnc_setJamCause
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

private _gun = primaryWeapon player;
private _weights = GVAR(Causes) apply {	call compile FORMAT_VAR((_x select 0) + "_ChanceSettings") };
private _cause = GVAR(Causes) selectRandomWeighted _weights;

_cause params ["_causeID","_weaponState"];
_weaponState call GVAR(fnc_setWeaponState);
private _jamCauses = player getVariable [SVAR(Cause), []];

if ((_jamCauses select { _gun == _x # 0 }) isEqualTo []) then {

	// Add gun to cause list
	_jamCauses pushBack [_gun, _causeID];
	player setVariable [SVAR(Cause), _jamCauses];
} else {

	// Update gun in cause list (actually there is no case for that)
	private _itemInList = (_jamCauses select { _gun == _x # 0 }) # 0;
	_itemInList set [1, _causeID];
};