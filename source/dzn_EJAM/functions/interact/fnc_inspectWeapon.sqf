/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_inspectWeapon

Description:
	Open Unjam menu or draw hint if weapon is not jammed.

Parameters:
	nothing

Returns:
	nothing

Examples:
    (begin example)
		call dzn_EJAM_fnc_inspectWeapon;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

// --- Show OK hint if not jammed
if !("inspect" call FUNC(checkJammed)) exitWith {
	"OK" call FUNC(uiShowBriefState);
};

// --- Show Full Inspect menu if option selected in settings
if (GVAR(AllowFullInspectMenu)) exitWith {
	[] spawn FUNC(uiShowUnjamMenu);
};

// --- Show Quick Inspect menu otherwise
[ACTION_INSPECT, false] call FUNC(doAction);
