#include "macro.hpp"

#include "XEH_PREP.hpp"

call compile preprocessFileLineNumbers format ["%1\Enums.sqf", PATH];
call compile preprocessFileLineNumbers format ["%1\Settings.sqf", PATH];
