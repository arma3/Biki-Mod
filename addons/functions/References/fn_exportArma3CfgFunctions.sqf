/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportArma3CfgFunctions
Description:
	Generates a table with all functions present in Arma 3 grouped by addon
	and category. Output is copied to clipboard.
	https://community.bistudio.com/wiki/Arma_3:_CfgFunctions
Parameters:
	none
Returns:
	nil
Examples:
	(begin example)
		_nothing = [] call BIKI_fnc_exportArma3CfgFunctions;
	(end)
Author:
	R3vo
---------------------------------------------------------------------------- */
private _export = [] call BIKI_fnc_lastUpdatedGVI + endl + "{| class=""wikitable sortable"" border=""1"" style=""border-collapse:collapse; font-size:100%;"" cellpadding=""0.5em""
! Group
! Category
! Functions";

{ // Config
	private _indexConfig = _forEachIndex;
	private _nameConfig = _x # 0;
	{ // Tags
		private _nameTAG = configName _x;
		private _valueTAG = getText (_x >> "tag");
		if (_valueTAG == "") then { _valueTag = configName _x };
		{ // Categories
			private _nameCategory = configName _x;
			_export = _export + endl + "|-" + endl + "!" + _nameTAG + endl + "!" + _nameCategory + endl + "|";
			private _pathCategory = getText (_x >> "file");
			{ // Functions
				private _prefix = ["BIS_fnc_", "BIN_fnc_"] select (_nameTAG in ["A3_Enoch", "A3_Contact"]);
				_export = _export + endl + ":[[" + _prefix + (configName _x) + "]]";
			} forEach ((_nameConfig >> "CfgFunctions" >> _nameTAG >> _nameCategory) call BIS_fnc_returnChildren);
		} forEach ((_nameConfig >> "CfgFunctions" >> configName _x) call BIS_fnc_returnChildren);
	} forEach ((_nameConfig >> "CfgFunctions") call BIS_fnc_returnChildren);
} forEach [[configFile, "configFile"]];

_export = _export + endl + "|}";
copyToClipboard _export;
