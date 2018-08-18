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

if (true call GVAR(fnc_checkJammed)) then {
	[] spawn GVAR(fnc_ShowUnjamMenu);
} else {
	hint parseText format ["<t shadow='2' size='1.25'>%1</t>", LOCALIZE_FORMAT_STR("Hint_WeaponOK")];
}