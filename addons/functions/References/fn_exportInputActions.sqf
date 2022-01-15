/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportInputActions
Description:
	Exports the default keybindings to a BIKI table.
	https://community.bistudio.com/wiki/inputAction/actions
Parameters:
	none
Returns:
	nil
Examples:
	(begin example)
		_nil = [] call BIKI_fnc_exportInputActions;
	(end)
Author:
	POLPOX
---------------------------------------------------------------------------- */
_r = [] ;
{
	_r pushBack [getText (_x >> "name"),[]] ;
	_index = _forEachIndex ;
	{
		private _actionName = actionName _x ;
		(_r#_index#1) pushBack [_x,_actionName] ;
	} forEach getArray (_x >> "group") ;
} forEach ("true" configClasses (configFile >> "UserActionGroups")) ;

_rFinal = [
	'{| class="sortable wikitable"'
] ;

_presets = ("configName _x != 'Empty'" configClasses (configFile >> "CfgDefaultKeysPresets")) ;
_str = '! Type !! actionName !! Name' ;

{
	_str = _str + " !! " + getText (_x >> "displayName") ;
	if (getNumber (_x >> "default") == 1) then {
		_str = _str + "<br/>(Default)" ;
	} ;
} forEach _presets ;


_rFinal pushBack format ['! colspan="3"| Action information !! colspan="%1"| Presets',count _presets] ;
_rFinal pushBack "|-" ;
_rFinal pushBack _str ;

{
	_type = _x#0 ;
	{
		_rFinal pushBack "|-" ;
		_x params ["_actionName","_name"/*,"_tooltip"*/] ;
		if (_name isEqualTo "") then {
			_name = "{{n/a}}" ;
		} ;
		_str = format ["| %1 || {{hl|%2}} || %3 ",_type,_actionName,_name] ;
		{
			_keys = getArray (_x >> "Mappings" >> _actionName) ;
			if (count _keys != 0) then {
				_keys = _keys apply {
					call {
						if (typeName _x == "STRING") exitWith {
							keyName call compile _x ;
						} ;
						if (typeName _x == "ARRAY") exitWith {
							_r = [] ;
							{
								if (typeName _x == "STRING") then {
									_r pushBack ((keyName call compile _x) splitString """")#0 ;
								} ;
								_r pushBack ((keyName _x) splitString """")#0 ;
							} forEach _x ;
							_r = (_r joinString "+") ;
							_r
						} ;
						keyName _x
					} ;
				} ;
				_str = _str + format ["|| %1 ",(_keys joinString ", " splitString """")#0] ;
			} else {
				_str = _str + "|| " ;
			} ;
		} forEach _presets ;
		_rFinal pushBack _str ;
	} forEach (_x#1) ;
} forEach _r ;

_rFinal pushBack "|}" ;

copyToClipboard (_rFinal joinString endl) ;
