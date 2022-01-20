/* ----------------------------------------------------------------------------
Function: BIKI_fnc_arrayToTable
Description:
	Converts two arrays into a wiki table with header.
Parameters:
	_header - The first row of the table describing the content of the column <ARRAY>
	_content - The rows <ARRAY>
Returns:
	_return - Wiki table <STRING>
Examples:
	(begin example)
		_return = [["head1", "head2"], [["content1", "content2"], ["content3", "content4"]]] call BIKI_fnc_arrayToTable;
		// ==>
		// {| class="wikitable"
		// |-
		// ! head1 !! head2
		// |-
		// | content1 || content2
		// |-
		// | content3 || content4
		// |}
	(end)
Author:
	Terra
---------------------------------------------------------------------------- */
params ["_header", "_content"];
_header = _header apply {[str _x, _x] select (_x isEqualType "")};
_content = _content apply {_x apply {[str _x, _x] select (_x isEqualType "")}};
private _return = ["{| class=""wikitable"""];
private _fnc_newLine = {
};

_return append ["|-", "! " + (_header joinString " !! ")];
// [
//  [test, test2, test3],
//  [test, test4, test5],
// ]
{
	_return append ["|-", "| " + (_x joinString " || ")]
} forEach _content;
_return pushBack "|}";
_return joinString endl
