/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_doHotkeyAction

Description:
	Process hotkey action init

Parameters:
	_actionName - action to perform <STRING>

Returns:
	nothing

Examples:
    (begin example)
		"pull_bolt" call dzn_EJAM_fnc_doHotkeyAction;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

if !("inspect" call GVAR(fnc_checkJammed)) exitWith {
	"OK" call GVAR(fnc_uiShowBriefState);
};

(call GVAR(fnc_getWeaponState)) params ["_bolt","_chamber","_case","_mag"];
private _actionID = _this;

if (
	_actionID in ["clear_chamber","remove_case"] 
	&& _bolt in ["bolt_closed","bolt_not_closed"]
) exitWith {
	"no_access" call GVAR(fnc_uiShowBriefState);
};

[_actionID, false] call GVAR(fnc_doAction);