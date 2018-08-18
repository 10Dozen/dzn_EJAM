/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_setWeaponState

Description:
	Set/updates state of weapon elements (bolt, chamber, case ejection port and magazine)

Parameters:
	_weaponState - List of weapon parts states <ARRAY>

Returns:
	nothing

Examples:
    (begin example)
		[
			"bolt_closed"
			,"chamber_empty"
			,"case_ejected"
			,"mag_attached"
		] call dzn_EJAM_fnc_setWeaponState;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

private _currentState = player getVariable [SVAR(WeaponState), []];
if (_currentState isEqualTo []) then {

	// First time set
	player setVariable [SVAR(WeaponState), _this];
} else {

	// Update state
	params[
		["_boltState", _currentState # 0]
		,["_chamberState", _currentState # 1]
		,["_caseState", _currentState # 2]
		,["_magState",  _currentState # 3]
	];

	player setVariable [
		SVAR(WeaponState)
		, [_boltState, _chamberState, _caseState, _magState]
	];
};