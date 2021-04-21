#define TITLE "dzn Extended Jamming"
#define	gADDON EJAM
#define	gADDON_NAME dzn_##gADDON

#define gADDON_PATH gADDON_NAME
#define gFNCS_PATH gADDON_PATH##\functions\##

#define QUOTE(s) #s

#define	ADDON QUOTE(gADDON)
#define ADDON_NAME QUOTE(gADDON_NAME)
#define PATH QUOTE(gADDON_PATH)
#define FNCS_PATH QUOTE(gFNCS_PATH)
#define PATH_TO_FUNCTION(SUBPATH, NAME) gFNCS_PATH##SUBPATH##\##NAME.sqf


#define GVAR(X) gADDON_NAME##_##X
#define SVAR(X) QUOTE(GVAR(X))
#define FORMAT_VAR(X) format ["%1_%2", ADDON_NAME, X]
#define FUNC(X) gADDON_NAME##_fnc_##X
#define QFUNC(X) QUOTE(FUNC(X))

#define gSTR_NAME(X) STR_##gADDON##_##X
#define STR_NAME(X) QUOTE(gSTR_NAME(X))

#define LOCALIZE_FORMAT_STR(X) localize format ["STR_%1_%2", ADDON, X]
#define LOCALIZE_FORMAT_STR_DESC(X) localize format ["STR_%1_%2_desc", ADDON, X]


#define COMPILE_FUNCTION(SUBPATH,NAME) GVAR(NAME) = compile preprocessFileLineNumbers QUOTE(PATH_TO_FUNCTION(SUBPATH,NAME))
/*
COMPILE_FUNCTION(main,fnc_initPlayer) ->
	dzn_EJAM_fnc_initPlayer = compile preprocessFileLineNumbers "dzn_EJAM\functions\main\fnc_initPlayer.sqf"
*/

#define COMPILE_FUNCTION_CACHED(SUBPATH,NAME) [QUOTE(PATH_TO_FUNCTION(SUBPATH,NAME)), SVAR(NAME)] call CBA_fnc_compileFunction
/* COMPILE_FUNCTION_CACHED(main,fnc_initPlayer) ->
	["dzn_EJAM\functions\main\fnc_initPlayer.sqf", "dzn_EJAM_fnc_initPlayer"] call CBA_fnc_compileFunction
*/

#define DISABLE_COMPILE_CACHE 1
#ifdef DISABLE_COMPILE_CACHE
	#undef PREP
	#define PREP(SUBPATH,NAME) COMPILE_FUNCTION(SUBPATH,NAME)
#else
	#undef PREP
	#define PREP(SUBPATH,NAME) [QUOTE(PATH_TO_FUNCTION(SUBPATH,NAME)), SVAR(NAME)] call CBA_fnc_compileFunction
#endif


#define gSND_PATH gADDON_PATH##\sounds\##
#define gSND(X) gSND_PATH##X
#define SND(X) QUOTE(gSND(X))
