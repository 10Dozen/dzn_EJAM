
// Exit at dedicated or headless client
if (!hasInterface) exitWith {};

#include "macro.hpp"

call compile preprocessFileLineNumbers format ["%1\Enums.sqf", PATH];
call compile preprocessFileLineNumbers format ["%1\Functions.sqf", PATH];
call compile preprocessFileLineNumbers format ["%1\Settings.sqf", PATH];

// ACE Self-intereaction menu node
GVAR(ACE_InspectActionClass) = [
	SVAR(ACE_Action_Inspect)
	, LOCALIZE_FORMAT_STR("Action_Inspect")
	, getText (configFile >> "CfgWeapons" >> primaryWeapon player >> "picture")
	, { call GVAR(fnc_inspectWeapon) }
	, { true }
] call ace_interact_menu_fnc_createAction;

[
	typeof player, 1
	, ["ACE_SelfActions", "ACE_Equipment"]
	, GVAR(ACE_InspectActionClass)
] call ace_interact_menu_fnc_addActionToClass;

// Init main loop
[] spawn {
	sleep 5;
	GVAR(CurrentWeapon) = primaryWeapon player;

	while { true } do {
		sleep 0.5;
		
		if ( !isNil {player getVariable "ace_overheating_jammedWeapons"} && { "cause" call GVAR(fnc_checkJammed) } ) then {
			call GVAR(fnc_setJamCause);
		};

		if (GVAR(CurrentWeapon) != primaryWeapon player && primaryWeapon player != "") then {
			GVAR(CurrentWeapon) = primaryWeapon player;
			GVAR(ACE_InspectActionClass) set [2, getText(configFile >> "CfgWeapons" >> GVAR(CurrentWeapon) >> "picture")];
		}
	};
};
