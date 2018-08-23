#include "macro.hpp"

// Causes list in format: [ @ID, [@BoltState, @ChamberState, @CaseState, @MagState] ]
GVAR(Causes) =  [
	[
		/* "Неподача патрона" */
		/* To fix: 	"pull_bolt" */
		"feed_failure" 
		,["bolt_closed","chamber_empty","case_ejected","mag_attached"]
	]
	,[
		/* "Утыкание патрона" */
		/* To fix: 	"open_bolt","detach_mag","clear_chamber" */
		"feed_failure_2"
		,["bolt_not_closed","chamber_stucked","case_ejected","mag_attached"]
		
	]
	,[
		/* "Осечка" */
		/* To fix: 	"pull_bolt" */
		"dud"
		,["bolt_closed","chamber_ready","case_ejected","mag_attached"]
	]
	,[
		/* "Неизвлечение гильзы" */
		/* To fix: 	"open_bolt","detach_mag","remove_case","clear_chamber" */
		"fail_to_extract"
		,["bolt_not_closed","chamber_not_extracted","case_not_ejected","mag_attached"]
	]
	,[
		/* "Прихват гильзы" */
		/* To fix: 	"open_bolt","remove_case" */
		"fail_to_eject"
		,["bolt_not_closed","chamber_empty","case_not_ejected","mag_attached"]
	]
];

//	, [
//		/* Затяжной выстрел */
//		/* To fix: 	"pull_bolt" */
//		"hang_fire"
//		, ["bolt_closed","chamber_ready","case_ejected","mag_attached"]
//	]
//	, [
//		/* Неконтролируемый автоматический огонь */
//		/* To fix:	"detach_mag" or reload */
//		"unmanned_fire"
//		, ["bolt_closed","chamber_ready","case_ejected","mag_attached"]
//	]


// Weapon States; In format [@ID, @DisplayName]
GVAR(States) = [
	["bolt_closed"				,localize "STR_EJAM_State_BoltClosed"]
	,["bolt_not_closed"			,localize "STR_EJAM_State_BoltNotClosed"]
	,["bolt_opened"				,localize "STR_EJAM_State_BoltOpened"]
	,["chamber_empty"			,localize "STR_EJAM_State_ChamberEmpty"]
	,["chamber_ready"			,localize "STR_EJAM_State_ChamberReady"]
	,["chamber_stucked"			,localize "STR_EJAM_State_ChamberStucked"]
	,["chamber_not_extracted"	,localize "STR_EJAM_State_ChamberNotExtracted"]	
	,["case_not_ejected"		,localize "STR_EJAM_State_ChamberNotEjected"]
	,["case_ejected"			,localize "STR_EJAM_State_CaseEjected"]
	,["mag_attached"			,localize "STR_EJAM_State_MagAttached"]
	,["mag_detached"			,localize "STR_EJAM_State_MagDetached"]
];

// Actions; In format [@ID, @DisplayName, @ProgressBarDisplayText, @TimeSpent]
GVAR(FixActions) = [
	["pull_bolt"		,localize "STR_EJAM_Action_PullBolt"		, localize "STR_EJAM_Action_PullBolt_Process"		, 0.5]
	,["open_bolt"		,localize "STR_EJAM_Action_OpenBolt"		, localize "STR_EJAM_Action_OpenBolt_Process"		, 0.5]
	,["clear_chamber"	,localize "STR_EJAM_Action_ClearChamber"	, localize "STR_EJAM_Action_ClearChamber_Process"	, 3]
	,["remove_case"		,localize "STR_EJAM_Action_RemoveCase"		, localize "STR_EJAM_Action_RemoveCase_Process"		, 1.5]
	,["detach_mag"		,localize "STR_EJAM_Action_MagDetach"		, localize "STR_EJAM_Action_MagDetach_Process"		, 0.3]		
	,["attach_mag"		,localize "STR_EJAM_Action_MagAttach"		, localize "STR_EJAM_Action_MagAttach_Process"		, 0.75]		
	,["inspect"			,localize "STR_EJAM_Action_Inspect"			, localize "STR_EJAM_Action_Inspect_Process"		, 0.5]
];

GVAR(Defaults) = [
	"bolt_closed"
	, "chamber_ready"
	, "case_ejected"
	, "mag_attached"
];

GVAR(Mapping) = [
	[
		"arifle_MX_F", 1.5, 20, 20, 20, 20, 20
	]
];