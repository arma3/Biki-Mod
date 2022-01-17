/* ----------------------------------------------------------------------------
Function: BIKI_fnc_getFunctionHeader
Description:
	Returns the function's header. Header has to be in the same format as this
	one.
Parameters:
	_fnc - The function, either as a name or as the function's content <STRING>
Returns:
	_header - The function's header <STRING>
Examples:
	(begin example)
		_header = "BIKI_fnc_getFunctionHeader" call BIKI_fnc_getFunctionHeader;
	(end)
Author:
	Terra
---------------------------------------------------------------------------- */
params ["_fnc"];
if (_fnc regexMatch "^\w+_fnc_\w+$") then {
	// Function name passed, load file
	(_fnc call BIS_fnc_functionMeta) params ["_fileLocation"];
	_fnc = loadFile _fileLocation;
};
[_fnc, "\/\*\ -{76}.*-{76}\ \*\//i"] call BIKI_fnc_regexFirstMatch
