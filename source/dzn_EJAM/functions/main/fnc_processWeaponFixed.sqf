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

#include "..\script_macro.hpp"

if (isNil { player getVariable SVAR(WeaponState) }) exitWith {};

(call FUNC(getWeaponState)) params ["_bolt","_chamber","_case","_mag"];

if (
	_bolt != STATE_BOLT_NOT_CLOSED
	&& _chamber in [STATE_CHAMBER_READY,STATE_CHAMBER_EMPTY]
	&& _case == STATE_CASE_EJECTED
	&& _mag == STATE_MAG_ATTACHED
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
	[] call FUNC(setUnjammed);
};
