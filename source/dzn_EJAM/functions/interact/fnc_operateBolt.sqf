/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_operateBolt

Description:
	Process bolt operations (pull or open) action called from Weapon Malfunctions
	menu or hotkey.

Parameters:
	_mode - operation name: "pull", "open". Optional, default: "pull"

Returns:
	nothing

Examples:
    (begin example)
		["pull"] call dzn_EJAM_fnc_operateBolt; // Pulls the bolt and
		 										//set new state for weapon
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

params [["_mode", "pull"], ["_params", []]];

private _newState = nil;
private _checkToBeFixed = false;

switch toUpper _mode do {
	case "PULL": {
		_newState = [] call FUNC(calculateStateOnBoltPull);
		_checkToBeFixed = true;
	};
	case "OPEN": {
		_newState = [] call FUNC(calculateStateOnBoltOpen);
	};
};

// Set new weapon state
_newState params ["_boltNewState","_chamberNewState","_roundWasted"];
[_boltNewState,_chamberNewState,nil,nil] call FUNC(setWeaponState);

if (_roundWasted) then {
	[] call FUNC(wasteRound);
};

if !_checkToBeFixed exitWith {};

// Check for exit Jammed state
call FUNC(processWeaponFixed);
