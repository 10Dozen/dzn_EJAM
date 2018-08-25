
#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)


class dzn_EJAM_Config_Group: RscControlsGroup
{
	idd = 134802;
	idc = 6000;
	x = 0 * GUI_GRID_W + GUI_GRID_X;
	y = 1 * GUI_GRID_H + GUI_GRID_Y;
	w = 40 * GUI_GRID_W;
	h = 24 * GUI_GRID_H;
	colorBackground[] = {0,0,0,0.75};

	class controls
	{
		// -- Title, BG and Close btn
		class dzn_EJAM_Config_BG: IGUIBack
		{
			idc = 6001;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 24 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.75};
		};
		class dzn_EJAM_Config_TitleLabel: RscStructuredText
		{
			idc = 6002;
			text = "dzn EJAM Weapon Configurator"; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 34 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.77,0.51,0.08,0.8};
			font = "PuristaMedium";
		};
		class dzn_EJAM_Config_CloseBtn: RscButtonMenu
		{
			idc = 6003;
			text = "CLOSE"; //--- ToDo: Localize;
			x = 34 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;			
			font = "PuristaLight";
			onButtonClick = "closeDialog 2;";
		};

		// List box and search
		class dzn_EJAM_Config_ListFrame: RscFrame
		{
			idc = 6010;
			text = "Weapon"; //--- ToDo: Localize;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 15.5 * GUI_GRID_W;
			h = 23.5 * GUI_GRID_H;
			sizeEx = 1.1 * GUI_GRID_H;
		};
		class dzn_EJAM_Config_List: RscListbox
		{
			idc = 6011;
			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 20.5 * GUI_GRID_H;
		};
		class dzn_EJAM_Config_ListEdit: RscEdit
		{
			idc = 6012;
			text = "Filter..."; //--- ToDo: Localize;
			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 2.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,1};
		};

		// Weapon data
		class dzn_EJAM_Config_ImageLabel: RscStructuredText
		{
			idc = 6020;
			text = ""; //  "IMAGE";
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 4.5 * GUI_GRID_H;
		};
		class dzn_EJAM_Config_GunLabel: RscStructuredText
		{
			idc = 6021;
			text = ""; // "AK-74  (RHS)"
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		
		// Weapon Settings
		class dzn_EJAM_Config_JamLabel: RscStructuredText
		{
			idc = 6030;
			text = "Jam chance"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 9.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};		
		class dzn_EJAM_Config_Malfunction1Label: RscStructuredText
		{
			idc = 6031;
			text = "Feed failure"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10 * GUI_GRID_H + GUI_GRID_Y;
			w = 9.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class dzn_EJAM_Config_Malfunction2Label: RscStructuredText
		{
			idc = 6032;
			text = "Chamber failure"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 9.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class dzn_EJAM_Config_Malfunction3Label: RscStructuredText
		{
			idc = 6033;
			text = "Dud"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 9.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class dzn_EJAM_Config_Malfunction4Label: RscStructuredText
		{
			idc = 6034;
			text = "Extraction failure"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 9.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class dzn_EJAM_Config_Malfunction5Label: RscStructuredText
		{
			idc = 6035;
			text = "Ejection failure"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16 * GUI_GRID_H + GUI_GRID_Y;
			w = 9.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};

		// --- Sliders 
		class dzn_EJAM_Config_JamSlider: RscXSliderH
		{
			style = 1078;
			idc = 6040;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class dzn_EJAM_Config_Malfunction1Slider: RscXSliderH
		{
			idc = 6041;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class dzn_EJAM_Config_Malfunction2Slider: RscXSliderH
		{
			idc = 6042;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class dzn_EJAM_Config_Malfunction3Slider: RscXSliderH
		{
			idc = 6043;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class dzn_EJAM_Config_Malfunction4Slider: RscXSliderH
		{
			idc = 6044;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class dzn_EJAM_Config_Malfunction5Slider: RscXSliderH
		{
			idc = 6045;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		// --- Buttons
		class dzn_EJAM_Config_SaveBtn: RscButtonMenu
		{
			idc = 6050;
			text = "SAVE"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;	
			font = "PuristaLight";
		};
		class dzn_EJAM_Config_CopyBtn: RscButtonMenu
		{
			idc = 6051;
			text = "COPY"; //--- ToDo: Localize;
			x = 23.5 * GUI_GRID_W + GUI_GRID_X;
			y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;	
			font = "PuristaLight";
		};
		class dzn_EJAM_Config_ApplyBtn: RscButtonMenu
		{
			idc = 6052;
			text = "Paste"; //--- ToDo: Localize;
			x = 30.5 * GUI_GRID_W + GUI_GRID_X;
			y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;	
			font = "PuristaLight";
		};
		class dzn_EJAM_Config_ResetBtn: RscButtonMenu
		{
			idc = 6053;
			text = "Reset"; //--- ToDo: Localize;
			x = 30.5 * GUI_GRID_W + GUI_GRID_X;
			y = 22 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;	
			font = "PuristaLight";
		};

	};
};







