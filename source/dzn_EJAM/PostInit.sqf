#include "macro.hpp"

// Init for script
call compile preprocessFileLineNumbers format ["%1\PreInit.sqf", PATH];

// Exit at dedicated or headless client
if (!hasInterface) exitWith {};

GVAR(ClassFamiliesCache) = call CBA_fnc_createNamespace;
GVAR(ConfigData) = call CBA_fnc_createNamespace;

[{ time > 0 && !isNull player && local player },{
	player addEventHandler ["Respawn", {
		params ["_unit", "_corpse"];
		call FUNC(initPlayer);
	}];

	// Handle ACE Overheating if enabled
	if (missionNamespace getVariable ["ace_overheating_enabled",false]) then {
		// Wait ACE init
		[{!isNil "ace_overheating_cacheWeaponData" && !isNil "ace_overheating_cacheSilencerData"},{
			// Save actual Unjam chance (to use for sidearms)
			GVAR(ACEUnjamFailChance) = ace_overheating_unJamFailChance;

			// Update ACE Overheating data with custom mapping
			[] call FUNC(processMappingData);
			// Run ACE Jammed handler if ACE Overheating enabled
			GVAR(ACE_Jammed_EH) = ["ace_weaponJammed", {
				if (_this select 1 != primaryWeapon player) exitWith {};
				[] call FUNC(setJammed);
			}] call CBA_fnc_addEventHandler;
		}] call CBA_fnc_waitUntilAndExecute;
	};

	[] call FUNC(initPlayer);

	// Add ACE Self-Interecation action if ACE Interaction is running
	if (!isNil "ace_interact_menu_fnc_createAction") then {
		[] call FUNC(addACEAction);
	};
}] call CBA_fnc_waitUntilAndExecute;
