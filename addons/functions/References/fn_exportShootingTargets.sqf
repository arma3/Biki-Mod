/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportShootingTargets
Description:
	Generates a table with all vehicle classes that can be used as target
	practice.
	https://community.bistudio.com/wiki/Arma_3:_Shooting_Targets
Parameters:
	none
Returns:
	nil
Examples:
	(begin example)
		_nil = [] call BIKI_fnc_exportShootingTargets;
	(end)
Author:
	R3vo
---------------------------------------------------------------------------- */
popUpTargets = "{| class=""wikitable""
|-
! Display Name !! Class !! Animation Sources";

{
	private _anims = "true" configClasses (_x >> "AnimationSources");
	if (_anims isNotEqualTo []) then
	{
		private _animsStr = "";
		{
			_animsStr = _animsStr + "{{hl|" + configName _x + "}}" + "<br>" + endl;
		} forEach _anims;
		popUpTargets = popUpTargets + endl + "|-" + endl + "| " + getText (_x >> "displayName") + " || " + "{{hl|" + configName _x + "}}" + " || " + endl + _animsStr;
	};
} forEach ("getNumber (_x >> 'scope') > 1 && getText (_x >> 'editorSubcategory') == 'EdSubcat_Targets'" configClasses (configfile >> "CfgVehicles"));

copyToClipboard (popUpTargets + endl + "|}");
