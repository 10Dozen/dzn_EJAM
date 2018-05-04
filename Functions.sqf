private _path = "functions";
private _compile = { compile preprocessFileLineNumbers format ["%1/%2.sqf", _path, _this] };

dzn_EJAM_fnc_setJamCause 		= "fnc_setJamCause" call _compile;
dzn_EJAM_fnc_setWeaponState 	= "fnc_setWeaponState" call _compile;
dzn_EJAM_fnc_doAction			= "fnc_doAction" call _compile;
dzn_EJAM_fnc_pullBolt			= "fnc_pullBolt" call _compile;
dzn_EJAM_fnc_processWeaponFixed	= "fnc_processWeaponFixed" call _compile;
dzn_EJAM_fnc_ShowUnjamMenu		= "fnc_ShowUnjamMenu" call _compile;
dzn_EJAM_fnc_manageMagazine		= "fnc_manageMagazine" call _compile;
dzn_EJAM_fnc_isMagAttached		= "fnc_isMagAttached" call _compile;