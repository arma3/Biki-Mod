/* ----------------------------------------------------------------------------
Function: BIKI_fnc_imageMarkers
Description:
	Create all markers to take a screenshot of.
	https://community.bistudio.com/wiki/Arma_3:_CfgMarkers
Parameters:
	none
Returns:
	nil
Examples:
	(begin example)
		_nothing = [] call BIKI_fnc_imageMarkers;
	(end)
Author:
	R3vo
---------------------------------------------------------------------------- */
//Marker icons screenshot
//Create a solid, grey area marker in the editor first. Set its size to 100000x100000
_startPos = [-33000, 20000, 0];
_classes = ("true" configClasses (ConfigFile >> "CfgMarkers"));
_classes = [_classes, [], {configName _x}, "ASCEND"] call BIS_fnc_sortBy;

{
	if (_startPos # 0 > 30000) then
	{
		_startPos set [0, -33000];
		_startPos = _startPos vectorAdd [0, -1600, 0];
	};
	_marker = createMarker [configName _x , _startPos];
	_marker setMarkerType configName _x;
	_marker setMarkerText format ["  %1.", _forEachIndex + 1];
	_startPos = _startPos vectorAdd [3500, 0, 0];
} forEach _classes;
