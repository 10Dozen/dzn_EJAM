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
		ACTION_PULL_BOLT call dzn_EJAM_fnc_doHotkeyAction;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

if !(isNil SVAR(ActionInProgress)) exitWith {};
if ([] call FUNC(isInVehicleCrew)) exitWith {};

if !("inspect" call FUNC(checkJammed)) exitWith {
	"OK" call FUNC(uiShowBriefState);
};

(call FUNC(getWeaponState)) params ["_bolt","_chamber","_case","_mag"];
private _actionID = _this;

// --- Prevent actions inside gun if no access (bolt closed/blocked by magazine)
if (
	(_actionID == ACTION_CLEAR_CHAMBER && (CHECK_MAG_ATTACHED(_mag) || not CHECK_BOLT_OPENED(_bolt)))
	||
	(_actionID == ACTION_REMOVE_CASE && not CHECK_BOLT_OPENED(_bolt))
) exitWith {
	"no_access" call FUNC(uiShowBriefState);
};

[_actionID, false] call FUNC(doAction);
