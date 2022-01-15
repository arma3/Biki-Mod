/* ----------------------------------------------------------------------------
Function: BIKI_fnc_exportDLCRestrictions
Description:
	Generates a table with all CfgVehicles classes that requre a DLC to be used.
	https://community.bistudio.com/wiki/Arma_3:_DLC_Restrictions
Parameters:
	none
Returns:
	nil
Examples:
	(begin example)
		_nil = [] call BIKI_fnc_exportDLCRestrictions;
	(end)
Author:
	POLPOX
---------------------------------------------------------------------------- */
//Use unicode to prevent export error
forceUnicode 0 ;

//0: personal equipments 1: vehicles
private _mode = 0 ;

//Create hashmap to check looked models
private _lookedModels = createHashMap ;

//Get classes
private "_classes" ;
if (_mode == 0) then {
	//Get weapons, equipments, glasses, bags (in CfgVehicles)
	_classes = ("
		getNumber (_x >> 'scope') == 2 and
		[configName _x] call BIS_fnc_baseWeapon == configName _x and
		getNumber (_x >> 'type') != 65536 and
		!('UnknownEquipment' in (configName _x call BIS_fnc_itemType))
	" configClasses (configFile >> "CfgWeapons")) +
	("getNumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgGlasses"))	+
	("getNumber (_x >> 'scope') == 2 and configName _x isKindOf 'Bag_Base'" configClasses (configFile >> "CfgVehicles")) ;
} ;
if (_mode == 1) then {
	//Get vehicles, except Men
	_classes = ("
		getNumber (_x >> 'scope') == 2 and
		(configName _x isKindOf 'AllVehicles' and
		!(configName _x isKindOf 'Man'))
	" configClasses (configFile >> "CfgVehicles")) ;
} ;

private _data = _classes apply {
	private _class = configName _x ;
	private _model = toLower (call {
		//Check if the thing is a uniform
		if ((getNumber (_x >> "itemInfo" >> "type")) == 801) exitWith {
			getText (_x >> "itemInfo" >> "uniformClass")
		} ;
		
		//Normalize model path to prevent errors
		private _split = (getText (_x >> "model") splitString "\") ;
		if ((count _split >= 2) and {!(".p3d" in toLower (_split#(count _split-1)))}) then {
			_split set [count _split -1,(_split#(count _split-1)) + ".p3d"] ;
		} ;
		(_split joinString "\")
	}) ;
	
	//Get DLC info per items
	if (isNil {_lookedModels get _model}) then {
		systemChat _class ;
		
		//Create a simple object and check the DLC via getObjectDLC
		private _obj = createSimpleObject [_model,[0,0,0]] ;
		private _dlc = getObjectDLC _obj ;
		
		//And remove the object. bye-bye
		deleteVehicle _obj ;
		
		//If it is a part of the base game, -1, otherwise DLC id
		if (isNil "_dlc") then {
			_lookedModels set [_model,-1] ;
			[_x,-1]
		} else {
			_lookedModels set [_model,_dlc] ;
			[_x,_dlc]
		} ;
	} else {
		//Skip the generation if the model is already checked
		systemChat ("simple object generate skipped: " + _class) ;
		[_x,_lookedModels get _model]
	} ;
} ;

//Return value preparation
private _return = [
	'{| class="wikitable sortable"',
	'|-'
] ;

if (_mode == 0) then {
	_return pushBack '!Type'
} else {
	_return pushBack '!Faction'
} ;

_return append [
	'!classname',
	'!displayName',
	'!Icon',
	'!Restricted?'
] ;

//Code to convert things to things
private _IDtoDLC = {
	switch _this do {
		case 275700: {"arma3zeus"} ;
		case 288520: {"arma3karts"} ;
		case 304380: {"arma3helicopters"} ;
		case 332350: {"arma3marksmen"} ;
		case 395180: {"arma3apex"} ;
		case 571710: {"arma3lawsofwar"} ;
		case 601670: {"arma3jets"} ;
		case 612480: {"arma3malden"} ;
		case 744950: {"arma3tacops"} ;
		case 798390: {"arma3tanks"} ;
		case 1021790: {"arma3contact"} ;
		case 1325500: {"arma3artofwar"} ;
		default {""} ;
	} ;
} ;
private _DLCToName = {
	switch _this do {
		case "arma3zeus": {"Zeus"} ;
		case "arma3karts": {"Karts"} ;
		case "arma3helicopters": {"Helicopters"} ;
		case "arma3marksmen": {"Marksmen"} ;
		case "arma3apex": {"Apex"} ;
		case "arma3lawsofwar": {"Laws of War"} ;
		case "arma3jets": {"Jets"} ;
		case "arma3malden": {"Malden"} ;
		case "arma3tacops": {"Tac-Ops"} ;
		case "arma3tanks": {"Tanks"} ;
		case "arma3contact": {"Contact"} ;
		case "arma3artofwar": {"Art of War"} ;
		default {""} ;
	} ;
} ;
private _MODtoDLC = {
	switch toLower _this do {
		case "curator": {"arma3zeus"} ;
		case "kart": {"arma3karts"} ;
		case "heli": {"arma3helicopters"} ;
		case "mark": {"arma3marksmen"} ;
		case "expansion": {"arma3apex"} ;
		case "orange": {"arma3lawsofwar"} ;
		case "jets": {"arma3jets"} ;
		case "argo": {"arma3malden"} ;
		case "tacops": {"arma3tacops"} ;
		case "tank": {"arma3tanks"} ;
		case "enoch": {"arma3contact"} ;
		case "aow": {"arma3artofwar"} ;
		default {""} ;
	} ;
} ;

{
	_x params ["_class","_dlc"] ;
	private _dlcName = _dlc call _IDtoDLC ;
	_return pushBack "|-" ;
	
	//Make the BG red when is restricted
	private _BGCol = (call {if (_dlcName != "") exitWith {'style="background: #edd;"|'} ; ""}) ;
	
	//Categorize personal equipments
	if (_mode == 0) then {
		_return pushBack ("|" + _BGCol + call {
			if ((configHierarchy (_x#0))#1 == (configFile >> "CfgWeapons")) exitWith {
				#define IKO(typeClass)	(configName (_x select 0) isKindOf [typeClass,configFile >> "CfgWeapons"])
				_type = (configName (_x#0)) call BIS_fnc_itemType ;
				if (IKO("Rifle")) exitWith {"Rifle"} ;
				if (IKO("Pistol")) exitWith {"Pistol"} ;
				if (IKO("Launcher")) exitWith {"Launcher"} ;
				if (_type#1 == "GPS") exitWith {"Terminal"} ;
				if (_type#1 == "UAVTerminal") exitWith {"Terminal"} ;
				if (_type#1 == "AccessoryMuzzle") exitWith {"Muzzle Attachment"} ;
				if (_type#1 == "AccessorySights") exitWith {"Sight"} ;
				if (_type#1 == "AccessoryPointer") exitWith {"Rail Attachment"} ;
				if (_type#1 == "AccessoryBipod") exitWith {"Bipod"} ;
				if (_type#1 == "LaserDesignator") exitWith {"Binocular"} ;
				if (_type#1 == "NVGoggles") exitWith {"NVGs"} ;
				if (_type#1 == "Radio") exitWith {"Communication"} ;
				if (
					_type#1 == "FirstAidKit" or
					_type#1 == "Medikit" or
					_type#1 == "Toolkit" or
					_type#1 == "MineDetector"
				) exitWith {"Item"} ;
				_type#1
			} ;
			if ((configHierarchy (_x#0))#1 == (configFile >> "CfgGlasses")) exitWith {
				"Facewear"
			} ;
			if ((configHierarchy (_x#0))#1 == (configFile >> "CfgVehicles") and configName (_x#0) isKindOf "Bag_Base") exitWith {
				"Backpack"
			} ;
		}) ;
	} else {
		_return pushBack ("|" + _BGCol + getText (configfile >> "CfgFactionClasses" >> (getText (_class >> "faction")) >> "displayName")) ;
	} ;
	
	_return append [
		("|" + _BGCol + configName _class),
		("|" + _BGCol + getText (_class >> "displayName"))
	] ;;
	
	//DLC Icons
	private _MOD = call {
		private _return = "" ;
		//Emulate Arsenal icons
		if (_mode == 0) then {
			private _addon = (configSourceAddonList (_x#0)) ;
			private _MOD = configSourceMODList (configFile >> "CfgPatches" >> _addon#0) ;
			if (count _MOD > 0) then {
				_MOD = _MOD#0
			} else {
				_MOD = ""
			} ;
			_return = _MOD ;
		} ;
		//Emulate Eden Editor icons
		if (_mode == 1) then {
			private _MOD = (configSourceMODList (_x#0)) ;
			if (count _MOD > 0) then {
				_MOD = _MOD#0
			} else {
				_MOD = ""
			} ;
			_return = _MOD ;
		} ;
		_return
	} ;
	
	_return pushBack ("|" + _BGCol + (["",format ["{{Icon|%1|25}}",_MOD call _MODtoDLC]] select (_MOD != ""))) ;
	
	if (_dlcName == "") then {
		_return pushBack ("|" + "No") ;
	} else {
		_return pushBack ("|" + _BGCol + (_dlcName call _DLCToName)) ;
	} ;
} forEach _data ;

_return pushBack "|}" ;

//And finally done, use joinString to make line breaks and copy
copyToClipboard (_return joinString endl) ;
