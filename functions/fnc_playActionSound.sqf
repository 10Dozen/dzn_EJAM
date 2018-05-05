/*
	author: 10Dozen
	description: Plays appropriate action sound in 3D
	input: STRING - action id (e.g. "pull_bolt")
	returns: nothing
*/

private _actionID = _this;

player say3d [_actionID, 1000, 1];