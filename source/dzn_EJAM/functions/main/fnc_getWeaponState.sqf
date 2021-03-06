/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_getWeaponState

Description:
	Return state of current primary weapon elements (bolt, chamber, case ejection port and magazine)

Parameters:
	nothing

Returns:
	_weaponState - List of weapon parts states <ARRAY>

Examples:
    (begin example)
		_weaponState = call dzn_EJAM_fnc_getWeaponState; // [STATE_BOLT_NOT_CLOSED,STATE_CHAMBER_STUCK,STATE_CASE_EJECTED,STATE_MAG_ATTACHED]
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

private _gun = [primaryWeapon player] call BIS_fnc_baseWeapon;
private _state = ((player getVariable [SVAR(WeaponState), []]) select { _gun == _x # 0 });

if (_state isEqualTo []) exitWith { [] };

_state = [] + (_state # 0);
_state deleteAt 0;

(_state)
