/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_calculateStateOnBoltPull

Description:
	Calculates weapon state after pulling the bolt.

Parameters:
	nothing

Returns:
	_boltState - new bolt state (string)
	_chamberState - new chamber state (string)
	_roundWasted - was round lost after pulling the bold (bool)

Examples:
    (begin example)
		[] call dzn_EJAM_fnc_calculateStateOnBoltPull;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\script_macro.hpp"

(call FUNC(getWeaponState)) params ["_bolt","_chamber","_case","_mag"];

private _hasMagWithAmmo = _mag isEqualTo STATE_MAG_ATTACHED && player ammo (currentWeapon player) > 0;
private _newState = [];

if (_case == STATE_CASE_NOT_EJECTED) exitWith {
	// Initial state: Bolt is not closed
	if (_hasMagWithAmmo) exitWith {
		// New round picked, but failed to chamber
		[STATE_BOLT_NOT_CLOSED, STATE_CHAMBER_STUCK, true]
	};

	// No change
	[STATE_BOLT_NOT_CLOSED, nil, false]
};

if (_chamber == STATE_CHAMBER_EMPTY) exitWith {
	// Initial state: Bolt is closed
	if (_hasMagWithAmmo) exitWith {
		// Loads new shootable round
		[STATE_BOLT_CLOSED, STATE_CHAMBER_READY, false]
	};

	// No change
	[STATE_BOLT_CLOSED, nil, false]
};

if (_chamber == STATE_CHAMBER_READY) exitWith {
	// Initial state: Bolt is closed
	if (_hasMagWithAmmo) exitWith {
		if (_bolt == STATE_BOLT_CLOSED) exitWith {
			// Extract loaded round, load new one
			[STATE_BOLT_CLOSED, STATE_CHAMBER_READY, true]
		};

		// Shouldn't be reachable (open bolt + chambered live round)
		// but if happened - double feed occured
		[STATE_BOLT_NOT_CLOSED, STATE_CHAMBER_STUCK, true]
	};

	// Extract normal round
	[STATE_BOLT_CLOSED, STATE_CHAMBER_EMPTY, true]
};

if (_chamber == STATE_CHAMBER_STUCK) exitWith {
	// Initial state: Bolt is not closed
	if (_hasMagWithAmmo) exitWith {
		// Sort of Double feed, but no round lost to prevent emptying mag =)
		[STATE_BOLT_NOT_CLOSED, STATE_CHAMBER_STUCK, false]
	};

	// No changes
	[STATE_BOLT_NOT_CLOSED, nil, false]
};

if (_chamber == STATE_CHAMBER_NOT_EXTRACTABLE) exitWith {
	// Initial state: Bolt is not closed
	if (_hasMagWithAmmo) exitWith {
		// Sort of double feed
		[STATE_BOLT_NOT_CLOSED, STATE_CHAMBER_STUCK, true]
	};

	// No changes
	[STATE_BOLT_NOT_CLOSED, nil, false]
};

// Default - no change
[nil, nil, false]
