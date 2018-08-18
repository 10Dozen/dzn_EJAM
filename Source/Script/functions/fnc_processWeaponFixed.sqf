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

(player getVariable SVAR(WeaponState)) params ["_bolt","_chamber","_case","_mag"];

if (
	_bolt != "bolt_not_closed"
	&& _chamber in ["chamber_ready","chamber_empty"]
	&& _case == "case_ejected"
	&& _mag == "mag_attached"
) then {
	private _oldFailChance = ace_overheating_unJamFailChance;
	ace_overheating_unJamFailChance = 0;

	[player, currentWeapon player, true] call ace_overheating_fnc_clearJam;
	player playActionNow "gestureYes";

	ace_overheating_unJamFailChance = _oldFailChance;

	player setVariable [SVAR(Cause), nil];
	player setVariable [SVAR(WeaponState), nil];
	player setVariable [SVAR(CauseSet), false];
	player setVariable [SVAR(RemovedMagazine), nil];
	player setVariable [SVAR(LooseRound), nil];
};