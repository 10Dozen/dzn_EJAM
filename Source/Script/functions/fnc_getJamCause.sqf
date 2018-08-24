/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_getJamCause

Description:
	Return current primary weapon jam cause or "" if not set

Parameters:
	nothing

Returns:
	_jamCause - Cause enum value or "" <STRING>

Examples:
    (begin example)
		_cause = call dzn_EJAM_fnc_getJamCause; // "dud"
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

private _gun = [primaryWeapon player] call BIS_fnc_baseWeapon;
private _cause = ((player getVariable [SVAR(Cause), []]) select { _gun == _x # 0 });

if (_cause isEqualTo []) exitWith { "" };

(_cause # 0 # 1)