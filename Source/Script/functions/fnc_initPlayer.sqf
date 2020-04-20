/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_initPlayer

Description:
	Inits player vars and stuff on spawn

Parameters:
	none

Returns:
	nothing

Examples:
    (begin example)
		[] call dzn_EJAM_fnc_initPlayer;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

// Run EJAM's FiredEH if ACE Overheating disabled OR EJAM Jam chance forced
if (!(missionNamespace getVariable ["ace_overheating_enabled",false]) || GVAR(ForceOverallChance)) then {
	GVAR(FiredEH) = player addEventHandler ["Fired", { call GVAR(fnc_firedEH) }];
};

if (!isNil "ace_overheating_unJamFailChance") then {
	private _oldFailChance = ace_overheating_unJamFailChance;
	ace_overheating_unJamFailChance = 0;

	{
		[player, _x, true] call ace_overheating_fnc_clearJam;
	} forEach (player getVariable ["ace_overheating_jammedWeapons", []]);

	ace_overheating_unJamFailChance = _oldFailChance;
};

player setVariable ["ace_overheating_jammedWeapons", []];
player setVariable [SVAR(Cause), []];
player setVariable [SVAR(RemovedMagazine), nil];
player setVariable [SVAR(LooseRound), nil];
player setVariable [SVAR(WeaponState), nil];

if (!isNil SVAR(PreventFireID)) then {
	player removeAction GVAR(PreventFireID);
	GVAR(PreventFireID) = nil;
};