/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_setWeaponState

Description:
	Set/updates state of current equipped weapon elements (bolt, chamber, case ejection port and magazine)

Parameters:
	_weaponState - List of weapon parts states <ARRAY>

Returns:
	nothing

Examples:
    (begin example)
		[
			STATE_BOLT_CLOSED
			,STATE_CHAMBER_EMPTY
			,STATE_CASE_EJECTED
			,STATE_MAG_ATTACHED
		] call dzn_EJAM_fnc_setWeaponState;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

private _gun = [primaryWeapon player] call BIS_fnc_baseWeapon;
private _weaponStates = player getVariable [SVAR(WeaponState), []];

if ((_weaponStates select { _gun == _x # 0 }) isEqualTo []) then {

	// First time set
	_weaponStates pushBack ([_gun] + _this);
	player setVariable [SVAR(WeaponState), _weaponStates];
} else {
	// Loop throug states and update if needed
	private _currentState = (_weaponStates select { _gun == _x # 0 }) # 0;
	private ["_newState"];

	{
		// Update current state with new values if passed (not nil)
		if (!isNil "_x") then {
			// Randomize state if needed
			_newState = if !(_x isEqualType []) then { _x } else { selectRandom _x };
			_currentState set [_forEachIndex + 1, _newState];
		};
	} forEach _this;
};
