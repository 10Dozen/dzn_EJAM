/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_setJamCause

Description:
	Selects and applies Jam cause

Parameters:
	nothing

Returns:
	nothing

Examples:
    (begin example)
		call dzn_EJAM_fnc_setJamCause
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"



private _weights = GVAR(Causes) apply {	call compile FORMAT_VAR((_x select 0) + "_ChanceSettings") };

//call  FORMAT_VAR( format["%1_ChanceSettings", _x select 0] )
private _cause = GVAR(Causes) selectRandomWeighted _weights;

_cause params ["_causeID","_weaponState"];

_weaponState call GVAR(fnc_setWeaponState);
player setVariable [SVAR(Cause), _causeID];
player setVariable [SVAR(CauseSet), true];