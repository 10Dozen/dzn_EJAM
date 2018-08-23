/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_uiShowUnjamMenu

Description:
	Draw Unjam UI menu.
	
Parameters:
	nothing

Returns:
	nothing

Examples:
    (begin example)
		[] spawn dzn_EJAM_fnc_uiShowUnjamMenu;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

closeDialog 2;
hintSilent "";
sleep 0.001;

// **
// Get weapon state 
[
	nil, nil, nil
	, if (call GVAR(fnc_isMagAttached)) then { "mag_attached" } else { "mag_detached" }
] call GVAR(fnc_setWeaponState);

(call GVAR(fnc_getWeaponState)) params ["_bolt","_chamber","_case","_mag"];

// **
// Prepare data
private _parseAndFormatLeft = {
	parseText format ["<t font=""PuristaLight"" align=""left"">%1</t>", _this]
};
private _parseAndFormatCenter = {
	parseText format ["<t font=""PuristaLight"" align=""center"">%1</t>", _this]
};

private _titleText = (LOCALIZE_FORMAT_STR("Menu_Title")) call _parseAndFormatLeft;
private _closeBtnText = LOCALIZE_FORMAT_STR("Menu_Close");

private _gunText = (getText (configFile >> "CfgWeapons" >> primaryWeapon player >> "displayName")) call _parseAndFormatCenter;
private _img = parseText format [
	"<img align=""center"" image=""%1"" size=""14"" />"
	, getText (configFile >> "CfgWeapons" >> primaryWeapon player >> "picture")
];
private _boltText = [_bolt, "state"] call GVAR(fnc_getEnumText) call _parseAndFormatCenter;
private _chamberText = ([_chamber, "state"] call GVAR(fnc_getEnumText)) call _parseAndFormatCenter;
private _caseText = ([_case, "state"] call GVAR(fnc_getEnumText)) call _parseAndFormatCenter;
private _magText = ([_mag, "state"] call GVAR(fnc_getEnumText)) call _parseAndFormatCenter;

private _pullBoltActionText = ["pull_bolt", "action"] call GVAR(fnc_getEnumText) call _parseAndFormatLeft;
private _clearChamberActionText = ["clear_chamber", "action"] call GVAR(fnc_getEnumText) call _parseAndFormatLeft;
private _openBoltActionText = ["open_bolt", "action"] call GVAR(fnc_getEnumText) call _parseAndFormatLeft;
private _clearCaseActionText = ["remove_case", "action"] call GVAR(fnc_getEnumText) call _parseAndFormatLeft;
private _magActionText = [
	if (_mag == "mag_attached") then { "detach_mag" } else { "attach_mag" }
	, "action"
] call GVAR(fnc_getEnumText) call _parseAndFormatLeft;


// **
// Show menu
createDialog "dzn_EJAM_Menu_Group";

private _display = (findDisplay 134802);
#define GET_CTRL(X)	(_display displayCtrl  X)

// --- Title and Image
GET_CTRL(6002) ctrlSetStructuredText _titleText;
GET_CTRL(6003) ctrlSetText _closeBtnText;

GET_CTRL(6010) ctrlSetStructuredText _img;
GET_CTRL(6011) ctrlSetStructuredText _gunText;

// --- State labels
GET_CTRL(6012) ctrlSetStructuredText _boltText;
GET_CTRL(6013) ctrlSetStructuredText _chamberText;
GET_CTRL(6014) ctrlSetStructuredText _magText;
GET_CTRL(6015) ctrlSetStructuredText _caseText;

// --- Buttons
GET_CTRL(6020) ctrlSetStructuredText _pullBoltActionText;
GET_CTRL(6021) ctrlSetStructuredText _clearChamberActionText;
GET_CTRL(6022) ctrlSetStructuredText _magActionText;
GET_CTRL(6023) ctrlSetStructuredText _openBoltActionText;
GET_CTRL(6024) ctrlSetStructuredText _clearCaseActionText;

// --- Set button states & onclick
private _generateActionCode = { 
	compile format ["closeDialog 2; ""%1"" spawn %2", _this, SVAR(fnc_doAction)]
};
private _isActive = false;

// --- --- Close 
GET_CTRL(6003) ctrlAddEventHandler ["ButtonClick", { closeDialog 2; }];

// --- --- Bolt pull 
GET_CTRL(6020) ctrlAddEventHandler ["ButtonClick", "pull_bolt" call _generateActionCode];
GET_CTRL(6020) ctrlSetFont "PuristaLight";

// --- --- Bolt open
if (_bolt != "bolt_opened") then {
	_isActive = true;
	GET_CTRL(6023) ctrlAddEventHandler ["ButtonClick", "open_bolt" call _generateActionCode];
} else {
	_isActive = false;
};

GET_CTRL(6023) ctrlEnable _isActive;

// --- --- Chamber 
if (_bolt == "bolt_opened" && _mag == "mag_detached" && _chamber == "chamber_stucked" && _case == "case_ejected") then {
	_isActive = true;
	GET_CTRL(6021) ctrlAddEventHandler ["ButtonClick", "clear_chamber" call _generateActionCode];
} else {
	_isActive = false;
};

GET_CTRL(6021) ctrlEnable _isActive;

// --- --- Case
if (_bolt == "bolt_opened" && _case == "case_not_ejected") then {
	_isActive = true;
	GET_CTRL(6024) ctrlAddEventHandler ["ButtonClick", "remove_case" call _generateActionCode];
} else {
	_isActive = false;
};

GET_CTRL(6024) ctrlEnable _isActive;

// --- --- Magazine detach
if (_mag == "mag_attached") then {
	GET_CTRL(6022) ctrlAddEventHandler ["ButtonClick", "detach_mag" call _generateActionCode];
} else {
	GET_CTRL(6022) ctrlAddEventHandler ["ButtonClick", "attach_mag" call _generateActionCode];
};