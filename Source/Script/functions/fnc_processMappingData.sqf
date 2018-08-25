/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_processMappingData

Description:
	Update ACE Overheating cache data according to dzn_EJAM Jam chance Mapping

Parameters:
	nothing

Returns:
	nothing

Examples:
    (begin example)
		call dzn_EJAM_fnc_processMappingData;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

{
	_x params ["_gun","_jamChance"];

	if (isNil {ace_overheating_cacheWeaponData getVariable _gun}) then {
		[_gun] call ace_overheating_fnc_getWeaponData;
	};

	private _data = ace_overheating_cacheWeaponData getVariable _gun;

	_data set [2, _jamChance/100];
	ace_overheating_cacheWeaponData setVariable [_gun, _data];
} forEach GVAR(Mapping);