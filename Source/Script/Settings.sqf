#include "macro.hpp"

// Addon Settings

private _add = {
	params ["_var","_type","_val",["_exp", "No Expression"],["_subcat", ""],["_isGlobal", false]];	
	 
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

// Option to force EJAM's Jam chance over ACE
[
	"ForceOverallChance"
	, "CHECKBOX"
	, true 
] call _add;

// Overall jam chance
[
	"OverallChanceSetting"
	, "SLIDER"
	, [0,100, 0.01, 2]
	, {
		GVAR(OverallChance) = _this;

		// Reset cache
		player setVariable [SVAR(FiredLastGunData), nil];
	}
] call _add;

// Chance of Malfunctions
[
	"feed_failure_ChanceSettings"
	, "SLIDER"
	, [0, 100, 60, 0] 
	, {	/* Reset cache */  player setVariable [SVAR(FiredLastGunData), nil]; }
] call _add;

[
	"feed_failure_2_ChanceSettings"
	, "SLIDER"
	, [0, 100, 20, 0] 
	, {	/* Reset cache */  player setVariable [SVAR(FiredLastGunData), nil]; }
] call _add;

[
	"dud_ChanceSettings"
	, "SLIDER"
	, [0, 100, 60, 0] 
	, {	/* Reset cache */  player setVariable [SVAR(FiredLastGunData), nil]; }
] call _add;

[
	"fail_to_extract_ChanceSettings"
	, "SLIDER"
	, [0, 100, 20, 0] 
	, {	/* Reset cache */  player setVariable [SVAR(FiredLastGunData), nil]; }
] call _add;

[
	"fail_to_eject_ChanceSettings"
	, "SLIDER"
	, [0, 100, 20, 0] 
	, {	/* Reset cache */  player setVariable [SVAR(FiredLastGunData), nil]; }
] call _add;

// Subsonic ammo effect on jam chance
[
	"SubsonicJamEffectSetting"
	, "EDITBOX"
	, "0.05"
	, {
		GVAR(SubsonicJamEffect) = parseNumber _this;
	}
] call _add;

[
	"SubsonicMagazinesSettings"
	, "EDITBOX"
	, '"cup_30rnd_subsonic_545x39_ak_m","cup_20rnd_subsonic_545x39_aksu_m","cup_30rnd_subsonic_545x39_ak74m_m","cup_30rnd_subsonic_545x39_ak74_plum_m","cup_30rnd_subsonic_762x39_ak47_m","cup_20rnd_subsonic_762x39_amd63_m","cup_30rnd_subsonic_762x39_ak47_bakelite_m","cup_30rnd_subsonic_762x39_ak103_bakelite_m","cup_30rnd_subsonic_762x39_akm_bakelite_desert_m","cup_30rnd_subsonic_545x39_fort224_m","rhs_30rnd_545x39_7u1_ak","rhs_45rnd_545x39_7u1_ak","rhs_30rnd_762x39mm_u","rhs_30rnd_762x39mm_bakelite_u","rhs_30rnd_762x39mm_polymer_u","hlc_30rnd_545x39_s_ak","hlc_30rnd_545x39_s_ak_plum","hlc_30rnd_545x39_s_ak_black","hlc_20rnd_762x51_s_fal","hlc_10rnd_762x51_s_fal","hlc_20rnd_762x51_s_g3"'
	, {
		GVAR(SubsonicMagazines) = (call compile ("[" + _this + "]")) apply { toLower _x };
	}
] call _add;

// Mapping of gun classes on jam settings
[
	"MappingSettings"
	, "EDITBOX"
	, str(GVAR(Mapping)) select [1, count str(GVAR(Mapping)) -2]
	, { 
		GVAR(Mapping) = call compile ("[" + _this + "]");
		call GVAR(fnc_processMappingData);

		// Reset cache
		player setVariable [SVAR(FiredLastGunData), nil];
	}
] call _add;

// Keybinding
#define ALLOW_OVERRIDE !([] call GVAR(fnc_isInVehicleCrew))
private _addKey = {
	params["_var","_str","_downCode",["_defaultKey", nil],["_upCode", { false }]];

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
	, { call GVAR(fnc_inspectWeapon); ALLOW_OVERRIDE }
	, [19, [false,true,false]]
	, { true }
] call _addKey;

[
	"QuickInspectKey"
	, "Action_QuickInspect"
	, { "inspect" call GVAR(fnc_doHotkeyAction); ALLOW_OVERRIDE }
] call _addKey;

// Pull bolt key
[
	"PullBoltKey"
	, "Action_PullBolt"
	, { "pull_bolt" call GVAR(fnc_doHotkeyAction); ALLOW_OVERRIDE }
] call _addKey;

// Open bolt key
[
	"OpenBoltKey"
	, "Action_OpenBolt"
	, { "open_bolt" call GVAR(fnc_doHotkeyAction); ALLOW_OVERRIDE }
] call _addKey;

// Toggle magazine key
[
	"MagazineKey"
	, "Action_MagazineToggle"
	, { 
		(call GVAR(fnc_getWeaponState)) params ["","","","_mag"];
		private _action = if (_mag == "mag_attached") then { "detach_mag" } else { "attach_mag" };
		_action call GVAR(fnc_doHotkeyAction);
		ALLOW_OVERRIDE
	}
] call _addKey;

// Clear chamber key 
[
	"ClearChamnerKey"
	, "Action_ClearChamber"
	, { "clear_chamber" call GVAR(fnc_doHotkeyAction); true }
] call _addKey;

// Remove case key
[
	"RemoveCaseKey"
	, "Action_RemoveCase"
	, { "remove_case" call GVAR(fnc_doHotkeyAction); true }
] call _addKey;