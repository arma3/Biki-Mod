/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportNearestTerrainObjectsCounts
Description:
	Get a count of all objects on the current map.
	https://community.bistudio.com/wiki/nearestTerrainObjects
Parameters:
	none
Returns:
	nil
Examples:
	(begin example)
		_nil = [] call BIKI_fnc_exportNearestTerrainObjectsCounts;
	(end)
Author:
	R3vo
---------------------------------------------------------------------------- */
[] spawn
{
	private _types = ["TREE", "SMALL TREE", "BUSH", "BUILDING", "HOUSE", "FOREST BORDER", "FOREST TRIANGLE", "FOREST SQUARE", "CHURCH", "CHAPEL",
	"CROSS", "BUNKER", "FORTRESS", "FOUNTAIN", "VIEW-TOWER", "LIGHTHOUSE", "QUAY", "FUELSTATION", "HOSPITAL", "FENCE", "WALL", "HIDE", "BUSSTOP",
	"ROAD", "FOREST", "TRANSMITTER", "STACK", "RUIN", "TOURISM", "WATERTOWER", "TRACK", "MAIN ROAD", "ROCK", "ROCKS", "POWER LINES", "RAILWAY",
	"POWERSOLAR", "POWERWAVE", "POWERWIND", "SHIPWRECK", "TRAIL"];

	_types sort true;

	private _counts = [];
	private _countTypes = count _types;

	["R3vo_GetNearestTerrainObjects",""] call BIS_fnc_startLoadingScreen;

	{
		private _terrainObjects = nearestTerrainObjects [
			[worldSize / 2, worldSize / 2],
			[_x],
			worldSize,
			false
		];

		if (count _terrainObjects > 0) then
		{
			_counts pushBack [_x,count _terrainObjects];
		};
		((_forEachIndex + 1) / _countTypes) call BIS_fnc_progressLoadingScreen;
	} forEach _types;

	"R3vo_GetNearestTerrainObjects" call BIS_fnc_endLoadingScreen;

	private _export = "<big>[[" + getText (configFile >> "CfgWorlds" >> worldName >> "description") + "]]</big>" + endl + "{{Columns|5|";

	{
		_export = _export + endl + "* " + (_x # 0) + ": " + (str (_x # 1));
	} forEach _counts;

	_export = _export + endl + "}}";

	copyToClipboard _export;
};
