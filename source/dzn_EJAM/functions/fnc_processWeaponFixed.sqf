/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_processWeaponFixed

Description:
	Verify weapon states and unjam weapon

Parameters:
	nothing

Returns:
	nothing

Examples:
    (begin example)
		call dzn_EJAM_fnc_processWeaponFixed
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

if (isNil { player getVariable SVAR(WeaponState) }) exitWith {};

(call GVAR(fnc_getWeaponState)) params ["_bolt","_chamber","_case","_mag"];

if (
	_bolt != "bolt_not_closed"
	&& _chamber in ["chamber_ready","chamber_empty"]
	&& _case == "case_ejected"
	&& _mag == "mag_attached"
) then {
	[] spawn {
		if (isNil "ace_common_fnc_displayTextStructured") then {
			hint parseText LOCALIZE_FORMAT_STR("Hint_WeaponOK");
			uiSleep 2;
			hint "";
		} else {
			uiSleep 0.75;
			hint "";
		};
	};

	// Unjamming
	[] call GVAR(fnc_setUnjammed);
};