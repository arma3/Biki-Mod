/* ----------------------------------------------------------------------------
Function: BIKI_fnc_regexFirstMatch
Description:
	__DESCRIPTION___
Parameters:
	_str - Haystack <STRING>
	_pattern - regex pattern <STRING>
Returns:
	_match - The first occurence or empty string<STRING>
Examples:
	(begin example)
		_match = ["haystack", "a/i"] call BIKI_fnc_regexFirstMatch;
		// _match ==> "a"
	(end)
Author:
	Terra
---------------------------------------------------------------------------- */
params ["_str", "_pattern"];
_str regexFind [_pattern, 0]
	param [0, []]
	param [0, []]
	param [0, ""]
