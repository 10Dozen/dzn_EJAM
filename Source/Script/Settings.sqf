#include "macro.hpp"

// Addon Settings

private _add = {
	params ["_var","_type","_val",["_exp", "No Expression"],["_subcat", ""],["_isGlobal", true]];	
	 
	private _arr = [
		FORMAT_VAR(_var)
		, _type
		, [LOCALIZE_FORMAT_STR(_var), LOCALIZE_FORMAT_STR_desc(_var)]		
		, if (_subcat == "") then { TITLE } else { [TITLE, _subcat] }
		, _val
		, _isGlobal
	];
	
	if !(typename _exp == "STRING" && { _exp == "No Expression" }) then { _arr pushBack _exp; };
	_arr call CBA_Settings_fnc_init;
};

private _addLocal = {
	params ["_var", "_type", "_val"];
	[_var, _type, _val, nil, nil, false] call _add;
};

// Option to override ACE Unjam
[
	"Force"
	, "CHECKBOX"
	, true 
] call _add;

// Handle magazine attach/detach
[
	"HandleMag"
	, "CHECKBOX"
	, true 
] call _addLocal;

// Chance of Malfunctions
[
	"feed_failure_ChanceSettings"
	, "SLIDER"
	, [1, 100, 20, 0] 
] call _add;

[
	"feed_failure_2_ChanceSettings"
	, "SLIDER"
	, [1, 100, 20, 0] 
] call _add;

[
	"dud_ChanceSettings"
	, "SLIDER"
	, [1, 100, 20, 0] 
] call _add;

[
	"fail_to_extract_ChanceSettings"
	, "SLIDER"
	, [1, 100, 20, 0] 
] call _add;

[
	"fail_to_eject_ChanceSettings"
	, "SLIDER"
	, [1, 100, 20, 0] 
] call _add;

// Mapping of gun classes on jam settings
/*
[
	"MappingSettings"
	, "EDITBOX"
	, str(GVAR(Mapping)) select [1, count str(GVAR(Mapping)) -2]
	, { 
		// GVAR(Mapping) = call compile ("[" + _this + "]");
	}
] call _add;
*/



// Keybinding
private _addKey = {
	params["_var","_str","_downCode",["_defaultKey", nil],["_upCode", {}]];

	private _settings = [
		TITLE
		, FORMAT_VAR(_var)
		, LOCALIZE_FORMAT_STR(_str)
		, _downCode
		, _upCode
	];

	if (!isNil "_defaultKey") then { _settings pushBack _defaultKey; };
	_settings call CBA_fnc_addKeybind;
};

// Inspect weapon key
[
	"InspectKey"
	, "Action_Inspect"
	, { call GVAR(fnc_inspectWeapon) }
	, [19, [false,true,false]]
] call _addKey;

// Pull bolt key
[
	"PullBoltKey"
	, "Action_PullBolt"
	, { "pull_bolt" call GVAR(fnc_doHotkeyAction); }
] call _addKey;

// Toggle magazine key
[
	"MagazineKey"
	, "Action_MagazineToggle"
	, { 
		(call GVAR(fnc_getWeaponState)) params ["","","","_mag"];
		private _action = if (_mag == "mag_attached") then { "detach_mag" } else { "attach_mag" };
		_action call GVAR(fnc_doHotkeyAction);
	}
] call _addKey;

// Open bolt key
[
	"OpenBoltKey"
	, "Action_OpenBolt"
	, { "open_bolt" call GVAR(fnc_doHotkeyAction); }
] call _addKey;

// Clear chamber key 
[
	"ClearChamnerKey"
	, "Action_ClearChamber"
	, { "clear_chamber" call GVAR(fnc_doHotkeyAction); }
] call _addKey;

// Remove case key
[
	"RemoveCaseKey"
	, "Action_RemoveCase"
	, { "remove_case" call GVAR(fnc_doHotkeyAction); }
] call _addKey;