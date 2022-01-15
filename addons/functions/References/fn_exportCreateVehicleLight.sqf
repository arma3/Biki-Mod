/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportCreateVehicleLight
Description:
	Generates a list with all classes that can be used with createVehicle.
Parameters:
	none
Returns:
	_result - The list that was copied to the clipboard <STRING>
Examples:
	(begin example)
		_result = [] call BIKI_fnc_exportCreateVehicleLight;
	(end)
Author:
	Lou Montana
---------------------------------------------------------------------------- */
private _result = "";
"if (getNumber (_x >> 'scope') > 0) then
{
	_result = format ["%1* %2\n", _result, configName _x];
}" configClasses (configFile >> "CfgVehicles");
copyToClipboard _result;
_result;
