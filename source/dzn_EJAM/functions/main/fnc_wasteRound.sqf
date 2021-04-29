/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_wasteRound

Description:
	Removes wasted round from currently loaded magazine of main muzzle.

Parameters:
	_numberOfRounds - number of rounds to remove from mag (Number). Default: 1.

Returns:
	nothing

Examples:
    (begin example)
		[2] call dzn_EJAM_fnc_wasteRound; // Removes 2 rounds
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */
#include "..\script_macro.hpp"

params [["_numberOfRounds", 1]];

private _gun = primaryWeapon player;
private _ammo = (player ammo _gun) - _numberOfRounds;

if (_ammo < 0) then { _ammo = 0 };

player setAmmo [_gun, _ammo];
