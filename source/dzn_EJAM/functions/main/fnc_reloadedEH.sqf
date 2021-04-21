/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_reloadedEH

Description:
	--

Parameters:
	_reloadedEH - Eventhandler data of "Reloaded" EH <STRING>

Returns:
	nothing

Examples:
    (begin example)
		_reloadedEH call dzn_EJAM_fnc_reloadedEH;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

// params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

// Set proper Magazine state
[nil, nil, nil, if ([] call FUNC(isMagAttached)) then { "mag_attached" } else { "mag_detached" }] call FUNC(setWeaponState);

// Pull bolt if reload is not from Inspect menu
if (GVAR(PullBoltOnReload) && isNil SVAR(MagLoading)) then {
	[] call FUNC(pullBolt);
};
