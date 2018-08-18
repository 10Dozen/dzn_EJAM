/*
	author: 10Dozen
	description: Draws Weapon Malfunction menu and handle button clicks
	returns: nothing
*/

closeDialog 2;
sleep 0.001;

if !(player getVariable ["dzn_EJAM_CauseSet", false]) exitWith {};
if (currentWeapon player != primaryWeapon player) exitWith {};

if (dzn_EJAM_handleMag) then {
	["","","", if (call dzn_EJAM_fnc_isMagAttached) then { "mag_attached" } else { "mag_detached" }] call dzn_EJAM_fnc_setWeaponState;
};
(player getVariable "dzn_EJAM_WeaponState") params ["_bolt","_chamber","_case","_mag"];

private _boltText = (dzn_EJAM_States select { _x select 0 == _bolt }) select 0 select 1;
private _chamberText = (dzn_EJAM_States select { _x select 0 == _chamber }) select 0 select 1;
private _caseText = (dzn_EJAM_States select { _x select 0 == _case }) select 0 select 1;
private _magText = (dzn_EJAM_States select { _x select 0 == _mag }) select 0 select 1;

private _menuItems = [
	[0,"HEADER", localize "STR_EJAM_Menu_Title"]
	, [0, "LABEL", ""]
	, [0, "LABEL", ""]
	, [0, "BUTTON", localize "STR_EJAM_Menu_Close", {closeDialog 2}]
	, [1, "LABEL", format[
		"<t align='center'>%1</t><br /><img image='%2' size='15' />"
		, getText (configFile >> "CfgWeapons" >> primaryWeapon player >> "displayName")
		, getText (configFile >> "CfgWeapons" >> primaryWeapon player >> "picture")
	],[[1,1,1,1], "PuristaLight", 0.5],[1,0,0,0.7]]

	, [2, "LABEL", format ["<t align='center'>%1</t>", _boltText]]
	, [2, "LABEL", format ["<t align='center'>%1</t>", _chamberText]]
	, [2, "LABEL", format ["<t align='center'>%1</t>", _magText]]

	, [3, "LABEL", ""]
	, [3, "LABEL", format ["<t align='center'>%1</t>", _caseText]]
	, [3, "LABEL", ""]
];

[player, "Gear"] call ace_common_fnc_doGesture;

/*
	Action buttons:
	| 0 | 1 | 2 |
	| 3 | 4 | 5 |
*/
private _actionItems = [
	[4,"LABEL",""], [4,"LABEL",""], [4,"LABEL",""],
	[5,"LABEL",""], [5,"LABEL",""], [5,"LABEL",""]
];

{
	// Creates a bunch of variables containing action data: _pull_bolt = ["Pull Bolt", { 'pull_bolt' call dzn_EJAM_fnc_doAction; }]
	call compile format ["dzn_EJAM_%1 = ['%2', { closeDialog 2; '%1' spawn dzn_EJAM_fnc_doAction; }]", _x select 0, _x select 1];
} forEach dzn_EJAM_FixActions;

// BOLT Actions
_actionItems set [0, [4, "BUTTON", dzn_EJAM_pull_bolt select 0, dzn_EJAM_pull_bolt select 1]];
if (_bolt != "bolt_opened") then {
	_actionItems set [3, [5, "BUTTON", dzn_EJAM_open_bolt select 0, dzn_EJAM_open_bolt select 1]];
} else {
	_actionItems set [3, [5, "LABEL", format ["<t color='#777777'>%1</t>", dzn_EJAM_open_bolt select 0]]];
};

// CHAMBER and CASE actions
if (_bolt == "bolt_opened" && _mag == "mag_detached" && _chamber == "chamber_stucked" && _case == "case_ejected") then {
	_actionItems set [1, [4, "BUTTON", dzn_EJAM_clear_chamber select 0, dzn_EJAM_clear_chamber select 1]];
} else {
	_actionItems set [1, [4, "LABEL", format ["<t color='#777777'>%1</t>", dzn_EJAM_clear_chamber select 0]]];
};
if (_bolt == "bolt_opened" && _case == "case_not_ejected") then {
	_actionItems set [4, [5, "BUTTON", dzn_EJAM_remove_case select 0, dzn_EJAM_remove_case select 1]];
} else {
	_actionItems set [4, [5, "LABEL", format ["<t color='#777777'>%1</t>", dzn_EJAM_remove_case select 0]]];
};

// MAGAZINE actions
if (_mag == "mag_attached") then {
	_actionItems set [2, [4, "BUTTON", dzn_EJAM_detach_mag select 0, dzn_EJAM_detach_mag select 1]];
} else {
	_actionItems set [2, [4, "LABEL", format ["<t color='#777777'>%1</t>", dzn_EJAM_detach_mag select 0]]];
};
if (_mag == "mag_detached") then {
	_actionItems set [5, [5, "BUTTON", dzn_EJAM_attach_mag select 0, dzn_EJAM_attach_mag select 1]];
} else {
	_actionItems set [5, [5, "LABEL", format ["<t color='#777777'>%1</t>", dzn_EJAM_attach_mag select 0]]];
};

(_menuItems + _actionItems) call dzn_EJAM_fnc_ShowAdvDialog;