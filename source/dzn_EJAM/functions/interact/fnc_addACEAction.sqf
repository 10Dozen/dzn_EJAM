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
GVAR(CurrentPrimaryWeapon) = "";
GVAR(ACE_Weapon_EH) = ["weapon", { _this call FUNC(weaponEH); }, true] call CBA_fnc_addPlayerEventHandler;
GVAR(ACE_SettingChanged_EH) = ["ace_settingChanged", {
	params ["_name","_value"];
	if (_name isNotEqualTo "ace_overheating_unJamFailChance") exitWith {};

	// Update fallback value
	GVAR(ACEUnjamFailChance) = ace_overheating_unJamFailChance;

	// Restore 100% fail chance if primary weapon still in hands
	if (currentWeapon player isNotEqualTo primaryWeapon player) exitWith {};
	ace_overheating_unJamFailChance = 1;
}] call CBA_fnc_addEventHandler;

// Call EH once on start
[nil, currentWeapon player, nil] call FUNC(weaponEH);
