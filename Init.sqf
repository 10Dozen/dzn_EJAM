call compile preProcessFileLineNumbers "EJAM\Functions.sqf";
call compile preProcessFileLineNumbers "EJAM\UIFunctions.sqf";
call compile preProcessFileLineNumbers "EJAM\Settings.sqf";


// Testing
player addAction ["Jam", {  [player, currentWeapon player] call ace_overheating_fnc_jamWeapon }];

// Init
[] spawn {
	waitUntil { !isNil {player getVariable "ace_overheating_jammedWeapons"} };
	
	while { true } do {
		sleep 1;
		if ( 
			((primaryWeapon player) in (player getVariable "ace_overheating_jammedWeapons"))
			&& !(player getVariable ["dzn_EJAM_CauseSet", false])
		) then {
			call dzn_EJAM_fnc_setJamCause;
		};
	};
};

[typeof player, 1, ["ACE_SelfActions", "ACE_Equipment"], [
	"dzn_EJAM_ACE_Action_Inspect"
	, localize "STR_EJAM_ACE_Action_Title"
	, ""
	, { [] spawn dzn_EJAM_fnc_ShowUnjamMenu; }
	, { 
		((primaryWeapon player) in (player getVariable "ace_overheating_jammedWeapons"))
		&& (player getVariable ["dzn_EJAM_CauseSet", false])
	}
] call ace_interact_menu_fnc_createAction] call ace_interact_menu_fnc_addActionToClass;


/*
	In format 
	[
	  0@ID
	, 1@DisplayedName
	, 2@DisplayedInspectRescription
	, 3@ListOfActionIDsToFox
	, 4@[@BoltState, @ChamberState, @CaseState, @MagState]
	]
*/
dzn_EJAM_Causes = [
	[
		"feed_failure"
		,"Неподача патрона"
		,["bolt_closed","chamber_empty","case_ejected","mag_attached"]
		,["pull_bolt"]
	]
	,[
		"feed_failure_2"
		,"Утыкание патрона"
		,["bolt_not_closed","chamber_stucked","case_ejected","mag_attached"]
		,["open_bolt","detach_mag","clear_chamber"]
		
	]
	,[
		"dud"
		,"Осечка"
		,["bolt_closed","chamber_ready","case_ejected","mag_attached"]
		,["pull_bolt"]
	]
	,[
		"fail_to_extract"
		,"Неизвлечение гильзы"
		,["bolt_not_closed","chamber_not_extracted","case_not_ejected","mag_attached"]
		,["open_bolt","detach_mag","remove_case","clear_chamber"]
		
	]
	,[
		"fail_to_eject"
		,"Прихват гильзы"
		,["bolt_not_closed","chamber_empty","case_not_ejected","mag_attached"]
		,["open_bolt","remove_case"]
	]
];

// Weapon States; In format [@ID, @DisplayName]
dzn_EJAM_States = [
	["bolt_closed"			,localize "STR_EJAM_State_BoltClosed"]
	,["bolt_not_closed"		,localize "STR_EJAM_State_BoltNotClosed"]
	,["bolt_opened"			,localize "STR_EJAM_State_BoltOpened"]
	,["chamber_empty"			,localize "STR_EJAM_State_ChamberEmpty"]
	,["chamber_ready"			,localize "STR_EJAM_State_ChamberReady"]
	,["chamber_stucked"		,localize "STR_EJAM_State_ChamberStucked"]
	,["chamber_not_extracted"	,localize "STR_EJAM_State_ChamberNotExtracted"]	
	,["case_not_ejected"		,localize "STR_EJAM_State_ChamberNotEjected"]
	,["case_ejected"			,localize "STR_EJAM_State_CaseEjected"]
	,["mag_attached"			,localize "STR_EJAM_State_MagAttached"]
	,["mag_detached"			,localize "STR_EJAM_State_MagDetached"]
];

// Actions; In format [@ID, @DisplayName]
dzn_EJAM_FixActions = [
	["pull_bolt"		,localize "STR_EJAM_Action_PullBolt"	, localize "STR_EJAM_Action_PullBolt_Process"]
	,["open_bolt"		,localize "STR_EJAM_Action_OpenBolt"	, localize "STR_EJAM_Action_OpenBolt_Process"]
	,["clear_chamber"		,localize "STR_EJAM_Action_ClearChamber"	, localize "STR_EJAM_Action_ClearChamber_Process"]
	,["remove_case"		,localize "STR_EJAM_Action_RemoveCase"	, localize "STR_EJAM_Action_RemoveCase_Process"]
	,["detach_mag"		,localize "STR_EJAM_Action_MagDetach"	, localize "STR_EJAM_Action_MagDetach_Process"]
	,["attach_mag"		,localize "STR_EJAM_Action_MagAttach"	, localize "STR_EJAM_Action_MagAttach_Process"]
];
