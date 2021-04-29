/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_processMappingData

Description:
	Update ACE Overheating cache data and set up EJAM customized config
	according to dzn_EJAM Jam chance Mapping

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

#include "..\script_macro.hpp"

// Reset EJAM's config
private _configVars = allVariables GVAR(ConfigData);
{
	GVAR(ConfigData) setVariable [_x, nil];
} forEach _configVars;

{
	_x params ["_gun","_jamChance"];

	_gun = [_gun] call BIS_fnc_baseWeapon;

	if (isNil {ace_overheating_cacheWeaponData getVariable _gun}) then {
		[_gun] call ace_overheating_fnc_getWeaponData;
	};

	private _data = ace_overheating_cacheWeaponData getVariable _gun;

	// Set ACE Overheating customized data
	_data set [2, _jamChance/100];
	ace_overheating_cacheWeaponData setVariable [_gun, _data];

	// Set EJAM customized data for weapon
	GVAR(ConfigData) setVariable [_gun, _x select [1,6]];

} forEach GVAR(Mapping);
