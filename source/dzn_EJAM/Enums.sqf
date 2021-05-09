#include "macro.hpp"
#include "Enums.hpp"

// Causes list in format: [ @ID, [@BoltState, @ChamberState, @CaseState, @MagState] ]
GVAR(Causes) =  [
	[
		/* "Неподача патрона" */
		/* To fix: 	ACTION_PULL_BOLT */
		CAUSE_FEED_FAILURE
		,[STATE_BOLT_CLOSED, STATE_CHAMBER_EMPTY, STATE_CASE_EJECTED, STATE_MAG_ATTACHED]
	]
	,[
		/* "Утыкание патрона" */
		/* To fix: 	ACTION_OPEN_BOLT, ACTION_DETACH_MAG, ACTION_CLEAR_CHAMBER */
		CAUSE_CHAMBER_FAILURE
		,[STATE_BOLT_NOT_CLOSED, STATE_CHAMBER_STUCK, STATE_CASE_EJECTED, STATE_MAG_ATTACHED]

	]
	,[
		/* "Осечка" */
		/* To fix: 	ACTION_PULL_BOLT */
		CAUSE_DUD
		,[STATE_BOLT_CLOSED, STATE_CHAMBER_READY, STATE_CASE_EJECTED, STATE_MAG_ATTACHED]
	]
	,[
		/* "Неизвлечение гильзы" */
		/* To fix: 	ACTION_OPEN_BOLT, ACTION_DETACH_MAG, ACTION_CLEAR_CHAMBER */
		CAUSE_EXTRACTION_FAILURE
		,[STATE_BOLT_NOT_CLOSED, STATE_CHAMBER_NOT_EXTRACTABLE, STATE_CASE_EJECTED, STATE_MAG_ATTACHED]
	]
	,[
		/* "Прихват гильзы" */
		/* To fix: 	ACTION_OPEN_BOLT, ACTION_REMOVE_CASE */
		CAUSE_EJECTION_FAILURE
		,[STATE_BOLT_NOT_CLOSED, [STATE_CHAMBER_EMPTY, STATE_CHAMBER_STUCK], STATE_CASE_NOT_EJECTED, STATE_MAG_ATTACHED]
	]
];

//	, [
//		/* Затяжной выстрел */
//		/* To fix: 	ACTION_PULL_BOLT */
//		"hang_fire"
//		, [STATE_BOLT_CLOSED,STATE_CHAMBER_READY,STATE_CASE_EJECTED,STATE_MAG_ATTACHED]
//	]
//	, [
//		/* Неконтролируемый автоматический огонь */
//		/* To fix:	ACTION_DETACH_MAG or reload */
//		"unmanned_fire"
//		, [STATE_BOLT_CLOSED,STATE_CHAMBER_READY,STATE_CASE_EJECTED,STATE_MAG_ATTACHED]
//	]


// Weapon States; In format [@ID, @DisplayName]
GVAR(States) = [
	[STATE_BOLT_CLOSED, LSTR(State_BoltClosed)],
	[STATE_BOLT_NOT_CLOSED, LSTR(State_BoltNotClosed)],
	[STATE_BOLT_OPENED, LSTR(State_BoltOpened)],
	[STATE_CHAMBER_EMPTY, LSTR(State_ChamberEmpty)],
	[STATE_CHAMBER_READY, LSTR(State_ChamberReady)],
	[STATE_CHAMBER_STUCK, LSTR(State_ChamberStucked)],
	[STATE_CHAMBER_NOT_EXTRACTABLE, LSTR(State_ChamberNotExtracted)],
	[STATE_CASE_EJECTED, LSTR(State_CaseEjected)],
	[STATE_CASE_NOT_EJECTED, LSTR(State_ChamberNotEjected)],
	[STATE_MAG_ATTACHED, LSTR(State_MagAttached)],
	[STATE_MAG_DETACHED, LSTR(State_MagDetached)]
];

// Actions; In format [@ID, @DisplayName, @ProgressBarDisplayText, @TimeSpent]
GVAR(FixActions) = [
	[ACTION_PULL_BOLT,
		LSTR(Action_PullBolt), LSTR(Action_PullBolt_Process), 0.5],
	[ACTION_OPEN_BOLT,
		LSTR(Action_OpenBolt), LSTR(Action_OpenBolt_Process), 0.5],
	[ACTION_CLEAR_CHAMBER,
		LSTR(Action_ClearChamber), LSTR(Action_ClearChamber_Process), 3],
	[ACTION_REMOVE_CASE,
		LSTR(Action_RemoveCase), LSTR(Action_RemoveCase_Process), 1.5],
	[ACTION_DETACH_MAG,
		LSTR(Action_MagDetach), LSTR(Action_MagDetach_Process), 0.3],
	[ACTION_ATTACH_MAG,
		LSTR(Action_MagAttach), LSTR(Action_MagAttach_Process), 0.75],
	[ACTION_INSPECT,
		LSTR(Action_Inspect), LSTR(Action_Inspect_Process), 0.5]
];

GVAR(Defaults) = [
	STATE_BOLT_CLOSED
	, STATE_CHAMBER_READY
	, STATE_CASE_EJECTED
	, STATE_MAG_ATTACHED
];

GVAR(Mapping) = [
	[
		"arifle_MX_F", 0.01, 45, 10, 45, 0, 0
	]
];
