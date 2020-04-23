/* ----------------------------------------------------------------------------
Function: dzn_EJAM_fnc_uiShowProgressBar

Description:
	Draw progress bar and execute given code when on finished

Parameters:
	_drawTime - Time to draw progress bar <NUMBER>
	_title - Title text on progress bar <STRING>
	_code - Code to execute on finish <CODE>
	_args - Arguments to use in code <ANY>

Returns:
	nothing

Examples:
    (begin example)
		[10, "In progress", { hint (_args) }, "Hint message on finish"] spawn dzn_EJAM_fnc_uiShowProgressBar;
    (end)

Author:
	10Dozen
---------------------------------------------------------------------------- */

#include "..\macro.hpp"

params ["_drawTime","_title","_code",["_args", []]];

// Prepare data 
private _strCode = ((str(_code) splitString "") select [1, count str(_code) - 2]) joinString "";
_code = compile format ["private _args = _this; %1", _strCode];

// Draw 
private _dialog = createDialog "dzn_EJAM_ProgressBar_Group";
private _display = (findDisplay 134804);
#define GET_CTRL(X)	(_display displayCtrl X)

GET_CTRL(6503) ctrlSetStructuredText (parseText format ["<t font=""PuristaMedium"" shadow=""2"" align=""center"">%1</t>", _title]);

// Animate
private _posX = ctrlPosition GET_CTRL(6502) select 0;
private _posY = ctrlPosition GET_CTRL(6502) select 1;
private _wMax = ctrlPosition GET_CTRL(6503) select 2;
private _h = ctrlPosition GET_CTRL(6502) select 3;

[
	{
		(_this select 0) params ["_drawTime","_startTime","_wMax","_posX","_posY","_h","_onFinish","_onFinishArgs"];
		private _timeSpent = CBA_missionTime - _startTime;

		if (_timeSpent >= _drawTime) then {
			closeDialog 2;
			(_this select 1) call CBA_fnc_removePerFrameHandler;
			_onFinishArgs spawn _onFinish; 
		} else {

			if (isNull (findDisplay 134804) || !alive player) exitWith {
				closeDialog 2;
				(_this select 1) call CBA_fnc_removePerFrameHandler;
				hint "Canceled";
			};

			((findDisplay 134804) displayCtrl 6502) ctrlSetPosition [_posX, _posY, (_wMax * _timeSpent / _drawTime), _h];
			((findDisplay 134804) displayCtrl 6502) ctrlCommit 0;
		};
	}
	, 0
	, [_drawTime, CBA_missionTime, _wMax, _posX, _posY, _h, _code, _args]
] call CBA_fnc_addPerFrameHandler;
