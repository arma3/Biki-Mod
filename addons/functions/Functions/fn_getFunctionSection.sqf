/* ----------------------------------------------------------------------------
Function: BIKI_fnc_getFunctionSection
Description:
	Returns a section from a function header. Function header is expected to be
	in the same format as this function.
Parameters:
	__VAR__ - __DESCRIPTION___ <__TYPES__>
Returns:
	__VAR__ - __DESCRIPTION___ <__TYPE__>
Examples:
	(begin example)
		_section = ["BIKI_fnc_getFunctionSection", "Author"] call BIKI_fnc_getFunctionSection;
		// ==> "Terra"
	(end)
Author:
	Terra
---------------------------------------------------------------------------- */
params ["_str", "_section"];
private _header = _str call BIKI_fnc_getFunctionHeader;
private _lines = _header splitString endl;
private _content = [];
private _capture = false;
{
	if (_capture) then {
		if (_x regexMatch "[^\s].*") then {break};
		_content pushBack (_x regexReplace ["\t|\ s{4}/i", ""]); // Keep indents
	};
	if (_x regexMatch format ["%1.*/i", _section]) then {
		_capture = true;
	};
} forEach _lines;
_content joinString endl
