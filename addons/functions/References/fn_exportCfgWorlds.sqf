/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportCfgWorlds
Description:
	__DESCRIPTION___
Parameters:
	none
Returns:
	nil
Examples:
	(begin example)
		_nil = [] call BIKI_fnc_exportCfgWorlds;
	(end)
Author:
	Killzone_Kid
---------------------------------------------------------------------------- */
"if ((configName _x) select [0, 5] == 'group') then
{
	diag_log ('%' + configName _x);
	for '_i' from 0 to count _x - 1 do {
		diag_log ('* ""' + configName (_x select _i) + '"" &rarr; ' + getText ((_x select _i) >> 'name'));
	};
}; false" configClasses (configFile >> "CfgWorlds");
