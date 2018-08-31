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

// Update magazine state
[nil, nil, nil, if (call GVAR(fnc_isMagAttached)) then { "mag_attached" } else { "mag_detached" }] call GVAR(fnc_setWeaponState);

#define	REMOVE_ROUND	if ((player getVariable SVAR(RemovedMagazine) select 1) > 0) then { player setVariable [SVAR(LooseRound), true]; }
#define SHOW_MENU		if (_args) then { call GVAR(fnc_inspectWeapon) } else { "state" call GVAR(fnc_uiShowBriefState) }
#define FINISH_ACTION	GVAR(ActionInProgress) = nil
#define PLAY_ANIMATION	if (stance player != "PRONE" && vehicle player == player) then { player playActionNow "DismountOptic"; }

private _title = [_actionID, "process"] call GVAR(fnc_getEnumText);
private _args = _isMenuAction;
private _time = [_actionID, "time"] call GVAR(fnc_getEnumText);;
private _code = {};

private _needExecute = true;
private _needSound = true;

switch (_actionID) do {
	case "pull_bolt": {
		_code = {
			call GVAR(fnc_pullBolt);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case "open_bolt": {
		_code = {
			["bolt_opened",nil,nil,nil] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case "clear_chamber": {		
		PLAY_ANIMATION;
		_code = {
			REMOVE_ROUND;
			[nil,"chamber_empty",nil,nil] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case "remove_case": {
		PLAY_ANIMATION;
		_code = {
			[nil,nil,"case_ejected",nil] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case "detach_mag": {
		if ((primaryWeaponMagazine player) isEqualTo []) exitWith {
			GVAR(ActionInProgress) = nil;
			_needExecute = false;
		};
		
		_code = {
			true call GVAR(fnc_manageMagazine);
			[nil, nil, nil, if (call GVAR(fnc_isMagAttached)) then { "mag_attached" } else { "mag_detached" }] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case "attach_mag": {
		if !(call GVAR(fnc_hasMagazine)) exitWith {
			GVAR(ActionInProgress) = nil;
			private _msg = [LOCALIZE_FORMAT_STR("Hint_NoMag"),1.5];
			if (isNil "ace_common_fnc_displayTextStructured") then {
				hint parseText (_msg select 0);
			} else {
				_msg call ace_common_fnc_displayTextStructured;
			};

			_needExecute = false;
		};

		_code = {
			false call GVAR(fnc_manageMagazine);
			[nil, nil, nil, if (call GVAR(fnc_isMagAttached)) then { "mag_attached" } else { "mag_detached" }] call GVAR(fnc_setWeaponState);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case "inspect": {		
		_code = {
			"state" call GVAR(fnc_uiShowBriefState);
			FINISH_ACTION;
		};
		_needSound = false;
	};
};

if !(_needExecute) exitWith {};

if (isNil "ace_common_fnc_progressBar") then {

	// No ACE: use custom progress bar
	[_time, _title, _code, _args] call GVAR(fnc_uiShowProgressBar);
} else {

	// ACE detected: use ace progress bar
	[_time, _args, _code, {}, _title, {true}, ["isNotInside", "isNotSwimming", "isNotSitting"]] call ace_common_fnc_progressBar;
};

if (_needSound) then {
	_actionID call GVAR(fnc_playActionSound);
};