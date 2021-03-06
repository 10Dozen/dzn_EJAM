/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_setJammed

Description:
	Selects and applies Jam cause of current primary weapon

Parameters:
	_isSelfEvent -- flags that function called as a result of EJAM's EH (Bool).

Returns:
	nothing

Examples:
    (begin example)
		[true] call dzn_EJAM_fnc_setJammed
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

params ["_isSelfEvent"];

if (!isNil SVAR(ExtraEventInvoked)) exitWith {
	GVAR(ExtraEventInvoked) = nil;
};


private _gun = [primaryWeapon player] call BIS_fnc_baseWeapon;
private _weights = [_gun, "malfunction"] call FUNC(getMappingData);
private _cause = GVAR(Causes) selectRandomWeighted _weights;

_cause params ["_causeID","_weaponState"];

// Set weapon state
_weaponState call FUNC(setWeaponState);

// Remove round from magazine in case it was picked, but failed to be used
if (_causeID == CAUSE_CHAMBER_FAILURE) then {

	if (_isSelfEvent) then {
		[] call FUNC(wasteRound);
	} else {
		[{
			[] call FUNC(wasteRound);
		}] call CBA_fnc_execNextFrame;
	};
};

// List weapon as jammed
private _jamCauses = player getVariable [SVAR(Cause), []];
if ((_jamCauses select { _gun == _x # 0 }) isEqualTo []) then {

	// Add gun to cause list
	_jamCauses pushBack [_gun, _causeID];
	player setVariable [SVAR(Cause), _jamCauses];
} else {

	// Update gun in cause list (actually there is no case for that)
	private _itemInList = (_jamCauses select { _gun == _x # 0 }) # 0;
	_itemInList set [1, _causeID];
};

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
	if (_isSelfEvent) then {
		GVAR(ExtraEventInvoked) = true;
		[player, primaryWeapon player] call ace_overheating_fnc_jamWeapon;
	};

	[] spawn {
		// Async jam whole weapon family (w. and w/o grips)
		private _aceJammed = player getVariable ["ace_overheating_jammedWeapons", []];
		private _family = (primaryWeapon player) call FUNC(getClassFamily);
		{ _aceJammed pushBackUnique _x; } forEach _family;
	};
};
