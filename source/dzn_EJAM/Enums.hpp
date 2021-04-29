// --- Causes
#define CAUSE_FEED_FAILURE "feed_failure"
#define CAUSE_CHAMBER_FAILURE "chamber_failure"
#define CAUSE_DUD "dud"
#define CAUSE_EXTRACTION_FAILURE "fail_to_extract"
#define CAUSE_EJECTION_FAILURE "fail_to_eject"

// --- States
#define STATE_BOLT_CLOSED "bolt_closed"
#define STATE_BOLT_NOT_CLOSED "bolt_not_closed"
#define STATE_BOLT_OPENED "bolt_opened"

#define STATE_CHAMBER_EMPTY "chamber_empty"
#define STATE_CHAMBER_READY "chamber_ready"
#define STATE_CHAMBER_STUCK "chamber_stuck"
#define STATE_CHAMBER_DOUBLE_FED "chamber_double_fed" // Not used
#define STATE_CHAMBER_NOT_EXTRACTABLE "chamber_not_extracted"

#define STATE_CASE_EJECTED "case_ejected"
#define STATE_CASE_NOT_EJECTED "case_not_ejected"

#define STATE_MAG_ATTACHED "mag_attached"
#define STATE_MAG_DETACHED "mag_detached"

// --- Actions
#define ACTION_PULL_BOLT "pull_bolt"
#define ACTION_OPEN_BOLT "open_bolt"
#define ACTION_CLEAR_CHAMBER "clear_chamber"
#define ACTION_REMOVE_CASE "remove_case"
#define ACTION_DETACH_MAG "detach_mag"
#define ACTION_ATTACH_MAG "attach_mag"
#define ACTION_INSPECT "inspect"


// --- Compares

#define CHECK_BOLT_OPENED(X) (X isEqualTo STATE_BOLT_OPENED)
#define CHECK_BOLT_CLOSED(X) (X isEqualTo STATE_BOLT_CLOSED)

#define CHECK_CHAMBER_READY(X) (X isEqualTo STATE_CHAMBER_READY)
#define CHECK_CHAMBER_EMPTY(X) (X isEqualTo STATE_CHAMBER_EMPTY)
#define CHECK_CHAMBER_STUCK(X) (X isEqualTo STATE_CHAMBER_STUCK)
#define CHECK_CHAMBER_DOUBLE_FED(X) (X isEqualTo STATE_CHAMBER_DOUBLE_FED)
#define CHECK_CHAMBER_NOT_EXTRACTED(X) (X isEqualTo STATE_CHAMBER_NOT_EXTRACTABLE)

#define CHECK_CASE_EJECTED(X) (X isEqualTo STATE_CASE_EJECTED)

#define CHECK_MAG_ATTACHED(X) (X isEqualTo STATE_MAG_ATTACHED)
