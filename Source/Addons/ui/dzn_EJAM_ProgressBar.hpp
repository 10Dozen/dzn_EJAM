#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

class dzn_EJAM_ProgressBar_Group: RscControlsGroup
{
	idd = 134804;
	idc = 6500;
	x = 0 * GUI_GRID_W + GUI_GRID_X;
	y = 0 * GUI_GRID_H + GUI_GRID_Y;
	w = 40 * GUI_GRID_W;
	h = 19 * GUI_GRID_H;
	colorBackground[] = {0,0,0,0.75};

	class controls 
	{	
		
		class dzn_EJAM_Progress_BG: RscStructuredText
		{
			idc = 6503;
			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 38 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.25};
		};
		class dzn_EJAM_Progress_Bar: RscStructuredText
		{
			idc = 6502;
			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 1.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 0 * GUI_GRID_W;
			h = 0.8 * GUI_GRID_H;
			colorBackground[] = {0.77,0.51,0.08,0.8};
		};		
		class dzn_EJAM_Progress_Title: RscStructuredText
		{
			idc = 6501;
			text = ""; //--- ToDo: Localize;
			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 38 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {1,1,1,0};
		};
	};
};

