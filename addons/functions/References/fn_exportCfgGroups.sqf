/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportCfgGroups
Description:
	Exports CfgGroups as a BIKI table.
	https://community.bistudio.com/wiki/Arma_3:_CfgGroups
Parameters:
	none
Returns:
	_result - The generated BIKI table <STRING>
Examples:
	(begin example)
		_result = [] call BIKI_fnc_exportCfgGroups;
	(end)
Author:
	Lou Montana
---------------------------------------------------------------------------- */
private _lines = [];

private _maxGroupWidth = 5;

private _groupSides = "true" configClasses (configFile >> "CfgGroups");

// _lines pushBack "{{TopMenu|" + (_groupSides apply { format ["%1", getText (_x >> "name")] } joinString "") + "}}";
_lines pushBack "{{TOC|horizontal|||y}}";

{	// side level
	if (_forEachIndex > 0) then {
		_lines pushBack "";
	};
	_lines pushBack "";
	_lines pushBack "== " + getText (_x >> "name") + " ==";
	_lines pushBack "";
	_lines pushBack "config: " + configName _x;
	_lines pushBack "";

	private _factions = "true" configClasses _x;
	{	// faction level

		_lines pushBack "=== " + getText (_x >> "name") + " ===";
		_lines pushBack "";
		_lines pushBack "config: " + configName _x;
		_lines pushBack "";
		_lines pushBack "{| class=""wikitable""";

		private _groupTypes = "true" configClasses _x;
		{	// groupType level

			private _groups = "true" configClasses _x;
			private _groupLines = ceil (count _groups / _maxGroupWidth);

			_lines pushBack "|- style=""vertical-align: top""";
			_lines pushBack "! style=""vertical-align: middle; white-space: pre""" + (["", format [" rowspan=""%1""", _groupLines]] select (_groupLines > 1)) + " | " + getText (_x >> "name");
			_lines pushBack "<div style=""font-weight: normal"">config: " + configName _x + "</div>";

			private _groupRow = 1;
			{	// group level
				_lines pushBack "| <div style=""white-space: pre"">'''" + getText(_x >> "name") + "'''<br>config: " + configName _x + "</div>";

				private _units = "true" configClasses _x;
				_lines pushBack "Composition:<div style=""" + (["", "columns: 2; "] select (count _units > 600 /* if needed */)) + "font-size: small"" class=""mw-collapsible mw-collapsed""><div style=""margin-right: 5em; padding-top: 1em"">";
				{
					_lines pushBack ("# " + getText (_x >> "vehicle"));

				} forEach _units;

				_lines pushBack "</div></div>";

				_groupRow = _groupRow + 1;
				if (_groupRow > _maxGroupWidth) then {
					_lines pushBack "|-";
					_groupRow = 1;
				}

			} forEach _groups;

			_lines pushBack "|-";

		} forEach _groupTypes;

		_lines pushBack "|}";

	} forEach _factions;

} forEach _groupSides;

_lines pushBack "";
_lines pushBack "";
_lines pushBack "";
_lines pushBack "";

private _result = _lines joinString endl;

copyToClipboard _result;
_result;
