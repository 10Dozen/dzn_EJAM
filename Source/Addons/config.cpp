class CfgPatches
{
	class dzn_EJAM
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"CBA_MAIN"};
		author[] = {"10Dozen"};
		version = "2.1";
	};
};

class Extended_PostInit_EventHandlers
{
	class dzn_EJAM
	{
		init = "call ('\dzn_EJAM\Init.sqf' call SLX_XEH_COMPILE)";
	};
};

#include "ui\dialog.hpp"
#include "ui\dzn_EJAM_Menu.hpp"
#include "ui\dzn_EJAM_ProgressBar.hpp"
#include "ui\dzn_EJAM_Config.hpp"

#include "sounds\CfgSounds.hpp"