#include "..\script_component.hpp"
params ["_mode", "_params"];
diag_log _this;
switch _mode do {
	case "onLoad":{
		_params params ["_display"];
		private _ctrlFunctionsList = _display displayCtrl IDC_RSCDISPLAYBIKIHELP_FUNCTIONSLIST;
		{
			{
				private _fncName = format ["BIKI_fnc_%1", configName _x];
				private _fnc = missionNamespace getVariable _fncName;
				(_fncName call BIS_fnc_functionMeta) params ["_fileLocation"];
				private _fncContent = loadFile _fileLocation;
				diag_log [_fncName, _fileLocation];
				private _fncHeader = _fncContent
					regexFind ["\/\*\ -{76}.*-{76}\ \*\//", 0]
					param [0, []]
					param [0, []]
					param [0, ""]
					regexReplace ["\n/g", "<br/>"]
					regexReplace ["\t/g", "    "];
				private _yPos = 0;
				diag_log allControls _ctrlFunctionsList;
				{
					private _h = ctrlPosition _x select 3;
					_yPos = _yPos + _h + GRID_H;
				} forEach (allControls _ctrlFunctionsList);
				diag_log _yPos;
				private _ctrlHeader = _display ctrlCreate ["ctrlStructuredText", -1, _ctrlFunctionsList];
				_ctrlHeader ctrlSetPosition [
					1 * GRID_W,
					_yPos,
					(W_RSCDISPLAYBIKIHELP - 2) * GRID_W,
					1
				];
				_ctrlHeader ctrlCommit 0;
				_ctrlHeader ctrlSetStructuredText parseText format ["<t size='0.7' font='EtelkaMonospacePro'>%1</t>", _fncHeader];
				_ctrlHeader ctrlSetPositionH (ctrlTextHeight _ctrlHeader);
				_ctrlHeader ctrlCommit 0;
			} forEach ("true" configClasses _x);
		} forEach ("true" configClasses (configFile >> "CfgFunctions" >> "BIKI"));
	};
	case "onUnload":{
		_params params ["_display", "_exitCode"];
	};
};
