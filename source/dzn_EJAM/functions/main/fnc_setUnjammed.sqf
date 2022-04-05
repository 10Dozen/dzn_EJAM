/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_setUnjammed

Description:
	Unjams player's primary weapon

Parameters:
	nothing

Returns:
	nothing

Examples:
    (begin example)
		[] call dzn_EJAM_fnc_setUnjammed
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

private _gun = [primaryWeapon player] call BIS_fnc_baseWeapon;

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

	private _primary = primaryWeapon player;
	private _family = (_gun call FUNC(getClassFamily)) - [_primary];
	private _aceJammed = player getVariable ["ace_overheating_jammedWeapons", []];
	player setVariable ["ace_overheating_jammedWeapons", _aceJammed - _family];

	ace_overheating_unJamFailChance = 0;
	[player, _primary, true] call ace_overheating_fnc_clearJam;
	ace_overheating_unJamFailChance = _oldFailChance;
};
