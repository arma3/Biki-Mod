/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportCfgMarkersColors
Description:
	Generates a table with all marker colors and copies it to clipboard.
Parameters:
	none
Returns:
	nil
Examples:
	(begin example)
		_nothing = [] call BIKI_fnc_exportCfgMarkersColors;
	(end)
Author:
	R3vo
---------------------------------------------------------------------------- */
private _output = format ["Last updated: {{GVI|arma3|%1}}", (productVersion select 2) / 100] + endl;
_output = _output + "{| class =""wikitable""" + endl + format ["|-%1! %2 !! %3",endl,"Config Name","RGBA"];
{
	private _colour = getArray (_x >> "color") call BIS_fnc_colorConfigToRGBA;
	private _colourName = configName _x;
	_output = _output + format ["%1|-%1|%2 || %3",endl,_colourName,_colour];
} forEach configProperties [configFile >> "CfgMarkerColors"];
_output = _output + endl + "|}";
copyToClipboard _output;
