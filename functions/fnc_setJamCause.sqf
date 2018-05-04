/*
	author: 10Dozen
	description: Selects and applies Jam cause
	returns: nothing
*/

(selectRandom dzn_EJAM_Causes) params ["_causeID", "_causeName", "_weaponState", "_actionList"];

_weaponState call dzn_EJAM_fnc_setWeaponState;
player setVariable ["dzn_EJAM_Cause", _causeID];
player setVariable ["dzn_EJAM_CauseSet", true];