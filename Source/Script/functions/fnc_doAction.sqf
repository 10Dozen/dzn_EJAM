/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_doAction

Description:
	Process selected action from Weapon Malfunction menu and return to malfunction menu.

Parameters:
	_actionName - action to perform <STRING>

Returns:
	nothing

Examples:
    (begin example)
		"pull_bolt" call dzn_EJAM_fnc_doAction;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

params ["_actionID", ["_isMenuAction", true]];

GVAR(ActionInProgress) = true;

#define	REMOVE_ROUND	if ((player getVariable SVAR(RemovedMagazine) select 1) > 0) then { player setVariable [SVAR(LooseRound), true]; }
#define SHOW_MENU		if (_args) then { call GVAR(fnc_inspectWeapon) } else { "state" call GVAR(fnc_uiShowBriefState) }
#define FINISH_ACTION	GVAR(ActionInProgress) = nil

private _title = [_actionID, "process"] call GVAR(fnc_getEnumText);
private _args = _isMenuAction;

private _time = 0;
private _code = {};

switch (_actionID) do {
	case "pull_bolt": {
		_time = 0.5;
		_code = {
			call GVAR(fnc_pullBolt);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case "open_bolt": {
		_time = 0.5;
		_code = {
			["bolt_opened",nil,nil,nil] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case "clear_chamber": {
		player playActionNow "DismountOptic";
		_time = 3;
		_code = {
			REMOVE_ROUND;
			[nil,"chamber_empty",nil,nil] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case "remove_case": {
		player playActionNow "DismountOptic";
		_time = 3;
		_code = {
			[nil,nil,"case_ejected",nil] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case "detach_mag": {
		_time = if (GVAR(handleMag)) then { 0.3 } else { 1 };
		_code = {
			true call GVAR(fnc_manageMagazine);
			[nil,nil,nil,"mag_detached"] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case "attach_mag": {
		_time = 1;
		_code = {
			false call GVAR(fnc_manageMagazine);
			[nil,nil,nil,"mag_attached"] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
};

if (isNil "ace_common_fnc_progressBar") then {

	// No ACE: use custom progress bar
	[_time, _title, _code, _args] call GVAR(fnc_uiShowProgressBar);
} else {

	// ACE detected: use ace progress bar
	[_time, _args, _code, {}, _title, {true}, ["isNotInside", "isNotSwimming", "isNotSitting"]] call ace_common_fnc_progressBar;
};

_actionID call GVAR(fnc_playActionSound);