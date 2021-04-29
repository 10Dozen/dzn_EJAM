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

	// Update state (parse _this with _currentState as defaults)
	private _currentState = (_weaponStates select { _gun == _x # 0 }) # 0;

	params[
		["_boltState", _currentState # 1]
		,["_chamberState", _currentState # 2]
		,["_caseState", _currentState # 3]
		,["_magState",  _currentState # 4]
	];

	_currentState set [1, _boltState];
	_currentState set [2, _chamberState];
	_currentState set [3, _caseState];
	_currentState set [4, _magState];
};
