/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_uiShowConfig

Description:
	Draw EJAM Weapon Configurator UI menu.

Parameters:
	nothing

Returns:
	nothing

Examples:
    (begin example)
		[] spawn dzn_EJAM_fnc_uiShowConfig;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

closeDialog 2;
sleep 0.001;

// Prerparation
GVAR(SearchRun) = false;

// Define UI functions
fnc_EJAM_gfc = {
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

fnc_EJAM_filterWeapons = {
	private _searchString = _this;
	private _searchList = if (count (_searchString splitString "|") > 0) then {
		_searchString splitString " " joinString "" splitString "|";
	} else {
		[_searchString]
	};

	private _resultList = [];
	private _allGunClasses = configFile >> "CfgWeapons";
	for "_i" from 0 to ((count _allGunClasses) - 1) do {

		private _class = configName (_allGunClasses select _i);

		if (_class != "access") then {
			private _name = [_class,"displayName","t"] call fnc_EJAM_gfc;

			// Filter only classes with picture, model and scope=2
			if (
				[_class,"type","n"] call fnc_EJAM_gfc == 1
				&& {
					[_class,"picture","t"] call fnc_EJAM_gfc != ""
					&& [_class,"model","t"] call fnc_EJAM_gfc != ""
					&& [_class,"scope","n"] call fnc_EJAM_gfc == 2
				}
			) then {
				private _found = false;
				private _baseClass = [_class] call BIS_fnc_baseWeapon;

				if !(_baseClass in _resultList) then {
					private _name = [_baseClass,"displayName","t"] call fnc_EJAM_gfc;

					{
						// Filter by string and source
						if ( [_x, _name, false] call BIS_fnc_inString ) then {
							_found = true;
						};
					} forEach _searchList;

					if (_found) then {
						_resultList pushBackUnique _class;
					};
				};
			};
		};
	};

	_resultList
};

fnc_EJAM_collectSliderData = {
	private _gun = call fnc_EJAM_uiGetSelected;
	private _display = (findDisplay 134802);
	private _data = [_gun];

	//  Jam chance w. 0.00 accuracy & other sliders w. 0.0 accuracy
	{
		private _accuracy = if (_forEachIndex == 0) then { 100 } else { 10 };
		_data pushBack (floor (sliderPosition (_display displayCtrl _x) * _accuracy) / _accuracy);
	} forEach [6040, 6041,6042,6043,6044,6045];

	(_data)
};



fnc_EJAM_uiOnFilterKeyDown = {
	params ["_control", "_key", "_shift", "_ctrl", "_alt"];

	// Exit if key is not ENTER or NumEnter
	if (!(_key in [28,156]) || GVAR(SearchRun)) exitWith {};

	private _serachString = ctrlText _control;
	GVAR(SearchRun) = true;

	private _list = _serachString call fnc_EJAM_filterWeapons;

	// Update listbox
	_list call fnc_EJAM_uiUpatdeListbox;

	[] spawn {
		uiSleep 0.5;
		GVAR(SearchRun) = false;
	};
};

fnc_EJAM_uiUpatdeListbox = {
	private _list = _this;
	private _ctrlList = ((findDisplay 134802) displayCtrl 6011);

	lbClear _ctrlList;
	//["", false] call fnc_EJAM_uiUpdateSliders;

	if !(_list isEqualTo []) then {
		{
			_ctrlList lbAdd ([_x,"displayName","t"] call fnc_EJAM_gfc);
			_ctrlList lbSetPicture [_forEachIndex, [_x,"picture","t"] call fnc_EJAM_gfc];
			_ctrlList lbSetData [_forEachIndex, _x];
		} forEach _list;

		lbSort _ctrlList;
		_ctrlList lbSetCurSel 0;
	};
};

fnc_EJAM_uiGetSelected = {
	private _display = (findDisplay 134802);
	private _lbCtrl = (_display displayCtrl 6011);
	private _gun = _lbCtrl lbData (lbCurSel _lbCtrl);

	(_gun)
};

fnc_EJAM_uiOnGunSelected = {
	params ["_control", "_selectedIndex"];

	private _class = call fnc_EJAM_uiGetSelected;

	_class call fnc_EJAM_uiUpdateWeaponData;
	[_class, true] call fnc_EJAM_uiUpdateSliders;
	true call fnc_EJAM_uiUpdateButtons;
};

fnc_EJAM_uiUpdateWeaponData = {
	private _class = _this;
	private _display = (findDisplay 134802);

	private _gunName = parseText format [
		"%1 <t align=""right"" size=""0.75"" color=""#ff0000"">%2</t>"
		, [_class,"displayName","t"] call fnc_EJAM_gfc
		, [_class,"author","t"] call fnc_EJAM_gfc
	];
	private _gunImage = parseText format [
		"<img align=""center""  size=""5"" image=""%1"" />"
		, [_class,"picture","t"] call fnc_EJAM_gfc
	];

	((findDisplay 134802) displayCtrl 6021) ctrlSetStructuredText _gunName;
	((findDisplay 134802) displayCtrl 6020) ctrlSetStructuredText _gunImage;
};

fnc_EJAM_uiUpdateSliders = {
	params ["_class","_enable", ["_sliderData", []]];

	private _display = (findDisplay 134802);
	private _data = [
		[6040, 0]
		,[6041, 0]
		,[6042, 0]
		,[6043, 0]
		,[6044, 0]
		,[6045, 0]
	];

	if (_enable && _class != "") then {
		private _jamChance = 0;
		private _malfunctionWeights = 0;

		if (_sliderData isEqualTo []) then {
			_jamChance = [_class, "jam", true] call FUNC(getMappingData);
			_malfunctionWeights = [_class, "malfunction", true] call FUNC(getMappingData);
		} else {
			_jamChance = _sliderData # 0;
			_malfunctionWeights = _sliderData select [1,5];
		};

		(_data # 0) set [1, _jamChance];
		(_data # 1) set [1, _malfunctionWeights # 0];
		(_data # 2) set [1, _malfunctionWeights # 1];
		(_data # 3) set [1, _malfunctionWeights # 2];
		(_data # 4) set [1, _malfunctionWeights # 3];
		(_data # 5) set [1, _malfunctionWeights # 4];

		{
			_x params ["_ctrlId","_val"];

			((findDisplay 134802) displayCtrl _ctrlId) ctrlEnable true;
			((findDisplay 134802) displayCtrl _ctrlId) sliderSetPosition _val;
			[nil, _val, _ctrlId - 10, if (_forEachIndex == 0) then { 100 } else { 10 }] call fnc_EJAM_uiOnSliderChanged;
		} forEach _data;
	} else {
		{
			((findDisplay 134802) displayCtrl (_x select 0)) sliderSetPosition 0;
			((findDisplay 134802) displayCtrl (_x select 0)) ctrlEnable false;
			[nil, 0, (_x select 0) - 10] call fnc_EJAM_uiOnSliderChanged;
		} forEach _data;
	}
};

fnc_EJAM_uiOnSliderChanged = {
	params ["_control", "_newValue", "_labelIDC", ["_accuracy", 10]];

	private _text = (
		((ctrlText ((findDisplay 134802) displayCtrl _labelIDC)) splitString "%" select 0)
	) splitString " " joinString " ";

	((findDisplay 134802) displayCtrl _labelIDC) ctrlSetStructuredText parseText format [
		"%1 <t align=""right"">%3 %2</t>"
		, _text
		, (floor (_newValue * _accuracy)) / _accuracy
		, "%"
	];
};

fnc_EJAM_uiUpdateButtons = {
	private _display = (findDisplay 134802);
	private _data = [6050, 6051, 6052, 6053];

	{
		((findDisplay 134802) displayCtrl _x) ctrlEnable _this;
	} forEach _data;
};

fnc_EJAM_uiOnSaveClick = {
	private _newMappingData = call fnc_EJAM_collectSliderData;
	private _isReset = (_newMappingData select [1,6]) isEqualTo [0,0,0,0,0,0];

	private _mapping = GVAR(Mapping) select { _newMappingData select 0 == _x select 0 };
	if (_mapping isEqualTo []) then {
		if !(_isReset) then {
			GVAR(Mapping) pushBack _newMappingData;
		};
	} else {
		if !(_isReset) then {
			private _map = _mapping select 0;
			for "_i" from 0 to (count _map) - 1 do {
				_map set [_i, _newMappingData select _i];
			};
		} else {
			GVAR(Mapping) = GVAR(Mapping) - (_mapping);
		};
	};

	[
		SVAR(MappingSettings)
		, str(GVAR(Mapping)) select [1, count str(GVAR(Mapping)) -2]
		, 0
		, "server"
		, true
	] call CBA_settings_fnc_set;

	private _draw = [
		parseText format ["<t size='1.25' color='#FFD000'>%1</t>", [_newMappingData select 0,"displayName","t"] call fnc_EJAM_gfc]
		, lineBreak
		, parseText format ["<t color='#6666ff'>%1</t>", LOCALIZE_FORMAT_STR("Config_SavedHint")]
		, lineBreak
	];
	hint (composeText _draw);
};

fnc_EJAM_uiOnCopyClick = {
	private _data = call fnc_EJAM_collectSliderData;

	GVAR(ConfigClipboard) = _data;
	copyToClipboard str(_data);

	private _draw = [
		parseText format ["<t size='1.25' color='#FFD000'>%1</t>", [_data select 0,"displayName","t"] call fnc_EJAM_gfc]
		, lineBreak
		, parseText format ["<t color='#6666ff'>%1</t>", LOCALIZE_FORMAT_STR("Config_CopiedHint")]
		, lineBreak
	];
	hint (composeText _draw);
};

fnc_EJAM_uiOnApplyClick = {
	private _instantSave = if (isNil "_this") then { false } else { true };

	if (isNil SVAR(ConfigClipboard)) exitWith {
		hint parseText format [
			"<t color='#6666ff'>%1</t>"
			, LOCALIZE_FORMAT_STR("Config_NoDataHint")
		];
	};

	private _gun = call fnc_EJAM_uiGetSelected;
	private _data = GVAR(ConfigClipboard);

	[_gun, true, _data select [1,6]] call fnc_EJAM_uiUpdateSliders;

	private _draw = [
		parseText format ["<t size='1.25' color='#FFD000'>%1</t>", [_gun,"displayName","t"] call fnc_EJAM_gfc]
		, lineBreak
		, parseText format ["<t color='#6666ff'>APPLIED!</t>", LOCALIZE_FORMAT_STR("Config_ApplidHint")]
		, lineBreak
	];
	hint (composeText _draw);

	if (_instantSave) then {
		call fnc_EJAM_uiOnSaveClick;
	} else {
		[] spawn {
			sleep 0.5;
			call fnc_EJAM_uiOnSaveClick;
		};
	};
};

fnc_EJAM_uiOnLBDblClick = {
	params ["_control", "_selectedIndex"];
	true call fnc_EJAM_uiOnApplyClick;
};

fnc_EJAM_uiOnResetClick = {
	private _gun = call fnc_EJAM_uiGetSelected;
	[_gun, true, [0,0,0,0,0,0]] call fnc_EJAM_uiUpdateSliders;
	call fnc_EJAM_uiOnSaveClick;
};

// Draw
// --- Dialog
createDialog "dzn_EJAM_Config_Group";
private _display = (findDisplay 134802);
#define GET_CTRL(X)	(_display displayCtrl X)

// --- Title
GET_CTRL(6002) ctrlSetStructuredText parseText LOCALIZE_FORMAT_STR("Config_Title");
GET_CTRL(6003) ctrlSetStructuredText parseText LOCALIZE_FORMAT_STR("Config_CloseBtn");
GET_CTRL(6010) ctrlSetStructuredText parseText LOCALIZE_FORMAT_STR("Config_SectionLabel");
GET_CTRL(6010) ctrlSetStructuredText parseText LOCALIZE_FORMAT_STR("Config_SectionLabel");

// --- Filter
GET_CTRL(6012) ctrlSetText LOCALIZE_FORMAT_STR("Config_FilterLabel");
GET_CTRL(6012) ctrlSetTooltip LOCALIZE_FORMAT_STR("Config_FilterTooltip");
GET_CTRL(6012) ctrlSetEventHandler ["KeyDown", "_this call fnc_EJAM_uiOnFilterKeyDown;"];
GET_CTRL(6011) ctrlSetEventHandler ["LBSelChanged", "_this call fnc_EJAM_uiOnGunSelected"];
GET_CTRL(6011) ctrlSetEventHandler ["LBDblClick", "_this call fnc_EJAM_uiOnLBDblClick"];

// --- Weapon data
GET_CTRL(6021) ctrlSetStructuredText parseText format [
	"<t align=""center"">%1</t>"
	, LOCALIZE_FORMAT_STR("Config_PlaceholderLabel")
];

// --- Sliders
{
	GET_CTRL(_x) sliderSetRange [0,100];
	GET_CTRL(_x) sliderSetSpeed (if (_forEachIndex == 0) then { [0.01,10] } else { [0.1,25] });
	GET_CTRL(_x) ctrlEnable false;
	GET_CTRL(_x) ctrlSetEventHandler [
		"SliderPosChanged"
		, format ["_this pushBack %1; _this pushBack %2; _this call fnc_EJAM_uiOnSliderChanged", _x - 10, if (_forEachIndex == 0) then { 100 } else { 10 }]
	];
} forEach [6040, 6041, 6042, 6043, 6044, 6045];

// --- Buttons
false call fnc_EJAM_uiUpdateButtons;
GET_CTRL(6050) ctrlSetEventHandler ["ButtonClick", "_this call fnc_EJAM_uiOnSaveClick"];
GET_CTRL(6050) ctrlSetStructuredText parseText LOCALIZE_FORMAT_STR("Config_SaveBtn");

GET_CTRL(6051) ctrlSetEventHandler ["ButtonClick", "_this call fnc_EJAM_uiOnCopyClick"];
GET_CTRL(6051) ctrlSetStructuredText parseText LOCALIZE_FORMAT_STR("Config_CopyBtn");

GET_CTRL(6052) ctrlSetEventHandler ["ButtonClick", "_this call fnc_EJAM_uiOnApplyClick"];
GET_CTRL(6052) ctrlSetStructuredText parseText LOCALIZE_FORMAT_STR("Config_PasteBtn");
GET_CTRL(6052) ctrlSetTooltip LOCALIZE_FORMAT_STR("Config_PasteTooltip");

GET_CTRL(6053) ctrlSetEventHandler ["ButtonClick", "_this call fnc_EJAM_uiOnResetClick"];
GET_CTRL(6053) ctrlSetStructuredText parseText LOCALIZE_FORMAT_STR("Config_ResetBtn");
GET_CTRL(6053) ctrlSetTooltip LOCALIZE_FORMAT_STR("Config_ResetTooltip");
