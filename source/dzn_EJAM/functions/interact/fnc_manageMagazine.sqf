/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_manageMagazine

Description:
	Process magazine detach/attach action called from Weapon Malfunction menu.
	If appropriate setting is turned on - detached magazine will be dropped in front of player,

Parameters:
	_needRemove - Should magazine be detached (true) or attached (false) from weapon <BOOL>

Returns:
	nothing

Examples:
    (begin example)
		true call dzn_EJAM_fnc_manageMagazine;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

private _needRemove = _this;
private _gun = primaryWeapon player;
private _msg = [];

if (_needRemove) then {
	private _allMags = magazinesAmmo player;
	private _gunMagClass = (primaryWeaponMagazine player) # 0;
	private _gunMagAmmo = player ammo _gun;

	// --- Save magazine type as preffered for selection on attach action
	player setVariable [SVAR(DetachedMagazine), _gunMagClass];
	["ManMag:: Detached mag is %1 (%2) : %3", _gunMagClass] call EJLog;

	player removePrimaryWeaponItem _gunMagClass;
	player addMagazine [_gunMagClass, _gunMagAmmo];

	// If no room for magazine - drop it
	if ((magazinesAmmo player) isEqualTo _allMags) then {
		private _holder = createVehicle ["WeaponHolderSimulated",player modelToWorld [0,0.75,0], [],0,"CAN_COLLIDE"];
		_holder addMagazineAmmoCargo [_gunMagClass, 1, _gunMagAmmo];

		"drop_mag" call FUNC(playActionSound);
		_msg = [LOCALIZE_FORMAT_STR("Hint_MagDropped"), 1.5];
	};
} else {
	private _mag = [];
	private _weaponMags = ([_gun] call CBA_fnc_compatibleMagazines) apply { toLower(_x) };

	(player getVariable [SVAR(DetachedMagazine), ["",0]]) params ["_preferredMagType", "_preferredMagAmmoCount"];

	private _availableMags = (magazinesAmmo player) select { toLower(_x # 0) in _weaponMags };

	["ManMag:: Attaching mag"] call EJLog;
	["ManMag:: Saved mag: %1 (%2)", _preferredMagType, _preferredMagAmmoCount] call EJLog;
	["ManMag:: Compat mags available: %1", _availableMags] call EJLog;

	if (_preferredMagType isNotEqualTo "") then {
		["ManMag:: Searching for Preffered mag"] call EJLog;

		// --- Get only mags of preffered type
		private _filteredMags = _availableMags select { (_x # 0) isEqualTo _preferredMagType };
		["ManMag:: Mags of preferred type: %1", _filteredMags] call EJLog;
		if (_filteredMags isEqualTo []) exitWith {
			["ManMag:: Failed to find preferred mags"] call EJLog;
		};

		_mag = _filteredMags # 0;
	};

	if (_mag isEqualTo []) then {
		["ManMag:: No preffered found, picking any compatible mag"] call EJLog;
		// --- Pick any compatible magazine
		_mag = _availableMags # 0;
	};

	["ManMag:: Loading mag - %1", _mag] call EJLog;

	if (_mag isEqualTo []) then {
		_msg = [LOCALIZE_FORMAT_STR("Hint_NoMag"),1.5];
	} else {
		["ManMag:: Loading %1 (%2)", _mag # 0, _mag # 1] call EJLog;

		player addPrimaryWeaponItem (_mag select 0);
		player setAmmo [primaryWeapon player, (_mag select 1)];
		player removeMagazine (_mag select 0);

		player setVariable [SVAR(DetachedMagazine), nil];

		_msg = [LOCALIZE_FORMAT_STR("Hint_MagAttached"),1.5]
	};
};

if (_msg isEqualTo []) exitWith {};

if (isNil "ace_common_fnc_displayTextStructured") then {
	hint parseText (_msg select 0);
} else {
	_msg call ace_common_fnc_displayTextStructured;
};
