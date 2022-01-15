/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportCreateVehicleHeavy
Description:
	Generate a list with all classnames that can be used with createVehicle.
	This version includes the hitpoints. See also: exportCreateVehicleLight.
	https://community.bistudio.com/wiki/Arma_3:_createVehicle/vehicles
Parameters:
	none
Returns:
	_result - List with all vehicle classnames <STRING>
Examples:
	(begin example)
		_result = [] call BIKI_fnc_exportCreateVehicleHeavy;
	(end)
Author:
	Killzone_Kid
---------------------------------------------------------------------------- */
private _result = "";
"if (getNumber (_x >> 'scope') > 0) then
{
	_result = _result + '* ' + configName _x + ""\n"";
	for '_i' from 0 to count (_x >> 'AnimationSources') - 1 do
	{
		_animSource = (_x >> 'AnimationSources') select _i;
		_source = getText (_animSource >> 'source');
		if (_source == 'hit') then { _source = 'hit [' + getText (_animSource >> 'hitpoint') + ']' };
		if (_source != '') then { _source = ' => ' + _source };
		_result = _result + ('*# ' + configName _animSource + _source) + ""\n"";
	};
}" configClasses (configFile >> "CfgVehicles");
copyToClipboard _result;
_result;
