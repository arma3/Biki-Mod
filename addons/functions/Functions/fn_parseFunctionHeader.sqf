/* ----------------------------------------------------------------------------
Function: BIKI_fnc_parseFunctionHeader
Description:
	Extracts information from the header of a CBA like function.
Parameters:
	_fnc - The name of the function to parse <STRING>
Returns:
	_info - Array in format: [description, parameters, return, examples, author] <ARRAY of STRINGs>
Examples:
	(begin example)
		_info = "BIKI_fnc_parseFunctionHeader" call BIKI_fnc_parseFunctionHeader;
		_info params ["_description", "_parameters", "_return", "_examples", "_author"];
		// _description ==> "Extracts information from the header of a CBA like function."
		// _parameters ==> "_fnc - ..."
		// _return ==> "_info - ..."
		// _examples ==> "(begin example)\n	_info = ..."
		// _author ==> "Terra"
	(end)
Author:
	Terra
---------------------------------------------------------------------------- */
params ["_fnc"];
private _fncHeader = [_fnc] call BIKI_fnc_getFunctionHeader;
["Description", "Parameters", "Returns", "Examples", "Author"] apply {
	[_fncHeader, _x] call BIKI_fnc_getFunctionSection;
};
