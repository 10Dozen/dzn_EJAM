class CfgPatches
{
	class dzn_EJAM
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"CBA_MAIN","ace_interaction","ace_overheating"};
		author[] = {"10Dozen"};
		version = "1";
	};
};

class Extended_PostInit_EventHandlers
{
	class dzn_EJAM
	{
		serverInit = "call ('\dzn_EJAM\Init.sqf' call SLX_XEH_COMPILE)";
	};
};

#include "dialog.hpp"
#include "sounds\CfgSounds.hpp"