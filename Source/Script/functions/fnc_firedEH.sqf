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

#include "..\macro.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

private _gun = primaryWeapon player;
dzn_LOG = ["GUN", _gun];

if (_weapon != _gun || {_muzzle !=  _gun} || !isNil SVAR(PreventFireID)) exitWith { dzn_LOG pushBack ["Exit with: ", _gun, _weapon, _muzzle]; };

// Get jam chacne (from config or overall)
private _lastFiredGunData = player getVariable [SVAR(FiredLastGunData), []];
private _jamChance = 0;
if (_lastFiredGunData isEqualTo [] || { _gun != _lastFiredGunData select 0 }) then {
	// No gun data - get from mapping
	_jamChance = [_gun, "jam"] call GVAR(fnc_getMappingData);
	player setVariable [SVAR(FiredLastGunData), [_gun, _jamChance]];
} else {
	// Gun data cached
	_jamChance = _lastFiredGunData select 1;
};

dzn_LOG pushBack ["Jam chance: ", _jamChance];


// Check is subsonic to enlarge jam chance
if ( getNumber (configFile >> "CfgMagazines" >> _magazine >> "initSpeed") < 343 ) then {
	_jamChance = _jamChance + GVAR(SubsonicJamEffect);
};

dzn_LOG pushBack ["Jam chance (modified): ", _jamChance];

// Get random value 
private _random = random 100;

dzn_LOG pushBack ["Random: ", _random];
dzn_LOG pushBack ["Check: ", _random <= _jamChance];

// Check random vs jam chance to modify 
if (_random <= _jamChance) then {
	call GVAR(fnc_setJammed);
	
	// Stop firing
	_gun spawn {
		private _gun = _this;
		private _frame = diag_frameno;
		private _ammo = player ammo _gun;
		if (_ammo > 0) then {
			player setAmmo [_gun, 0];
			waitUntil {_frame < diag_frameno};
			player setAmmo [_gun, _ammo];
		};
	};	
};

