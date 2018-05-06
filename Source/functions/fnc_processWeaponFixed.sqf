/*
	author: 10Dozen
	description: Verify weapon states to decide - is it fixed or not, then call ACE's UnJam
	returns: nothing
*/

if (isNil { player getVariable "dzn_EJAM_WeaponState" }) exitWith {};

(player getVariable "dzn_EJAM_WeaponState") params ["_bolt","_chamber","_case","_mag"];

if (
	_bolt != "bolt_not_closed"
	&& _chamber in ["chamber_ready","chamber_empty"]
	&& _case == "case_ejected"
	&& _mag == "mag_attached"
) then {
	private _oldFailChance = ace_overheating_unJamFailChance;
	ace_overheating_unJamFailChance = 0;

	[player, currentWeapon player, true] call ace_overheating_fnc_clearJam;
	player playActionNow "gestureYes";
	// [player, "gestureYes"] call ace_common_fnc_doGesture;

	ace_overheating_unJamFailChance = _oldFailChance;

	player setVariable ["dzn_EJAM_Cause", nil];
	player setVariable ["dzn_EJAM_WeaponState", nil];
	player setVariable ["dzn_EJAM_CauseSet", false];
	player setVariable ["dzn_EJAM_RemovedMagazine", nil];
	player setVariable ["dzn_EJAM_LooseRound", nil];
};