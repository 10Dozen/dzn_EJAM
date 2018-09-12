/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_setJammed

Description:
	Selects and applies Jam cause of current primary weapon

Parameters:
	nothing

Returns:
	nothing

Examples:
    (begin example)
		call dzn_EJAM_fnc_setJammed
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

// --- Check that weapon is not jammed already
private _gun = [primaryWeapon player] call BIS_fnc_baseWeapon;
private _jamCauses = player getVariable [SVAR(Cause), []];

if !( (_jamCauses select { _gun == _x # 0 }) isEqualTo [] ) exitWith {
	// --- Weapon is already jammed - do nothing
};

// --- Select jam cause
private _weights = [_gun, "malfunction"] call GVAR(fnc_getMappingData);
private _cause = GVAR(Causes) selectRandomWeighted _weights;

_cause params ["_causeID","_weaponState"];

// Set weapon state
_weaponState call GVAR(fnc_setWeaponState);

// List weapon as jammed -- add gun to cause list
_jamCauses pushBack [_gun, _causeID];
player setVariable [SVAR(Cause), _jamCauses];

// Set gun jamming
if !(missionNamespace getVariable ["ace_overheating_enabled",false]) then {
	// No ACE_Overheating 

	if (isNil SVAR(PreventFireID)) then {
		// Adding prevent fire handler
		// until player's weapon is in jammed list - it will prevent firing from this gun but allow other
		GVAR(PreventFireID) = player addAction [
			"", {
				playSound3D ['a3\sounds_f\weapons\Other\dry9.wss', _this select 0];
			}, "", 0, false, true, "DefaultAction"
			, format [
				"_muzzle = str(currentMuzzle player) splitString '""' joinString '';				
				(_muzzle == primaryWeapon player) 
				&& [player, primaryWeapon player] call CBA_fnc_canUseWeapon 
				&& ""inspect"" call %1"
				, SVAR(fnc_checkJammed)
			]
		];
	};
} else {

	// ACE_Overheating
	[player, primaryWeapon player] call ace_overheating_fnc_jamWeapon;

	[] spawn {
		// Async jam whole weapon family (w. and w/o grips)
		private _aceJammed = player getVariable ["ace_overheating_jammedWeapons", []];
		private _family = (primaryWeapon player) call GVAR(fnc_getClassFamily);
		{ _aceJammed pushBackUnique _x; } forEach _family;
	};
};

// Hang fire case
if (_causeID == "hang_fire") then {
	[] spawn GVAR(fnc_hangFireHandler);
};