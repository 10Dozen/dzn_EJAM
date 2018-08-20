#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

class dzn_EJAM_Menu_Group: RscControlsGroup
{
	idd = 134802;
	idc = 6000;
	x = 0 * GUI_GRID_W + GUI_GRID_X;
	y = 0 * GUI_GRID_H + GUI_GRID_Y;
	w = 40 * GUI_GRID_W;
	h = 19 * GUI_GRID_H;
	colorBackground[] = {0,0,0,0.75};

	class controls 
	{
		// HEADER & BG
		class dzn_EJAM_Menu_BG: RscFrame
		{
			idc = 6001;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 19 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.75};
			style=0;
		};
		class dzn_EJAM_Menu_TitleLabel: RscStructuredText
		{
			idc = 6002;
			text = ""; //--- TITLE
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 34 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.77,0.51,0.08,0.8};
			font = "PuristaMedium";
		};
		class dzn_EJAM_Menu_CloseBtn: RscButtonMenu
		{
			idc = 6003;
			text = ""; //--- CLOSE
			x = 34 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			font = "PuristaLight";
		};
		

		// IMAGE
		class dzn_EJAM_Menu_ImageLabel: RscStructuredText
		{
			idc = 6010;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 14 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class dzn_EJAM_Menu_GunNameLabel: RscStructuredText
		{
			idc = 6011;
			text = ""; //--- AK-74
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
			font = "PuristaLight";
		};


		// STATES
		class dzn_EJAM_Menu_BoltLabel: RscStructuredText
		{
			idc = 6012;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			text = ""; //--- Bolt state
			colorBackground[] = {-1,-1,-1,0};
			font = "PuristaLight";
		};
		class dzn_EJAM_Menu_ChamberLabel: RscStructuredText
		{
			idc = 6013;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			text = ""; //--- Chamber state
			colorBackground[] = {-1,-1,-1,0};
			font = "PuristaLight";
		};
		class dzn_EJAM_Menu_MagazineLabel: RscStructuredText
		{
			idc = 6014;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			text = ""; //--- Magazine state
			colorBackground[] = {-1,-1,-1,0};
			font = "PuristaLight";
		};
		class dzn_EJAM_Menu_ExtractionLabel: RscStructuredText
		{
			idc = 6015;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			text = ""; //--- Extraction state
			colorBackground[] = {-1,-1,-1,0};
			font = "PuristaLight";
		};


		// BUTTONS
		class dzn_EJAM_Menu_PullBoltBtn: RscButtonMenu
		{
			idc = 6020;
			text = ""; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			font = "PuristaLight";
		};
		class dzn_EJAM_Menu_ChamberBtn: RscButtonMenu
		{
			idc = 6021;
			text = ""; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			font = "PuristaLight";
		};
		class dzn_EJAM_Menu_DetachMagazineBtn: RscButtonMenu
		{
			idc = 6022;
			text = ""; //--- ToDo: Localize;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			font = "PuristaLight";
		};
		class dzn_EJAM_Menu_OpenBoltBtn: RscButtonMenu
		{
			idc = 6023;
			text = ""; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			font = "PuristaLight";
		};
		class dzn_EJAM_Menu_ExtractionBtn: RscButtonMenu
		{
			idc = 6024;
			text = ""; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			font = "PuristaLight";
		};

		/*
		class dzn_EJAM_Menu_AttachMagazineBtn: RscButtonMenu
		{
			idc = 6025;
			text = ""; //--- ToDo: Localize;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			font = "PuristaLight";
		};

		*/
	};
};