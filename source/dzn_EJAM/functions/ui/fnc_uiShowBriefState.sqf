/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_uiShowBriefState

Description:
	Draw hint message of weapon state

Parameters:
	_messageType - Message type to display: "ok", "state" <STRING>

Returns:
	nothing

Examples:
    (begin example)
		"ok" call dzn_EJAM_fnc_uiShowBriefState;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

switch toLower(_this) do {
	case "ok": {
		hint parseText format [
			"<t shadow='2' size='1.25'>%1</t><br /><img image='%2' size='5'/>"
			, LOCALIZE_FORMAT_STR("Hint_WeaponOK")
			, getText (configFile >> "CfgWeapons" >> primaryWeapon player >> "picture")
		];
	};
	case "no_access": {
		hint parseText format [
			"<t shadow='2' size='1.25'>%1</t><br /><img image='%2' size='5'/>"
			, LOCALIZE_FORMAT_STR("Hint_NoAccess")
			, getText (configFile >> "CfgWeapons" >> primaryWeapon player >> "picture")
		];
	};
	case "state": {
		(call FUNC(getWeaponState)) params [
			["_bolt", GVAR(Defaults) # 0]
			, ["_chamber", GVAR(Defaults) # 1]
			, ["_case", GVAR(Defaults) # 2]
			,["_mag", GVAR(Defaults) # 3]
		];
		/*
		[STATE_BOLT_NOT_CLOSED,STATE_CHAMBER_STUCK,STATE_CASE_EJECTED,STATE_MAG_ATTACHED]
		*/

		private _boltText = [_bolt, "state"] call FUNC(getEnumText);
		private _chamberText = "";
		private _caseText = "";
		if (_bolt != STATE_BOLT_CLOSED) then {
			// Show info of chamber/case
			_chamberText = [_chamber, "state"] call FUNC(getEnumText);
			_caseText = [_case, "state"] call FUNC(getEnumText);
		};
		private _magText = [_mag, "state"] call FUNC(getEnumText);

		private _hintText = "";
		{
			if (_x != "") then {
				_hintText = format ["%1<t shadow='2' size='1.25'>%2</t><br />", _hintText, _x];
			};
		} forEach [_boltText, _chamberText, _caseText, _magText];

		hint parseText format [
			"%1<img image='%2' size='5'/>"
			, _hintText
			, getText (configFile >> "CfgWeapons" >> primaryWeapon player >> "picture")
		];
	};
};
