/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_isMagAttached

Description:
	Returns True if magazine attache to current weapon

Parameters:
	nothing

Returns:
	_isMagAttached - Is magazine attached to primary weapon <BOOL>

Examples:
    (begin example)
		_isMagAttached = [] call dzn_EJAM_fnc_isMagAttached;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

private _result = (weaponState player select 3) != "";

(_result)
