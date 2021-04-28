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

	// --- Remove magazine from weapon & add to inventory
	player removePrimaryWeaponItem _gunMagClass;
	player addMagazine [_gunMagClass, _gunMagAmmo];

	// If no room for magazine - drop it
	if ((magazinesAmmo player) isEqualTo _allMags) then {
		private _holder = createVehicle ["WeaponHolderSimulated",player modelToWorld [0,0.75,0],[],0,"CAN_COLLIDE"];
		_holder addMagazineAmmoCargo [_gunMagClass, 1, _gunMagAmmo];

		"drop_mag" call FUNC(playActionSound);
		_msg = [LOCALIZE_FORMAT_STR("Hint_MagDropped"), 1.5];
	};
} else {
	private _mag = [];
	private _weaponMags = ([_gun] call CBA_fnc_compatibleMagazines) apply { toLower(_x) };

	(player getVariable [SVAR(DetachedMagazine), ""]) params ["_preferredMagType"];

	private _availableMags = (magazinesAmmo player) select { toLower(_x # 0) in _weaponMags };

	if (_preferredMagType isNotEqualTo "") then {
		// --- Get only mags of preffered type
		private _filteredMags = _availableMags select { (_x # 0) isEqualTo _preferredMagType };
		if (_filteredMags isEqualTo []) exitWith {};

		_mag = _filteredMags # 0;
	};

	if (_mag isEqualTo []) then {
		// --- Pick any compatible magazine, if no prefered found
		_mag = _availableMags # 0;
	};

	if (_mag isEqualTo []) then {
		_msg = [LOCALIZE_FORMAT_STR("Hint_NoMag"),1.5];
	} else {
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
