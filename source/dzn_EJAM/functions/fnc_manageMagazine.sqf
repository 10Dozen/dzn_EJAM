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

#include "..\macro.hpp"

private _needRemove = _this;
private _gun = primaryWeapon player;
private _msg = [];

if (_needRemove) then {
	private _allMags = magazinesAmmo player;
	private _gunMagClass = (primaryWeaponMagazine player) select 0;
	private _gunMagAmmo = player ammo _gun;

	player removePrimaryWeaponItem _gunMagClass;
	player addMagazine [_gunMagClass, _gunMagAmmo];

	if ((magazinesAmmo player) isEqualTo _allMags) then {
		private _holder = createVehicle ["WeaponHolderSimulated",player modelToWorld [0,0.75,0], [],0,"CAN_COLLIDE"];
		_holder addMagazineAmmoCargo [_gunMagClass, 1, _gunMagAmmo];

		"drop_mag" call GVAR(fnc_playActionSound);
		_msg = [LOCALIZE_FORMAT_STR("Hint_MagDropped"), 1.5];
	};
} else {
	private _weaponMags = (getArray (configFile >> "CfgWeapons" >> _gun >> "magazines")) apply { toLower(_x) };
	private _mag = [];
	{
		if (toLower(_x select 0) in _weaponMags) exitWith {	_mag = _x; };
	} forEach (magazinesAmmo player);

	if (_mag isEqualTo []) then {
		_msg = [LOCALIZE_FORMAT_STR("Hint_NoMag"),1.5];		
	} else {
		player addPrimaryWeaponItem (_mag select 0);
		player setAmmo [primaryWeapon player, (_mag select 1)];
		player removeMagazine (_mag select 0);

		_msg = [LOCALIZE_FORMAT_STR("Hint_MagAttached"),1.5]
	};
};

if (_msg isEqualTo []) exitWith {};

if (isNil "ace_common_fnc_displayTextStructured") then {
	hint parseText (_msg select 0);
} else {
	_msg call ace_common_fnc_displayTextStructured;
};