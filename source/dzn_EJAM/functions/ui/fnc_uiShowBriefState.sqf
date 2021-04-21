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
			, ""
			, ""
			,["_mag", GVAR(Defaults) # 3]
		];

		hint parseText format [
			"<t shadow='2' size='1.25'>%1</t><br /><t shadow='2' size='1.25'>%2</t><br /><img image='%3' size='5'/>"
			, [_bolt, "state"] call FUNC(getEnumText)
			, [_mag, "state"] call FUNC(getEnumText)
			, getText (configFile >> "CfgWeapons" >> primaryWeapon player >> "picture")
		];
	};
};
