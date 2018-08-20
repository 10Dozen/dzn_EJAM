/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_getEnumText

Description:
	Resolve enum value to localized text
	
Parameters:
	_enumValue - Value of enum <STRING>
	_enumType - Type of the enum to search: "state", "action" or "process" <STRING>

Returns:
	_text - Localized text value <STRING>

Examples:
    (begin example)
		_boltStateText = ["bolt_not_closed", "state"] call dzn_EJAM_fnc_getEnumText;
		_pullProcess = ["pull_bolt", "process"] call dzn_EJAM_fnc_getEnumText;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

params ["_text", "_source"];

_text = toLower(_text);
_source = toLower(_source);

private _result = "";
switch (_source) do {
	case "state": {
		_result = (GVAR(States) select { _x select 0 == _text }) select 0 select 1;
	};
	case "action": {
		_result = (GVAR(FixActions) select { _x select 0 == _text }) select 0 select 1;
	};
	case "process": {
		_result = (GVAR(FixActions) select { _x select 0 == _text }) select 0 select 2;
	};
};

(_result)