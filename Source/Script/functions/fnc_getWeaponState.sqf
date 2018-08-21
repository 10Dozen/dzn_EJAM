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
		_weaponState = call dzn_EJAM_fnc_getWeaponState; // ["bolt_not_closed","chamber_stucked","case_ejected","mag_attached"]
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

private _gun = primaryWeapon player;
private _state = ((player getVariable [SVAR(WeaponState), []]) select { _gun == _x # 0 });

if (_state isEqualTo []) exitWith { [] };

_state = [] + (_state # 0);
_state deleteAt 0;

(_state)