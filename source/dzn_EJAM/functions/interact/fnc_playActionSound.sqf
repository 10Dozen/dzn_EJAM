/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_playActionSound

Description:
	Plays appropriate action sound in 3D

Parameters:
	_actionName - action to perform <STRING>

Returns:
	nothing

Examples:
    (begin example)
		ACTION_PULL_BOLT call dzn_EJAM_fnc_playActionSound;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

private _actionID = _this;

player say3d [_actionID, 1000, 1];