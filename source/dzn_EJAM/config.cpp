class CfgPatches
{
	class dzn_EJAM
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"CBA_MAIN"};
		author[] = {"10Dozen"};
		version = "2.7";
	};
};

class Extended_PreInit_EventHandlers
{
	class dzn_EJAM
	{
		init = call compile preprocessFileLineNumbers "\dzn_EJAM\Init.sqf";
	};
};

#include "ui\dialog.hpp"
#include "ui\dzn_EJAM_Menu.hpp"
#include "ui\dzn_EJAM_ProgressBar.hpp"
#include "ui\dzn_EJAM_Config.hpp"

#include "sounds\CfgSounds.hpp"