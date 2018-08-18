/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_doAction

Description:
	Process selected action from Weapon Malfunction menu

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

private _actionID = _this;
private _processText = (GVAR(FixActions) select { _x select 0 == _actionID }) select 0 select 2;

#define	REMOVE_ROUND	if ((player getVariable SVAR(RemovedMagazine) select 1) > 0) then { player setVariable [SVAR(LooseRound), true]; }
#define SHOW_MENU		[] spawn GVAR(fnc_ShowUnjamMenu)

switch (_actionID) do {
	case "pull_bolt": {
		[0.5, [], {
			call GVAR(fnc_pullBolt);
			SHOW_MENU;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "open_bolt": {
		[0.5, [], {
			["bolt_opened",nil,nil,nil] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "clear_chamber": {
		player playActionNow "DismountOptic";
		[3, [], {
			REMOVE_ROUND;
			[nil,"chamber_empty",nil,nil] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "remove_case": {
		player playActionNow "DismountOptic";
		[3, [], {
			[nil,nil,"case_ejected",nil] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "detach_mag": {
		[if (GVAR(handleMag)) then { 0.3 } else { 1 }, [], {
			true call GVAR(fnc_manageMagazine);
			[nil,nil,nil,"mag_detached"] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "attach_mag": {
		[1, [], {
			false call GVAR(fnc_manageMagazine);
			[nil,nil,nil,"mag_attached"] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
};

_actionID call GVAR(fnc_playActionSound);