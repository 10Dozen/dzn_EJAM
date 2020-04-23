/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_isInVehicleCrew

Description:
	Check whether primary weapon is jammed and (a) cause set, (b) cause not set.

Parameters:
	nothing

Returns:
	_isInVehicleCrew - (boolean) true if player in driver/commander/gunner or turret slot, false if not in vehicle or in cargo

Examples:
    (begin example)
		_isInVehicleCrew = [] call dzn_EJAM_fnc_isInVehicleCrew;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

// Exit with FALSE if player not in vehicle
if (vehicle player == player) exitWith { false };

// Exit with FALSE if player in vehicle's cargo seat
if ((fullCrew vehicle player) findIf {player isEqualTo _x # 0 && {_x # 1 == "cargo" || _x # 1 == "turret"} } > -1) exitWith { false };

// Return TRUE if in vehicle crew
true
