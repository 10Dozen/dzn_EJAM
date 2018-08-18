/*
	author: 10Dozen
	description: Process magazine detach/attach action called from Weapon Malfunction menu
		if appropriate setting is turned on. Detached magazine will be dropped in front of player,
	returns: nothing

	Note:
		- Add Round loosing support
*/

if (!dzn_EJAM_handleMag) exitWith {};

private _needRemove = _this;
private _gun = primaryWeapon player;

if (_needRemove) then {
	private _allMags = magazinesAmmo player;
	private _gunMagClass = (primaryWeaponMagazine player) select 0;
	private _gunMagAmmo = player ammo _gun;

	player removePrimaryWeaponItem _gunMagClass;
	player addMagazine [_gunMagClass, _gunMagAmmo];
	if ((magazinesAmmo player) isEqualTo _allMags) then {
		private _holder = createVehicle ["WeaponHolderSimulated",player modelToWorld [0,0.75,0], [],0,"CAN_COLLIDE"];
		_holder addMagazineAmmoCargo [_gunMagClass, 1, _gunMagAmmo];

		"drop_mag" call dzn_EJAM_fnc_playActionSound;
		[localize "STR_EJAM_Hint_MagDropped",1.5] call ace_common_fnc_displayTextStructured;
	};
} else {
	private _weaponMags = (getArray (configFile >> "CfgWeapons" >> _gun >> "magazines")) apply { toLower(_x) };
	private _mag = [];
	{
		if (toLower(_x select 0) in _weaponMags) exitWith {	_mag = _x; };
	} forEach (magazinesAmmo player);

	player addPrimaryWeaponItem (_mag select 0);
	player setAmmo [primaryWeapon player, (_mag select 1)];
	player removeMagazine (_mag select 0);

	[localize "STR_EJAM_Hint_MagAttached",1.5] call ace_common_fnc_displayTextStructured;
};



/*

private _needRemove = _this;

private _gun = primaryWeapon player;
private _gunAttachements = primaryWeaponItems player;
private _gunAttachementsState = [player isFlashlightOn _gun, player isIRLaserOn _gun];
private _zeroing = currentZeroing player;

private _magsAmmo = magazinesAmmo player;
private _curWeaponMags = (getArray (configFile >> "CfgWeapons" >> _gun >> "magazines")) apply { toLower(_x) };


private _magsToDelete = [];
private _magsToReAdd = [];

if (_needRemove) then {
	player setVariable ["dzn_EJAM_RemovedMagazine",  [weaponState player select 3, weaponState player select 4]];
	_magsToReAdd pushBack [weaponState player select 3, weaponState player select 4];
};

{
	if (toLower(_x select 0) in _curWeaponMags) then {
		_magsToReAdd pushBack _x;
		_magsToDelete pushBack (_x select 0);
	};
} forEach _magsAmmo;

C1 = _magsToReAdd;
C2 = _magsToDelete;
player removeWeapon _gun;
{ player removeMagazine _x } forEach _magsToDelete;

if (_needRemove) then {
	player addWeapon _gun;
	{ player addMagazine _x } forEach _magsToReAdd;
} else {
	if (!isNil {player getVariable "dzn_EJAM_RemovedMagazine"}) then {
		private _curMag = player getVariable "dzn_EJAM_RemovedMagazine";
		_magsToReAdd = _magsToReAdd - [_curMag];

		if (player getVariable ["dzn_EJAM_LooseRound", false]) then {
			if (_curMag select 1 == 1) then {
				_curMag = _magsToReAdd select 0;
				_magsToReAdd deleteAt 0;
			} else {
				_curMag set [1, (_curMag select 1) - 1];
			};
		};

		player addMagazine [_curMag select 0, _curMag select 1];
		player addWeapon _gun;
		{ player addMagazine _x } forEach _magsToReAdd;
	} else {
		{ player addMagazine _x } forEach _magsToReAdd;
		player addWeapon _gun;
	};
};

player selectWeapon (primaryWeapon player);
{ player addPrimaryWeaponItem _x; } forEach _gunAttachements;
if (_gunAttachementsState select 0) then { player action ["GunLightOn", player]; };
if (_gunAttachementsState select 1) then { player action ["IRLaserOn", player]; };
player setVariable ["dzn_EJAM_LooseRound", nil];

if (_zeroing != currentZeroing player) then {
	// hint parseText format ["<t size='1.25' color='#FFFF00'>Warning!</t><br />Weapon zeroing was reset (previous %1)", _zeroing];
	[ format ["<t size='1.25' color='#FFFF00'>Warning!</t><br />Weapon zeroing was reset (previous %1)",_zeroing],3] call ace_common_fnc_displayTextStructured;
};

*/