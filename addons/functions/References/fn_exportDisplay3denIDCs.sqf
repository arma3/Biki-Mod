/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportDisplay3denIDCs
Description:
	Generate a table with all controls used on the 3den Editor display.
	https://community.bistudio.com/wiki/Arma_3:_Display3DEN_IDCs
Parameters:
	none
Returns:
	nil
Examples:
	(begin example)
		_nil = [] call BIKI_fnc_exportDisplay3denIDCs;
	(end)
Author:
	R3vo
---------------------------------------------------------------------------- */
private _controls = "{| class=""wikitable sortable""
|-
! Config Name !! IDC !! Config Path" + endl;

private _fnc_scanConfig =
{
	params ["_config"];
	"true" configClasses _config apply
	{
		_idc = getNumber (_x >> "idc");
		if (_idc > 0) then
		{
			_controls = _controls + "|-" + endl + "|" + "{{hl|" + configName _x + "}}" + " || " + str _idc + " || " + "{{ic|" + ([_x, ""] call BIS_fnc_configPath) + "}}" + endl;
		};
		_x call _fnc_scanConfig;
	};
};

[configFile >> "display3DEN"] call _fnc_scanConfig;

copyToClipboard (_controls + endl + "|}");;
