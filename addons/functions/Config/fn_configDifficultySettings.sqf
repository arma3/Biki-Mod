/* ----------------------------------------------------------------------------
Function: BIKI_fnc_configDifficultySettings
Description:
	Generates an example config for a CfgDifficultyPreset.
	https://community.bistudio.com/wiki/Arma_3:_Difficulty_Settings
Parameters:
	none
Returns:
	nil
Examples:
	(begin example)
		_nil = [] call BIKI_fnc_configDifficultySettings;
	(end)
Author:
	Killzone_kid
---------------------------------------------------------------------------- */
"debug_console" callExtension format ["class Difficulties"];

"debug_console" callExtension format ["{"];
_cfg = configFile >> "CfgDifficulties";
{
	_class = configName _x;
	"debug_console" callExtension format ["    class %1", _class];
	"debug_console" callExtension format ["    {"];
	"debug_console" callExtension format ["        class Flags"];
	"debug_console" callExtension format ["        {"];
	_flags = _cfg >> _class >> "Flags";
	_flagNames = [];
	for "_i" from 0 to count _flags - 1 do {
		_flag = _flags select _i;
		_flagNames pushBack configName _flag;
	};
	_flagNames sort true;
	{
		getArray (_flags >> _x) params ["_current", "_canChange"];
		if (_canChange == 1) then {
			"debug_console" callExtension format [
				"            %1 = %2;",
			_x, _current];
		} else {
			"debug_console" callExtension format [
				"            /* %1 = %2; - cannot be changed */",
			_x, _current];
		}
	} forEach _flagNames;
	"debug_console" callExtension format ["        };"];
	{
		"debug_console" callExtension format [
			"        %1 = %2;",
		_x, getNumber(_cfg >> _class >> _x)];
	} forEach [
		"precisionEnemy",
		"precisionFriendly",
		"skillEnemy",
		"skillFriendly"
	];
	"debug_console" callExtension format ["    };"];
} forEach ("true" configClasses _cfg);
"debug_console" callExtension format ["};"];
