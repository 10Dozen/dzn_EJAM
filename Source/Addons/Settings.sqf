#define		TITLE		"dzn Extended Jamming"
#define		SETNAME(X)	format["dzn_EJAM_%1", X]

// Addon Settings
[
	SETNAME("handleMag")
	, "CHECKBOX"
	, [localize "STR_EJAM_Settings", localize "STR_EJAM_Settings_Desc"]
	, TITLE
	, true
	, true
] call CBA_Settings_fnc_init;


// Keybinding
[
	TITLE
	,"dzn_ejam_actionKey"
	, localize "STR_EJAM_Keybingding"
	, { [] spawn dzn_EJAM_fnc_ShowUnjamMenu;	}
	, {}
	, [19, [false,true,false]]
] call CBA_fnc_addKeybind;