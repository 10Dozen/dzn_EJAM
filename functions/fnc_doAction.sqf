/*
	author: 10Dozen
	description: Process selected action from Weapon Malfunction menu
	input: STRING - action id (e.g. "pull_bolt")
	returns: nothing
*/

private _actionID = _this;
private _processText = (dzn_EJAM_FixActions select { _x select 0 == _actionID }) select 0 select 2;

#define	REMOVE_ROUND	if ((player getVariable "dzn_EJAM_RemovedMagazine" select 1) > 0) then { player setVariable ["dzn_EJAM_LooseRound", true]; }

switch (_actionID) do {
	case "pull_bolt": {
		[0.5, [], {
			call dzn_EJAM_fnc_pullBolt;
			[] spawn dzn_EJAM_fnc_ShowUnjamMenu;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "open_bolt": {
		[0.5, [], {
			["bolt_opened",nil,nil,nil] call dzn_EJAM_fnc_setWeaponState;
			[] spawn dzn_EJAM_fnc_ShowUnjamMenu;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "clear_chamber": {
		[3, [], {
			REMOVE_ROUND;
			[nil,"chamber_empty",nil,nil] call dzn_EJAM_fnc_setWeaponState;
			[] spawn dzn_EJAM_fnc_ShowUnjamMenu;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "remove_case": {
		[3, [], {
			[nil,nil,"case_ejected",nil] call dzn_EJAM_fnc_setWeaponState;
			[] spawn dzn_EJAM_fnc_ShowUnjamMenu;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "detach_mag": {
		[if (dzn_EJAM_handleMag) then { 0.3 } else { 1 }, [], {
			true call dzn_EJAM_fnc_manageMagazine;
			[nil,nil,nil,"mag_detached"] call dzn_EJAM_fnc_setWeaponState;
			[] spawn dzn_EJAM_fnc_ShowUnjamMenu;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
	case "attach_mag": {
		[1, [], {
			false call dzn_EJAM_fnc_manageMagazine;
			[nil,nil,nil,"mag_attached"] call dzn_EJAM_fnc_setWeaponState;
			[] spawn dzn_EJAM_fnc_ShowUnjamMenu;
		}, {}, _processText] call ace_common_fnc_progressBar;
	};
};