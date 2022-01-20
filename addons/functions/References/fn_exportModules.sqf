/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportModules
Description:
	Generates a table containing all modules.
	https://community.bistudio.com/wiki/Modules
Parameters:
	none
Returns:
	nil
Examples:
	(begin example)
		_nil = [] call BIKI_fnc_exportModules;
	(end)
Author:
	R3vo
---------------------------------------------------------------------------- */
private _version = [] call BIKI_fnc_lastUpdatedGVI;
private _counter = 0;
private _export = _version + endl + "{| class=""wikitable""" + endl + "! Module Name !! Category !! Addon !! Function !! Description" + endl + "|-" + endl;
private _modules = "(configName inheritsFrom _x) == 'Module_F'" configClasses (configFile >> "CfgVehicles");
{
	if ((getNumber (_x >> "scope") > 1)) then
	{
		private _name = getText (_x >> "displayName");
		private _cat = getText (_x >> "category");
		private _mod = configSourceMod _x;
		private _fnc = getText (_x >> "function");
		if !(_fnc isEqualTo "") then
		{
			_fnc = _fnc select [7];
			_fnc = "[[BIS_fnc" + _fnc + "]]";
		};
		private _desc = getText (_x >> "ModuleDescription" >> "Description");
		if (_desc isEqualTo "") then {_desc = ""};
		if (_mod == "") then {_mod = "A3"};
		private _modName = modParams [_mod,["name"]];
		_modName = _modName select 0;
		_cat = getText (configFile >> "CfgFactionClasses" >> _cat >> "displayName");
		if (_cat isEqualTo "") then {_cat = "Others"};

		_export = _export + "| " + _name + endl + "|| " + _cat + endl + "|| " + _modName + endl + "|| " + _fnc + endl + "|| " + _desc + endl + "|-" + endl;
	};
	_counter = _counter + 1;
} forEach _modules;

_export = _export + "|}" + endl + format ["Total number of modules: %1", _counter];
copyToClipboard _export;
