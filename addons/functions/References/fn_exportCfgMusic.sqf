/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportCfgMusic
Description:
    Generates a table of the CfgMusic config.
    https://community.bistudio.com/wiki/Arma_3:_CfgMusic
Parameters:
    none
Returns:
    nil
Examples:
    (begin example)
        _nothing = [] call BIKI_fnc_exportCfgMusic;
    (end)
Author:
    Killzone_Kid
---------------------------------------------------------------------------- */
_cfgMusic = [];

_cfgMusic pushBack format ["Last updated: {{GVI|arma3|%1}}", (productVersion select 2) / 100];
_cfgMusic pushBack format ["{| class=""wikitable sortable"" width=""100%1""", "%"];
_cfgMusic pushBack format ["! width=""5%1"" |No.", "%"];
_cfgMusic pushBack format ["! width=""35%1"" |Title", "%"];
_cfgMusic pushBack format ["! width=""30%1"" |Class Name", "%"];
_cfgMusic pushBack format ["! width=""15%1"" |Duration", "%"];
_cfgMusic pushBack format ["! width=""15%1"" |DLC", "%"];
_cfgMusic pushBack "";
{
	private _name = getText (_x >> "name");
	private _duration = getNumber (_x >> "duration");
	_duration = round _duration;
	private _minutes = floor (_duration / 60);
	private _mod = _duration mod 60;
	private _seconds = _mod / 1;
	_minutesStr = if (_minutes < 10) then {format ["0%1",_minutes]} else {format ["%1",_minutes]};
	_secondsStr = if (_seconds < 10) then {format ["0%1",_seconds]} else {format ["%1",_seconds]};
	_duration = format ["%1:%2",_minutesStr,_secondsStr];
	private _dlc = if (configSourceMod _x == "") then
	{
		"Arma 3";
	}
	else
	{
		format ["%1",(modParams [configSourceMod _x,["name"]]) select 0];
	};
	//Some work around to make wiki link work
	if (_dlc isEqualTo "[[Arma 3 Contact (Platform)]]") then
	{
		_dlc = "Arma 3 Contact";
	};
	if (_dlc isEqualTo "[[Arma 3 Tac-Ops]]") then
	{
		_dlc = "[[Arma 3 Tac-Ops Mission Pack]]";
	};
	_cfgMusic pushBack "|-";
	_cfgMusic pushBack format ["| %1", _forEachIndex + 1];
	_cfgMusic pushBack format ["| %1", if (_name == "") then {"N/A"} else {_name}];
	_cfgMusic pushBack format ["| %1", configName _x];
	_cfgMusic pushBack format ["| %1", if (_duration == "00:00") then {"N/A"} else {_duration}];
	_cfgMusic pushBack format ["| %1", _dlc];
	_cfgMusic pushBack "";
} forEach ("isClass _x" configClasses (configFile >> "CfgMusic"));
_cfgMusic pushBack "|}";
copyToClipboard (_cfgMusic joinString toString[10]);
