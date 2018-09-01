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

private _gun = [primaryWeapon player] call BIS_fnc_baseWeapon;
(call GVAR(fnc_getWeaponState)) params ["_bolt","_chamber","_case","_mag"];

if (
	_bolt != "bolt_not_closed"
	&& _chamber in ["chamber_ready","chamber_empty"]
	&& _case == "case_ejected"
	&& _mag == "mag_attached"
) then {

	// Unset weapon from jamming/weapon state lists
	private _causes = player getVariable SVAR(Cause);
	private _states = player getVariable SVAR(WeaponState);

	player setVariable [
		SVAR(WeaponState)
		, _states - (_states select { _gun == _x select 0 })		
	];
	player setVariable [
		SVAR(Cause)
		, _causes - (_causes select { _gun == _x select 0 })		
	];
	player setVariable [SVAR(RemovedMagazine), nil];
	player setVariable [SVAR(LooseRound), nil];

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
	if !(missionNamespace getVariable ["ace_overheating_enabled",false]) then {

		// No ACE Overheating
		// Remove Prevent Fire handler once all guns were unjammed
		if ((player getVariable [SVAR(Cause), []]) isEqualTo []) then {			
			player removeAction GVAR(PreventFireID);
			GVAR(PreventFireID) = nil;
		};

	} else {

		// ACE Overheating enabled
		private _oldFailChance = ace_overheating_unJamFailChance;
		ace_overheating_unJamFailChance = 0;

		private _family = (primaryWeapon player) call GVAR(fnc_getClassFamily);
		{
			[player, _x, true] call ace_overheating_fnc_clearJam;
		} forEach _family;

		ace_overheating_unJamFailChance = _oldFailChance;
	};
};