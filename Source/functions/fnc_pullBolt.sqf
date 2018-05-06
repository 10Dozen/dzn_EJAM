/*
	author: 10Dozen
	description: Process bolt pulling action called from Weapon Malfunctions menu
	returns: nothing
*/

(player getVariable "dzn_EJAM_WeaponState") params ["_bolt","_chamber","_case","_mag"];

private _hasAmmo = player ammo (currentWeapon player) > 0;

if (_case == "case_not_ejected") then {
	if (_mag == "mag_attached" && _hasAmmo) then {
		["bolt_not_closed","chamber_stucked",nil,nil] call dzn_EJAM_fnc_setWeaponState;
	} else {
		["bolt_not_closed",nil,nil,nil] call dzn_EJAM_fnc_setWeaponState;
	};
} else {
	if (_chamber == "chamber_stucked") then {
		["bolt_not_closed",nil,nil,nil] call dzn_EJAM_fnc_setWeaponState;
	} else {
		if (_chamber == "chamber_empty") then {
			if (_mag == "mag_attached" && _hasAmmo) then {
				["bolt_closed","chamber_ready",nil,nil] call dzn_EJAM_fnc_setWeaponState;
			} else {
				["bolt_closed",nil,nil,nil] call dzn_EJAM_fnc_setWeaponState;
			};
		} else {
			if (_chamber in ["chamber_not_extracted","chamber_ready"]) then {
				if (_mag == "mag_attached" && _hasAmmo) then {
					if (_bolt == "bolt_opened") then {
						["bolt_not_closed","chamber_stucked",nil,nil] call dzn_EJAM_fnc_setWeaponState;
					} else {
						if (_chamber == "chamber_ready") then { REMOVE_ROUND; };
						["bolt_closed","chamber_ready",nil,nil] call dzn_EJAM_fnc_setWeaponState;
					};
				} else {
					if (_chamber == "chamber_ready") then { REMOVE_ROUND; };
					["bolt_closed","chamber_empty",nil,nil] call dzn_EJAM_fnc_setWeaponState;
				};
			};
		};
	};
};

call dzn_EJAM_fnc_processWeaponFixed;