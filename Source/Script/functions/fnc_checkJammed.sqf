/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_checkJammed

Description:
	Check whether primary weapon is jammed and (a) cause set, (b) cause not set.

Parameters:
	_this - Need to check both ACE and EJAM jamming is set <BOOL>

Returns:
	_checkType - Type fo check: "inspect" (check that both cause and ace_overheat is set) or "cause" (check that ace is jammed but no cause set) <STRING>

Examples:
    (begin example)
		_isJammed = true call dzn_EJAM_fnc_checkJammed;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

private _aceJammed = !(missionNamespace getVariable ["ace_overheating_enabled", false]) || (primaryWeapon player) in (player getVariable ["ace_overheating_jammedWeapons", []]);
private _causeSet = (call GVAR(fnc_getJamCause)) != "";

private _result = false;

switch toLower(_this) do {
	case "inspect": {
		_result = _aceJammed && _causeSet;
	};
	case "cause": {
		_result = _aceJammed && !_causeSet;
	};
};

(_result)