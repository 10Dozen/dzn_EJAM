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
		ACTION_PULL_BOLT call dzn_EJAM_fnc_doAction;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

params ["_actionID", ["_isMenuAction", true]];

GVAR(ActionInProgress) = true;

// Update magazine state
// [nil, nil, nil, if (call FUNC(isMagAttached)) then { STATE_MAG_ATTACHED } else { STATE_MAG_DETACHED }] call FUNC(setWeaponState);

#define SHOW_MENU		if (_args) then { [] call FUNC(inspectWeapon) } else { "state" call FUNC(uiShowBriefState) }
#define FINISH_ACTION	GVAR(ActionInProgress) = nil
#define PLAY_ANIMATION	if (stance player != "PRONE" && vehicle player == player) then { player playActionNow "DismountOptic"; }

private _title = [_actionID, "process"] call FUNC(getEnumText);
private _args = _isMenuAction;
private _time = [_actionID, "time"] call FUNC(getEnumText);
private _code = {};
private _onAbort = {};

private _needExecute = true;
private _needSound = true;

switch (_actionID) do {
	case ACTION_PULL_BOLT: {
		_code = {
			["pull"] call FUNC(operateBolt);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case ACTION_OPEN_BOLT: {
		_code = {
			["open"] call FUNC(operateBolt);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case ACTION_CLEAR_CHAMBER: {
		PLAY_ANIMATION;
		_code = {
			[nil,STATE_CHAMBER_EMPTY,nil,nil] call FUNC(setWeaponState);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case ACTION_REMOVE_CASE: {
		PLAY_ANIMATION;
		_code = {
			[nil,nil,STATE_CASE_EJECTED,nil] call FUNC(setWeaponState);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case ACTION_DETACH_MAG: {
		if ((primaryWeaponMagazine player) isEqualTo []) exitWith {
			FINISH_ACTION;
			_needExecute = false;
		};

		_code = {
			true call FUNC(manageMagazine);
			[
				nil,
				nil,
				nil,
				[STATE_MAG_DETACHED, STATE_MAG_ATTACHED] select (call FUNC(isMagAttached))
			] call FUNC(setWeaponState);
			SHOW_MENU;
			FINISH_ACTION;
		};
	};
	case ACTION_ATTACH_MAG: {
		if !(call FUNC(hasMagazine)) exitWith {
			FINISH_ACTION;
			private _msg = [LOCALIZE_FORMAT_STR("Hint_NoMag"),1.5];
			if (isNil "ace_common_fnc_displayTextStructured") then {
				hint parseText (_msg select 0);
			} else {
				_msg call ace_common_fnc_displayTextStructured;
			};

			_needExecute = false;
		};

		_code = {
			GVAR(MagLoading) = true;
			false call FUNC(manageMagazine);
			[
				nil,
				nil,
				nil,
				[STATE_MAG_DETACHED, STATE_MAG_ATTACHED] select (call FUNC(isMagAttached))
			] call FUNC(setWeaponState);
			SHOW_MENU;
			FINISH_ACTION;

			[{ GVAR(MagLoading) = nil; }] call CBA_fnc_execNextFrame;
		};
		_onAbort = {
			GVAR(MagLoading) = nil;
		};
	};
	case ACTION_INSPECT: {
		player playActionNow "Gear";
		_code = {
			"state" call FUNC(uiShowBriefState);
			FINISH_ACTION;
		};
		_needSound = false;
	};
};

if !(_needExecute) exitWith {};


if (isNil "ace_common_fnc_progressBar") then {

	// No ACE: use custom progress bar
	[_time, _title, _code, _onAbort, _args] call FUNC(uiShowProgressBar);
} else {

	// ACE detected: use ace progress bar
	[_time, _args, _code, _onAbort, _title, {true}, ["isNotInside", "isNotSwimming", "isNotSitting"]] call ace_common_fnc_progressBar;
};

if (_needSound) then {
	_actionID call FUNC(playActionSound);
};
