/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_getClassFamily

Description:
	Search and return all guns of the same family 
	(e.g. base weapon and all weapons models w. grip)

Parameters:
	_gunClass - Classname to get family <STRING>

Returns:
	_familyClasses - List of all family classes <ARRAY>

Examples:
    (begin example)
		_familyClasses = _gunClass call dzn_EJAM_fnc_getClassFamily; // [@Weapon1, @Weapon2 ... ]
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

private _class = _this;
private _parent = [_class] call BIS_fnc_baseWeapon;
private _result = [];

if (!isNil { GVAR(ClassFamiliesCache) getVariable _parent }) then {
	// Return cached data 
	_result = GVAR(ClassFamiliesCache) getVariable _parent;
	
} else {
	// Get data
	private _fnc_gfc = {
		params ["_class", "_par","_type",["_config","CfgWeapons"]];
		private _result = switch toUpper(_type) do {
			case "T";
			case "TXT";
			case "TEXT": { (getText (configFile >> _config >> _class >> _par)) };
			case "A";
			case "ARR";
			case "ARRAY": { (getArray (configFile >> _config >> _class >> _par)) };
			case "N";
			case "NUM";
			case "NUMBER": { (getNumber (configFile >> _config >> _class >> _par)) };
		};
		_result
	};

	private _allGunClasses = configFile >> "CfgWeapons";
	for "_i" from 0 to ((count _allGunClasses) - 1) do {
		private _classItem = configName (_allGunClasses select _i);

		if (_classItem != "access") then {
			if (
				[_classItem,"type","n"] call _fnc_gfc == 1
					&& {
						[_classItem,"picture","t"] call _fnc_gfc != "" 
						&& [_classItem,"model","t"] call _fnc_gfc != "" 
						&& [_classItem,"scope","n"] call _fnc_gfc == 2
					}
			) then {
				private _baseClass = [_classItem] call BIS_fnc_baseWeapon;
				if (_baseClass == _parent) then {
					_result pushBack _classItem;
				};
			};
		};
	};

	// Cache data
	GVAR(ClassFamiliesCache) setVariable [_parent, _result];
};

(_result)