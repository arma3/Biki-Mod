/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportHitpoints
Description:
	Generate a table with all available hitpoints.
Parameters:
	none
Returns:
	nil
Examples:
	(begin example)
		_nil = [] call BIKI_fnc_exportHitpoints;
	(end)
Author:
	R3vo
---------------------------------------------------------------------------- */
//If 3den Enhanced is installed, the script will also fill the "Name" column with available translations
[] spawn
{
	startLoadingScreen ["Loading"];
	private _hitPoints = [];
	{
		_veh = configName _x createVehicle [0, 0, 0];
		{
			_hitpoints pushBackUnique _x;
		} forEach (getAllHitPointsDamage _veh # 0);
		deleteVehicle _veh;
	} forEach ("isClass (_x >> 'HitPoints') && getNumber (_x >> 'Scope') >= 1" configClasses (configFile >> "CfgVehicles"));
	_hitpoints sort true;

	private _text = "{| class=""wikitable sortable""" + endl +"|-" + endl + "! No. !! Hit Point !! Name";

	{
		_text = _text + endl + "|-" + endl + "| " + str (_forEachIndex + 1) + " || " + _x + " || " + localize ("STR_ENH_DAMAGE_" + _x);
	} forEach _hitpoints;
	copyToClipboard (_text + endl + "|}");
	systemChat "Data copied!";
	endLoadingScreen;
};
