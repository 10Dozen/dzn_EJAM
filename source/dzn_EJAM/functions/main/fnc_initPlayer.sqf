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

#include "..\script_macro.hpp"

player setVariable [SVAR(Cause), []];
player setVariable [SVAR(RemovedMagazine), nil];
player setVariable [SVAR(LooseRound), nil];
player setVariable [SVAR(WeaponState), nil];

if (!isNil SVAR(PreventFireID)) then {
	player removeAction GVAR(PreventFireID);
	GVAR(PreventFireID) = nil;
};

// Run EJAM's FiredEH if ACE Overheating disabled OR EJAM Jam chance forced
if (!(missionNamespace getVariable ["ace_overheating_enabled",false]) || GVAR(ForceOverallChance)) then {
	GVAR(FiredEH) = player addEventHandler ["Fired", { call FUNC(firedEH) }];
};

if (!isNil "ace_overheating_unJamFailChance") then {
	private _jammedList = player getVariable ["ace_overheating_jammedWeapons", []];
	if (_jammedList isEqualTo []) exitWith {};

	private _acePreventFireId = player getVariable ["ace_overheating_JammingActionID", -1];
	[player, "DefaultAction", _acePreventFireId] call ace_common_fnc_removeActionEventHandler;
	player setVariable ["ace_overheating_JammingActionID", -1];
	player setVariable ["ace_overheating_jammedWeapons", []];
};

player addEventHandler ["Reloaded", { [] call FUNC(reloadedEH) }];
