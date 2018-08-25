/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_getMappingData

Description:
	Return jam/malfunctions mapping data.

Parameters:
	_weaponClass - Classname of weapon to get data <STRING>
	_dataType - Type of data to return: "jam" or "malfunction" <STRING>
	_isForConfig - (optional) Is data returned for config or for inner functions. Default: false <BOOL>

Returns:
	_data - Mapping data (<NUMBER> for "jam") or (<ARRAY> of "malfunction")

Examples:
    (begin example)
		_jamCahcne = [_gun, "jam"] call dzn_EJAM_fnc_getMappingData; // 1.5
		_malfunctionWeights = [_gun, "malfunction"] call dzn_EJAM_fnc_getMappingData; // [20,20,25,25,10]
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

params ["_gun", "_type", ["_isForConfig", false]];

_gun = [_gun] call BIS_fnc_baseWeapon;
_type = toLower(_type);

private _result = -1;
private _data = GVAR(Mapping) select { _gun == _x select 0 };

if (_data isEqualTo []) then {
	
	// No config - use default
	// GVAR(Causes) apply {	call compile FORMAT_VAR((_x select 0) + "_ChanceSettings") };

	if !(_isForConfig) then {
		_data = [
			0
			, GVAR(OverallChance)
			, GVAR(feed_failure_ChanceSettings)
			, GVAR(feed_failure_2_ChanceSettings)
			, GVAR(dud_ChanceSettings)
			, GVAR(fail_to_extract_ChanceSettings)
			, GVAR(fail_to_eject_ChanceSettings)
		];
	} else {
		_data = [0,0,0,0,0,0,0];
	};
} else {

	// Config specified
	_data = [] + (_data select 0);
};

switch toLower(_type) do {
	case "jam": {
		_result = _data select 1;
	};
	case "malfunction": {
		_data deleteRange [0,2];
		_result = _data;
	};
};

(_result)