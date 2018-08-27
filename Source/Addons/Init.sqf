
#include "macro.hpp"

call compile preprocessFileLineNumbers format ["%1\Enums.sqf", PATH];
call compile preprocessFileLineNumbers format ["%1\Functions.sqf", PATH];
call compile preprocessFileLineNumbers format ["%1\Settings.sqf", PATH];

// Exit at dedicated or headless client
if (!hasInterface) exitWith {};
// Init main
[] spawn {
	waitUntil { !isNull player }; // Handle 3DEN and/or specator
	sleep 5;

	if (missionNamespace getVariable ["ace_overheating_enabled",false]) then {
		// Wait ACE init 
		waitUntil { 
			!isNil "ace_overheating_cacheWeaponData"
			&& !isNil "ace_overheating_cacheSilencerData"
		};

		// Update ACE Overheating data with custom mapping
		call GVAR(fnc_processMappingData);

		// Run ACE Jammed handler if ACE Overheating enabled
		GVAR(ACE_Jammed_EH) = [
			"ace_weaponJammed"
			, { 
				if (_this select 1 != primaryWeapon player) exitWith {}; 
				call GVAR(fnc_setJammed);
			}
		] call CBA_fnc_addEventHandler;		
	};

	if (!(missionNamespace getVariable ["ace_overheating_enabled",false]) || GVAR(ForceOverallChance)) then {

		// Run EJAM's FiredEH if ACE Overheating disabled OR EJAM Jam chance forced
		GVAR(FiredEH) = player addEventHandler ["Fired", { call GVAR(fnc_firedEH) }];
	};

	// Add ACE Self-Interecation action if ACE Interaction is running
	if (!isNil "ace_interact_menu_fnc_createAction") exitWith {
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

		// Loop to handle gun icon change		
		GVAR(CurrentWeapon) = primaryWeapon player;
		while { true } do {
			sleep 2;
			if (GVAR(CurrentWeapon) != primaryWeapon player && primaryWeapon player != "") then {
				GVAR(CurrentWeapon) = primaryWeapon player;
				GVAR(ACE_InspectActionClass) set [2, getText(configFile >> "CfgWeapons" >> GVAR(CurrentWeapon) >> "picture")];
			};

			if (GVAR(Force)) then {
				ace_overheating_unJamFailChance = 1;
			};
		};
	};
};
