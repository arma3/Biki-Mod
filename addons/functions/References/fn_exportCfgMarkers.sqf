/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportCfgMarkers
Description:
	Generates a Mediawiki table with all markers.
	https://community.bistudio.com/wiki/Arma_3:_CfgMarkers
Parameters:
	none
Returns:
	nil
Examples:
	(begin example)
		_nothing = [] call BIKI_fnc_exportCfgMarkers;
	(end)
Author:
	R3vo
---------------------------------------------------------------------------- */
//Marker data to biki table
_classes = ("true" configClasses (ConfigFile >> "CfgMarkers"));
_classes = [_classes, [], {configName _x}, "ASCEND"] call BIS_fnc_sortBy;
_export = "{| class=""wikitable - sortable""
|-
! No. !! Class !! Name !! Icon Path !! Shadow !! Scope !! Added with
|-";

{
	_addon = _x call ENH_fnc_getConfigSourceAddon params [["_addonClass", ""]];
	if (_addonClass isNotEqualTo "") then {_addonClass = format ["{{Icon|%1|24}}", _addonClass]};

	_shadow = ["{{Icon|checked}}", "{{Icon|unchecked}}"] select (getNumber (_x >> "shadow"));
	_export = _export + endl + "| " + str (_forEachIndex + 1) + "." + " || " + "{{hl|" + configName _x + "}}" + " || " + getText (_x >> "name") + " || " + "{{hl|" + getText (_x >> "icon") + "}}" + " || " + _shadow + " || " + str getNumber (_x >> "scope") + " || " + _addonClass + endl + "|-"
} forEach _classes;

copyToClipboard ((_export trim ["|-", 2]) + "|}");
