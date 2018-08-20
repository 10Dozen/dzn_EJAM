/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_inspectWeapon

Description:
	Open Unjam menu or draw hint if weapon is not jammed.

Parameters:
	nothing

Returns:
	nothing

Examples:
    (begin example)
		call dzn_EJAM_fnc_inspectWeapon;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

if ("inspect" call GVAR(fnc_checkJammed)) then {
	[] spawn GVAR(fnc_uiShowUnjamMenu);
} else {
	hint parseText format [
		"<t shadow='2' size='1.25'>%1</t><br /><img image='%2' size='5'/>"
		, LOCALIZE_FORMAT_STR("Hint_WeaponOK")
		, getText (configFile >> "CfgWeapons" >> primaryWeapon player >> "picture")
	];
};