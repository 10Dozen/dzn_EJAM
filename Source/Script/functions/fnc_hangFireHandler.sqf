/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_hangFireHandler

Description:
	Handles "hang fire" malfunction by forcing single shot after random timeout. 
	If shot was done - weapon unjams.
	If no shot was done (due to animations, mounting vehicles, etc.) - handler tries 
	to make another shot and if it isn't done -- remain weapon jammed.

Parameters:
	nothing

Returns:
	nothing

Examples:
    (begin example)
		[] spawn dzn_EJAM_fnc_hangFireHandler
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

// Var to handle Pull bolt action during hang fire
player setVariable [SVAR(HangFire_InitiatedRoundLoaded), true];
(weaponState player) params ["_gun","_muzzle","_mode","_mag","_ammo"];

// Timeout for hang fire
sleep (1 + random(4));

if !(player getVariable SVAR(HangFire_InitiatedRoundLoaded)) exitWith {
	// Round was removed by pulling the bolt - exit from handler

	// --- Play sound and spawn projectile of extracted round
	private _ammoClass = getText (configFile >> "CfgMagazines" >> _mag >> "ammo");
	private _sound = "a3\sounds_f\weapons\TRG20\Trg_shot_1.wss";
	private _pos = player modelToWorld [1 + random 0.5,0,-1];
	_pos set [2,0.1];

	playSound3d [_sound, player, false, _pos, 0.75, 1.75];
	private _projectile = createVehicle [_ammoClass, _pos, [], 0, "CAN_COLLIDE"];
	private _vectorAmmo = [(-1 + (random 2)), (-1 + (random 2)), -0.2 + (random 1)];
	private _velVec = _vectorAmmo vectorMultiply 100;
	_projectile setVectorDir _velVec;
	_projectile setVelocity _velVec;
};

// Bolt is not pulled during the timeout - make shot
_ammo = weaponState player # 4;
private _shotDone = false;
player forceWeaponFire [_muzzle,_mode];

if (_ammo == 0) exitWith {
	// --- Reload happened or empty mag - leave dud round
};

// Check shot was fired
private _ammoAfter = (weaponState player) select 4;

if (_ammoAfter == _ammo) then {
	// No shot done due some reasons - make little timeout and retry
	sleep 0.25;
	player forceWeaponFire [_muzzle,_mode];

	if (_ammoAfter != ((weaponState player) select 4)) then {
		// Shot done: mark that hang round is removed
		_shotDone = true;
	};
} else {
	// Shot done: mark that hang round is removed
	_shotDone = true;
};

if !(_shotDone) exitWith {
	// Exit if no shot was done - assume that malfunction is simple 'dud'
};

// --- Shot done:
closeDialog 2;
sleep 0.1;

// Update weapon state and check fixed
(call GVAR(fnc_getWeaponState)) params ["_bolt", "_chamber", "_case", "_magState"]; // ["bolt_not_closed","chamber_stucked","case_ejected","mag_attached"]

if (_bolt == "bolt_closed") then {
	if (_magState == "mag_attached") then {
		// Unjammed
		[nil,"chamber_ready",nil,nil] call GVAR(fnc_setWeaponState);
	} else {
		// Almost unjammed
		[nil,"chamber_empty",nil,nil] call GVAR(fnc_setWeaponState);
	};
} else {
	[nil,"chamber_empty","case_not_ejected",nil] call GVAR(fnc_setWeaponState);
};

// Process weapon (and fix if conditions met)
call GVAR(fnc_processWeaponFixed);
player setVariable [SVAR(HangFire_InitiatedRoundLoaded), nil];