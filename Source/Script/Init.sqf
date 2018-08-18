
// Exit at dedicated or headless client
if (!hasInterface) exitWith {};

#include "macro.hpp"

call compile preprocessFileLineNumbers format ["%1\Enums.sqf", PATH];
call compile preprocessFileLineNumbers format ["%1\Functions.sqf", PATH];
call compile preprocessFileLineNumbers format ["%1\Settings.sqf", PATH];

// ACE Self-intereaction menu node
[
	typeof player, 1, ["ACE_SelfActions", "ACE_Equipment"], [
		SVAR(ACE_Action_Inspect)
		, LOCALIZE_FORMAT_STR("Action_Inspect")
		, ""
		, { call GVAR(fnc_inspectWeapon) }
		, { true call GVAR(fnc_checkJammed) }
	] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;

// Init main loop
[] spawn {
	waitUntil { !isNil {player getVariable "ace_overheating_jammedWeapons"} };

	while { true } do {
		sleep 0.5;
		
		if ( false call GVAR(fnc_checkJammed) ) then {
			call GVAR(fnc_setJamCause);
		};
	};
};
