/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_checkJammed

Description:
	Check whether primary weapon is jammed.
	TRUE - For INSPECT action
		t && (t || !t) == t
			ACE 	- yes
			Cause 	- yes
		t && (f || !t) == f
			ACE 	- yes
			Cause 	- no	
		f && (t || !t) == f
			ACE 	- no
			Cause 	- yes	
		f && (f || !t) == f
			ACE 	- no
			Cause 	- no

	FALSE - For SETTING CAUSE
		t && (t || !f) == t
			ACE 	- yes
			Cause 	- yes
		t && (f || !f) == t
			ACE 	- yes
			Cause 	- no	
		f && (t || !f) == f
			ACE 	- no
			Cause 	- yes	
		f && (f || !f) == f
			ACE 	- no
			Cause 	- no

Parameters:
	_this - Need to check both ACE and EJAM jamming is set <BOOL>

Returns:
	_isJammed - Is weapon jammed <BOOL>

Examples:
    (begin example)
		_isJammed = true call dzn_EJAM_fnc_checkJammed;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

private _aceJammed = (primaryWeapon player) in (player getVariable ["ace_overheating_jammedWeapons", []]);
private _causeSet = player getVariable [SVAR(CauseSet), false];

private _result = (_aceJammed) && (_causeSet || !_this);

(_result)