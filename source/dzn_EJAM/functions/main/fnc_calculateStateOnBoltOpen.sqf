/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_calculateStateOnBoltOpen

Description:
	Calculates weapon state after opening the bolt.

Parameters:
	nothing

Returns:
	_boltState - new bolt state (string)
	_chamberState - new chamber state (string)
	_roundWasted - flags that round was removed from the weapon

Examples:
    (begin example)
		[] call dzn_EJAM_fnc_calculateStateOnBoltOpen;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */


#include "..\script_macro.hpp"

(call FUNC(getWeaponState)) params ["_bolt","_chamber","_case","_mag"];

if (CHECK_BOLT_OPENED(_bolt)) exitWith {
	// Something gone wrong and bolt already opened...
	[nil, nil]
};

// Case D2 & D5: Extract round if bolt closed & round chambered (e.g. dud)
if (CHECK_BOLT_CLOSED(_bolt) && CHECK_CHAMBER_READY(_chamber)) exitWith {
	[STATE_BOLT_OPENED, STATE_CHAMBER_EMPTY, true]
};

[STATE_BOLT_OPENED, _chamber, false]
