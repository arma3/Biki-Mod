#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
		name = QUOTE(ADDON);
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {};
		author = "BIKI Contributors";
		authors[] = {};
		url = "https://community.bistudio.com/wiki/Main_Page";
		VERSION_CONFIG;
	};
};

#include "\a3\3den\UI\macros.inc"
#include "CfgScriptPaths.hpp"
#include "Controls.hpp"
