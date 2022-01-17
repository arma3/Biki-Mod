#define COMPONENT ui
#include "\x\biki\addons\main\script_mod.hpp"

#define DEBUG_ENABLED_UI
#ifdef DEBUG_ENABLED_UI
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_UI
	#define DEBUG_SETTINGS DEBUG_SETTINGS_UI
#endif

#include "\x\biki\addons\main\script_macros.hpp"

#include "\a3\3den\UI\macros.inc"
#ifdef DEBUG_MODE_FULL
	#define MAINPREFIX p
	#define INIT_DISPLAY_FUNCTION (compileScript [QUOTE(PATHTOF(scripts\NAME.sqf))])
#endif

// Display coordinates
#define W_RSCDISPLAYBIKIHELP 140
#define H_RSCDISPLAYBIKIHELP (WINDOW_H - 10)
#define X_RSCDISPLAYBIKIHELP CENTER_X - 0.5 * W_RSCDISPLAYBIKIHELP * GRID_W
#define Y_RSCDISPLAYBIKIHELP CENTER_Y - 0.5 * H_RSCDISPLAYBIKIHELP * GRID_H

// IDDs and IDCs
#define IDC_RSCDISPLAYBIKIHELP_FUNCTIONSLIST 100
