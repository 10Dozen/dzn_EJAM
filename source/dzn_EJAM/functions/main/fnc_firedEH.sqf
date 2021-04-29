/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_firedEH

Description:
	--

Parameters:
	_FiredEH - Eventhandler data of "Fired" EH <STRING>

Returns:
	nothing

Examples:
    (begin example)
		_firedEH call dzn_EJAM_fnc_firedEH;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

private _gun = primaryWeapon player;
if ( _weapon != _gun || {_muzzle !=  _gun} || "inspect" call FUNC(checkJammed) ) exitWith {
	// Exit if fired not a main muzzle (e.g. UGL) OR weapon already jammed
};

// Get jam chance (from config or overall)
private _lastFiredGunData = player getVariable [SVAR(FiredLastGunData), []];
private _jamChance = 0;
if (_lastFiredGunData isEqualTo [] || { _gun != _lastFiredGunData select 0 }) then {
	// No gun data - get from mapping
	_jamChance = [_gun, "jam"] call FUNC(getMappingData);
	player setVariable [SVAR(FiredLastGunData), [_gun, _jamChance]];
} else {
	// Gun data cached
	_jamChance = _lastFiredGunData select 1;
};

if (_jamChance isEqualTo 0) exitWith {
		// No jam may happen if there is 0 chance in config/settings
};

// Check is subsonic to enlarge jam chance
_magazine = toLower(_magazine);
if (GVAR(SubsonicMagazines) findIf { _magazine isEqualTo _x } > -1) then {
	_jamChance = _jamChance + GVAR(SubsonicJamEffect);
};

// Get random value
private _random = random 100;

// Check random vs jam chance to modify
if (_random <= _jamChance) then {
	// Stop firing
	private _ammo = player ammo _gun;
	player setAmmo [_gun, 0];
	[{
		params ["_gun","_ammo"];
		player setAmmo [_gun, _ammo];

		[true] call FUNC(setJammed);
	}, [_gun, _ammo]] call CBA_fnc_execNextFrame;
};
