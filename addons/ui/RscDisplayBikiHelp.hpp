#define W_DISPLAY W_RSCDISPLAYBIKIHELP
#define H_DISPLAY H_RSCDISPLAYBIKIHELP
#define X_DISPLAY X_RSCDISPLAYBIKIHELP
#define Y_DISPLAY Y_RSCDISPLAYBIKIHELP
class RscDisplayBikiHelp
{
	idd = -1;
	INIT_DISPLAY(RscDisplayBikiHelp,BIKI)
	class ControlsBackground
	{
		class BackgroundDisable: ctrlStaticBackgroundDisable{};
		class BackgroundDisableTiles: ctrlStaticBackgroundDisableTiles{};
		class Background: ctrlStaticBackground
		{
			x = X_DISPLAY;
			y = Y_DISPLAY;
			w = W_DISPLAY * GRID_W;
			h = H_DISPLAY * GRID_H;
		};
		class Title: ctrlStaticTitle
		{
			text = "Biki Mod";
			x = X_DISPLAY;
			y = Y_DISPLAY;
			w = W_DISPLAY * GRID_W;
			h = 5 * GRID_H;
		};
		class BackgroundButtons: ctrlStaticFooter
		{
			x = X_DISPLAY;
			y = Y_DISPLAY + H_DISPLAY * GRID_H - 7 * GRID_H;
			w = W_DISPLAY * GRID_W;
			h = 7 * GRID_H;
		};
	};
	class Controls
	{
		class IntroText: ctrlStructuredText
		{
			text = "Welcome to the Biki Mod! Below you can find a list of all available functions.";
			x = X_DISPLAY + 1 * GRID_W;
			y = Y_DISPLAY + 6 * GRID_H;
			w = (W_DISPLAY - 2) * GRID_W;
			h = 5 * GRID_H;
		};
		class FunctionsList: ctrlControlsGroupNoHScrollbars
		{
			idc = IDC_RSCDISPLAYBIKIHELP_FUNCTIONSLIST;
			x = X_DISPLAY + 1 * GRID_W;
			y = Y_DISPLAY + 12 * GRID_H;
			w = (W_DISPLAY - 2) * GRID_W;
			h = (H_DISPLAY - 20) * GRID_H;
		};
		class Close: ctrlButtonCancel
		{
			text = "Close";
			x = X_DISPLAY + (W_DISPLAY - 26) * GRID_W;
			y = Y_DISPLAY + (H_DISPLAY - 6) * GRID_H;
			w = 25 * GRID_W;
			h = 5 * GRID_H;
		};
	};
};
