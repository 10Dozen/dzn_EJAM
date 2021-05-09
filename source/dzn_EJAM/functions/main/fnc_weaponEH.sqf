/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_weaponEH

Description:
	Handles weapon change and applies actual ACE Unjam chance to handle
	primary weapon handling via EJAM and pistols via ACE.

Parameters:
	_weaponEH - Eventhandler data of CBA's "Weapon" EH <ARRAY>

Returns:
	nothing

Examples:
    (begin example)
		_reloadedEH call dzn_EJAM_fnc_weaponEH;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

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
