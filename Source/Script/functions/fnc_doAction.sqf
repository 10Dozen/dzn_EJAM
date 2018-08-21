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

private _processText = [_actionID, "process"] call GVAR(fnc_getEnumText);

#define	REMOVE_ROUND	if ((player getVariable SVAR(RemovedMagazine) select 1) > 0) then { player setVariable [SVAR(LooseRound), true]; }
#define SHOW_MENU		if (_args) then { call GVAR(fnc_inspectWeapon) } else { "state" call GVAR(fnc_uiShowBriefState) }

switch (_actionID) do {
	case "pull_bolt": {
		[0.5, _isMenuAction, {
			call GVAR(fnc_pullBolt);
			SHOW_MENU;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "open_bolt": {
		[0.5, _isMenuAction, {
			["bolt_opened",nil,nil,nil] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "clear_chamber": {
		player playActionNow "DismountOptic";
		[3, _isMenuAction, {
			REMOVE_ROUND;
			[nil,"chamber_empty",nil,nil] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "remove_case": {
		player playActionNow "DismountOptic";
		[3, _isMenuAction, {
			[nil,nil,"case_ejected",nil] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "detach_mag": {
		[if (GVAR(handleMag)) then { 0.3 } else { 1 }, _isMenuAction, {
			true call GVAR(fnc_manageMagazine);
			[nil,nil,nil,"mag_detached"] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "attach_mag": {
		[1, _isMenuAction, {
			false call GVAR(fnc_manageMagazine);
			[nil,nil,nil,"mag_attached"] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
};

_actionID call GVAR(fnc_playActionSound);