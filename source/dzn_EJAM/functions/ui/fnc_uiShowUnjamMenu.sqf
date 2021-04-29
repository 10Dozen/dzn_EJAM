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

#include "..\script_macro.hpp"
#define __EXEC_NEXT_FRAME_START__ [{
#define __EXEC_NEXT_FRAME_END__   }] call CBA_fnc_execNextFrame;


closeDialog 2;
hintSilent "";


__EXEC_NEXT_FRAME_START__
// uiSleep 0.001;

// **
// Get weapon state
[
	nil, nil, nil
	, [STATE_MAG_DETACHED, STATE_MAG_ATTACHED] select (call FUNC(isMagAttached))
] call FUNC(setWeaponState);

(call FUNC(getWeaponState)) params ["_bolt","_chamber","_case","_mag"];

// **
// Prepare data
private _parseAndFormatLeft = {
	parseText format ["<t font=""PuristaLight"" align=""left"">%1</t>", _this]
};
private _parseAndFormatCenter = {
	parseText format ["<t font=""PuristaLight"" align=""center"">%1</t>", _this]
};

private _titleText = LSTR(Menu_Title) call _parseAndFormatLeft;
private _closeBtnText = LSTR(Menu_Close);

private _gunText = (getText (configFile >> "CfgWeapons" >> primaryWeapon player >> "displayName")) call _parseAndFormatCenter;
private _img = parseText format [
	"<img align=""center"" image=""%1"" size=""14"" />"
	, getText (configFile >> "CfgWeapons" >> primaryWeapon player >> "picture")
];
private _boltText = [_bolt, "state"] call FUNC(getEnumText) call _parseAndFormatCenter;
private _chamberText = ([_chamber, "state"] call FUNC(getEnumText)) call _parseAndFormatCenter;
private _caseText = ([_case, "state"] call FUNC(getEnumText)) call _parseAndFormatCenter;
private _magText = ([_mag, "state"] call FUNC(getEnumText)) call _parseAndFormatCenter;

private _pullBoltActionText = [ACTION_PULL_BOLT, "action"] call FUNC(getEnumText) call _parseAndFormatLeft;
private _clearChamberActionText = [ACTION_CLEAR_CHAMBER, "action"] call FUNC(getEnumText) call _parseAndFormatLeft;
private _openBoltActionText = [ACTION_OPEN_BOLT, "action"] call FUNC(getEnumText) call _parseAndFormatLeft;
private _clearCaseActionText = [ACTION_REMOVE_CASE, "action"] call FUNC(getEnumText) call _parseAndFormatLeft;
private _magActionText = [
	[ACTION_ATTACH_MAG, ACTION_DETACH_MAG] select (_mag == STATE_MAG_ATTACHED)
	, "action"
] call FUNC(getEnumText) call _parseAndFormatLeft;


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
	compile format ["closeDialog 2; ""%1"" spawn %2", _this, QFUNC(doAction)]
};
private _isActive = false;

// --- --- Close
GET_CTRL(6003) ctrlAddEventHandler ["ButtonClick", { closeDialog 2; }];

// --- --- Bolt pull
GET_CTRL(6020) ctrlAddEventHandler ["ButtonClick", ACTION_PULL_BOLT call _generateActionCode];
GET_CTRL(6020) ctrlSetFont "PuristaLight";

// --- --- Bolt open
if (_bolt != STATE_BOLT_OPENED) then {
	_isActive = true;
	GET_CTRL(6023) ctrlAddEventHandler ["ButtonClick", ACTION_OPEN_BOLT call _generateActionCode];
} else {
	_isActive = false;
};

GET_CTRL(6023) ctrlEnable _isActive;

// --- --- Chamber
if (
	_bolt == STATE_BOLT_OPENED
	&& _chamber in [STATE_CHAMBER_STUCK, STATE_CHAMBER_NOT_EXTRACTABLE]
	&& _case == STATE_CASE_EJECTED
	&& _mag == STATE_MAG_DETACHED
) then {
	_isActive = true;
	GET_CTRL(6021) ctrlAddEventHandler ["ButtonClick", ACTION_CLEAR_CHAMBER call _generateActionCode];
} else {
	_isActive = false;
};

GET_CTRL(6021) ctrlEnable _isActive;

// --- --- Case
if (_bolt == STATE_BOLT_OPENED && _case == STATE_CASE_NOT_EJECTED) then {
	_isActive = true;
	GET_CTRL(6024) ctrlAddEventHandler ["ButtonClick", ACTION_REMOVE_CASE call _generateActionCode];
} else {
	_isActive = false;
};

GET_CTRL(6024) ctrlEnable _isActive;

// --- --- Magazine detach
if (_mag == STATE_MAG_ATTACHED) then {
	GET_CTRL(6022) ctrlAddEventHandler ["ButtonClick", ACTION_DETACH_MAG call _generateActionCode];
} else {
	GET_CTRL(6022) ctrlAddEventHandler ["ButtonClick", ACTION_ATTACH_MAG call _generateActionCode];
};

__EXEC_NEXT_FRAME_END__
