/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_getEnumText

Description:
	Resolve enum value to localized text

Parameters:
	_enumValue - Value of enum <STRING>
	_enumType - Type of the enum to search: "state", "action", "process", "time" <STRING>

Returns:
	_text - Localized text value <STRING>

Examples:
    (begin example)
		_boltStateText = [STATE_BOLT_NOT_CLOSED, "state"] call dzn_EJAM_fnc_getEnumText;
		_pullProcess = [ACTION_PULL_BOLT, "process"] call dzn_EJAM_fnc_getEnumText;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

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
	case "time": {
		_result = (GVAR(FixActions) select { _x select 0 == _text }) select 0 select 3;
	};
};

(_result)
