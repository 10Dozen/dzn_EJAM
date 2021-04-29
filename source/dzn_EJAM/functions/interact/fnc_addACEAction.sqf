/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_addACEAction

Description:
	Adds ACE Equipment action for Inspect menu.

Parameters:
	none

Returns:
	nothing

Examples:
    (begin example)
		[] call dzn_EJAM_fnc_addACEAction;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

GVAR(ACE_InspectActionClass) = [
	SVAR(ACE_Action_Inspect)
	, LOCALIZE_FORMAT_STR("Action_Inspect")
	, getText (configFile >> "CfgWeapons" >> primaryWeapon player >> "picture")
	, { [] call FUNC(inspectWeapon) }
	, { private _pw = primaryWeapon player; _pw isNotEqualTo "" && currentWeapon player == _pw }
] call ace_interact_menu_fnc_createAction;

[
	typeof player, 1
	, ["ACE_SelfActions", "ACE_Equipment"]
	, GVAR(ACE_InspectActionClass)
] call ace_interact_menu_fnc_addActionToClass;

// Loop to handle gun icon change & unjam chance
GVAR(CurrentPrimaryWeapon) = primaryWeapon player;
GVAR(ACE_Weapon_EH) = ["weapon", {
	params ["", "_newWeapon", ""];
	private _pw = primaryWeapon player;

	// Update ACE Action's icon & cache weapon family
	// if new weapon is primary and different from previous one
	if (
		_newWeapon isNotEqualTo ""
		&& _newWeapon isEqualTo _pw
		&& { _newWeapon isNotEqualTo GVAR(CurrentPrimaryWeapon) }
	) then {
		GVAR(CurrentPrimaryWeapon) = _pw;
		GVAR(ACE_InspectActionClass) set [2, getText(configFile >> "CfgWeapons" >> _pw >> "picture")];

		// Cache weapon family
		_pw spawn FUNC(getClassFamily);
	};

	if (GVAR(Force) && !isNil SVAR(ACEUnjamFailChance)) then {
		ace_overheating_unJamFailChance = [GVAR(ACEUnjamFailChance), 1] select (_newWeapon isEqualTo _pw);
	};
}, true] call CBA_fnc_addPlayerEventHandler;
