class CfgPatches
{
	class dzn_EJAM
	{
		units[] = {"dzn_EJAM_RequireModule"};
		weapons[] = {};
		requiredVersion = 2.02;
		requiredAddons[] = {"CBA_MAIN"};
		author = "10Dozen";
		version = "2.7.3";
	};
};

class Extended_PreInit_EventHandlers
{
	class dzn_EJAM
	{
		init = call compile preprocessFileLineNumbers "\dzn_EJAM\PreInit.sqf";
	};
};
class Extended_PostInit_EventHandlers
{
	class dzn_EJAM
	{
		init = call compile preprocessFileLineNumbers "\dzn_EJAM\PostInit.sqf";
	};
};

class CfgVehicles
{
	class Logic;
    class Module_F: Logic
    {
        class AttributesBase
        {
            class Default;
            class ModuleDescription; 
        };

        class ModuleDescription
        {
        };
    };
	
	class dzn_EJAM_RequireModule: Module_F
    {
        scope = 2; 
        displayName = "Extended Jamming - Require Addon";
        icon = "\dzn_EJAM\module_icon_ca.paa";
        category = "NO_CATEGORY";

        class Attributes: AttributesBase
        {
            class ModuleDescription: ModuleDescription{};
        }

        class ModuleDescription: ModuleDescription
        {
            description = "Place this module in your mission to require all players to have dzn Extended Jamming loaded. The mission will be unplayable without it.";
        };
    };
};

#include "ui\dialog.hpp"
#include "ui\dzn_EJAM_Menu.hpp"
#include "ui\dzn_EJAM_ProgressBar.hpp"
#include "ui\dzn_EJAM_Config.hpp"

#include "sounds\CfgSounds.hpp"