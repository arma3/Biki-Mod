/* ----------------------------------------------------------------------------
Function: BIKI_fnc_lastUpdatedGVI
Description:
	Returns a string that contains the Game Version Icon (GVI) for the current
	version.
Parameters:
	 none
Returns:
	_lastUpdated - A string with the GVI icon for the current version <STRING>
Examples:
	(begin example)
		_lastUpdated = [] call BIKI_fnc_lastUpdatedGVI;
		// ==> Last updated: {{GVI|arma3|2.06}}
	(end)
Author:
	R3vo, Terra
---------------------------------------------------------------------------- */
format ["Last updated: {{GVI|arma3|%1}}",productVersion # 2 / 100]
