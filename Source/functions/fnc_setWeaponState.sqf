/*
	author: 10Dozen
	description: Set/updates state of weapon elements (bolt, chamber, case ejection port and magazine)
	returns: nothing
*/

params[["_boltState",""],["_chamberState",""],["_caseState",""],["_magState",""]];

private _currentState = player getVariable ["dzn_EJAM_WeaponState", []];

if (_currentState isEqualTo []) then {
	// First time set
	player setVariable ["dzn_EJAM_WeaponState", _this];
} else {
	player setVariable [
		"dzn_EJAM_WeaponState"
		, [
			if (_boltState == "") then { _currentState select 0 } else { _boltState }
			, if (_chamberState == "") then { _currentState select 1 } else { _chamberState }
			, if (_caseState == "") then { _currentState select 2 } else { _caseState }
			, if (_magState == "") then { _currentState select 3 } else { _magState }
		]
	];
};