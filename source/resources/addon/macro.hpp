#define TITLE "dzn Extended Jamming"
#define	gADDON EJAM
#define	gADDON_NAME dzn_##gADDON

#define gADDON_PATH \##gADDON_NAME
#define gFNC_PATH gADDON_PATH##\functions\##

#define QUOTE(s) #s

#define	ADDON QUOTE(gADDON)
#define ADDON_NAME QUOTE(gADDON_NAME)
#define PATH QUOTE(gADDON_PATH)
#define FNC_PATH QUOTE(gFNC_PATH)

#define GVAR(X) gADDON_NAME##_##X
#define SVAR(X) QUOTE(GVAR(X))
#define FORMAT_VAR(X) format ["%1_%2", ADDON_NAME, X]

#define gSTR_NAME(X) STR_##gADDON##_##X
#define STR_NAME(X) QUOTE(gSTR_NAME(X))

#define LOCALIZE_FORMAT_STR(X) localize format ["STR_%1_%2", ADDON, X]
#define LOCALIZE_FORMAT_STR_desc(X) localize format ["STR_%1_%2_desc", ADDON, X]

#define COMPILE_FUNCTION(X) GVAR(X) = compile preprocessFileLineNumbers format ["%1%2.sqf", FNC_PATH, #X]

#define gSND_PATH gADDON_PATH##\sounds\##
#define gSND(X) gSND_PATH##X
#define SND(X) QUOTE(gSND(X))
