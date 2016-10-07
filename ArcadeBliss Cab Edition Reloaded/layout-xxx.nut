///////////////////////////////////////////////////
//
// Attract-Mode Frontend - ArcadeBliss Cab Edition 
//
///////////////////////////////////////////////////

// 2016-08-15
// NEW: 
// TODO 
// - fix all genre images
// - create a start game menu with add favorite when >1 row is shown
// - fix the menu not changing to remove favorite after chossing a game to make favorite
// - change parts of the conveyour module to use for the choice of displays or filters
//			a. spoof the values to be entered in the on_transition function
//			b. VAR = have the filter index_offset work similar to the games index_offset	
//			c. VAR = have the display index_offset work similar to the games index_offset
// - gamelist slots are located in m_objs, remove reference to "my_array" to optimize this layout


/////////////////////////////////////
//
//  User Modifiable Display Settings
//
/////////////////////////////////////
	class UserConfig {

	</ label="Game List Artwork", help="The artwork to show in the games list", options="marquee,flyer,logo,snap,fanart", order=5 />
	g_art = "marquee";
		
	</ label="Background Artwork", help="The artwork to show in the background", options="snap,fanart,file, none", order=6 />
	bg_art = "fanart";
	
	</ label="Game List Artwork Aspect Ratio", help="Should the artwork be streched?", options="On,Off", order=9 />
	g_aspect = "On";
	
	</ label="Game List Row Count", help="The number of rows shown in the game list", options="1,2,3,4", order=9 />
	g_rows = "3";
	
	</ label="Game List Column Count", help="The number of columns shown in the game list", options="1,2,3,4,5,6,7,8", order=9 />
	g_cols = "4";		
	
	</ label="Favorite Icon Type", help="Show which favorite icon should be should on non favorite filters", options="None,Solid,Wireframe", order=10 />
	favicon = "Solid";
	
	</ label="Menu Sounds Active", help="Set to No to deactivate menu sounds", options="Yes,No", order=11 />
	sound = "Yes";
	
	</ label="Menu Red Channel Color", help="Configure the opaqueness of the overlay", options="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255", order=12 />
	ui_red = "255";
	
	</ label="Menu Green  Channel Color ", help="Configure the opaqueness of the overlay", options="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255", order=12 />
	ui_green = "165";
	
	</ label="Menu Blue  Channel Color ", help="Configure the opaqueness of the overlay", options="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255", order=12 />
	ui_blue = "0";
	
	</ label="Always Search Using 'All' Filter", help="If set to yes, the search menu will change the filter to 'All' before searching", options="Yes,No", order=13 />
	search = "Yes";
	
	</ label="Game Logo Artwork", help="The artwork to display above the game information", options="logo,snap,marquee,flyer", order=4 />
	logo = "logo";

	</ label="Game Flyer Artwork", help="The artwork to display next to the game logo artwork", options="logo,snap,marquee,flyer", order=4 />
	flyer = "flyer";
	
	</ label="Game Name Lower Third", help="Show the game name under the game", options="Yes,No", order=7 />
	show_name = "Yes";
	
	</ label="Transition Time", help="The amount of time (in milliseconds) that it takes to scroll to another grid entry", order=9 />
	ttime = "175";
	
	</ label="Game List Artwork Bloom", help="Add a highlight effect to the select game", options="Yes,No", order=2 />
	gl_shader = "Yes";
	
	</ label="Background Artwork Blur", help="Add a blur effect to the configured background", options="Yes,No", order=2 />
	bg_blur = "Yes";
	
	</ label="Game List Padding", help="Amount of padding to put between each game list item", options="1,2,3,4,5,6,7,8,9,10", order=2 />
	padding = "4";
	
	}

////////////////////////////////
//
//  Layout Settings
//
////////////////////////////////	
	
	// How it is meant to be viwed
	fe.layout.preserve_aspect_ratio = true;
	fe.layout.width = 800;
	fe.layout.height = 600;	

	// Load necessary modules
	fe.load_module( "conveyor" );
	fe.load_module( "fade" );
	fe.load_module( "animate");
		
	// Set up variables 
	local layout_config = fe.get_config();

	local scr_w = fe.layout.width; 	// current screen width
	local scr_h = fe.layout.height; // current screen height
	
	const ENLARGE = 0.15; // enlargement factor for for gamelist items						

	local bg_surface = null; // background image for the fade effect
	local bg_img = null; // background image 
	local bg_shaderH = null; // background horizontal blur shader 
	local bg_shaderV = null; // background vertical blur shader

	local ui_red = layout_config["ui_red"].tointeger();
	local ui_blue = layout_config["ui_blue"].tointeger(); 
	local ui_green = layout_config["ui_green"].tointeger();
	
	local clock_time = null; //updates the time

	// make the layout aspect aware
	//	create 3 tables
	//	1. settings table // used in the fe.image and co. functions
	//  2. default settings table // contains all settings
	//	3. serval aspect specific tables with a subset of settings
	//		
	//	The settings table is set to the current layout aspect e.g. settings table = aspect specific table
	//	The default settings is made a delegate of the settings table e.g. settings.setdelegate(aspect specific table)
	//  When using the settings table, any key that is not in the settings table will be fetched from the defaults table
	//  Fix the slight shift of the game item after it moves 
	

	// x,y,w,y for objects in the layout
	local deflt = {
		
		font = "BebasNeue",
		gl_width = scr_w / 1.028277635,
		gl_height = scr_h / 2.54237288,
		gl_startpostion = scr_h / 10.909090909,
		lbl_fontsize = scr_h / 33.333333333,
		nor_fontsize = scr_h / 23.076923077,
		// ------- header setup --------
		clk_i = { x = scr_w / 1.122019636, y = scr_h / 66.666666667, w = scr_w / 36.363636364, h = scr_h / 27.272727273 },
		clk_t = { x = scr_w / 1.100412655, y = scr_h / 120, w = scr_w / 8, h = scr_h / 20.689655172 },
		mdpy_i = { x = scr_w/2 - ((scr_w / 8)/2), y = scr_h / 120, w = scr_w / 8, h = scr_h / 17.689655172 },
		gl_t = { x = scr_w / 200, y = scr_h / 120, w = scr_w / 4, h = scr_h / 20.689655172 },
		// ------- menu arrows --------
		ra_i = { x = scr_w /   1.085481683, y = scr_h / 1.941747573 - ((scr_h / 10.90909091 - scr_h / 15.384615385)/2), w = scr_w / 14.545454546, h = scr_h / 10.90909091 },
		la_i = { x = scr_w / 114.285714286, y = scr_h / 1.941747573 - ((scr_h / 10.90909091 - scr_h / 15.384615385)/2), w = scr_w / 14.545454546, h = scr_h / 10.90909091 },
		// ------- menu items --------
		srch_i = { x = 0, y = (scr_h / 15.384615385 - scr_h / 23.076923077)/2, w = scr_w / 11.428571429, h = scr_h / 23.076923077 },
		flt_i = { x = 0, y = (scr_h / 15.384615385 - scr_h / 23.076923077)/2, w = scr_w / 5.925925926, h = scr_h / 23.076923077 },
		dply_i = { x = 0, y = (scr_h / 15.384615385 - scr_h / 23.076923077)/2, w = scr_w / 5.263157895, h = scr_h / 23.076923077 },
		fav_i = { x = 0, y = (scr_h / 15.384615385 - scr_h / 23.076923077)/2, w = scr_w / 6.34920635, h = scr_h / 23.076923077 },
		// ------- menu background --------
		mbkgrd_s = {x = 0, y = scr_h / 1.941747573, w = scr_w, h = scr_h / 15.384615385 },
		mbkgrd_i = { x = 0, y = 0, w = scr_w / 0.966183575, h = scr_h / 15.384615385 },
		// ------- game info surfaces --------
		gi_surface = { x = 0, y = scr_h / 1.724137931, w = scr_w, h = scr_h / 2.380952380 },
		gi_subsurface = { x = 0, y = scr_h / 2.380952380 / 1.431818181, w = scr_w, h = scr_h / 7.894736842 },
		// ------- game info labels --------
		ylbl_t =  { x = scr_w / 7.547169812,  y = scr_h / 7.894736842 / 25.3, w = scr_w / 5.333333334, h = scr_h / 27.272727272 },
		plbl_t =  { x = scr_w / 3.755868545,  y = scr_h / 7.894736842 / 25.3, w = scr_w / 5.333333334, h = scr_h / 27.272727272 },
		glbl_t =  { x = scr_w / 2.5,  		  y = scr_h / 7.894736842 / 25.3, w = scr_w / 5.333333334, h = scr_h / 27.272727272 },
		holbl_t = { x = scr_w / 1.8735363,    y = scr_h / 7.894736842 / 25.3, w = scr_w / 5.333333334, h = scr_h / 27.272727272 },
		tplbl_t = { x = scr_w / 1.498127341,  y = scr_h / 7.894736842 / 25.3, w = scr_w / 5.333333334, h = scr_h / 27.272727272 },
		// ------- game info --------
		year_t =   { x = scr_w / 7.547169812, y = scr_h / 7.894736842 / 3.04 , w = scr_w / 5.333333334, h = scr_h / 14.634146341 },
		plyr_t =   { x = scr_w / 3.755868545, y = scr_h / 7.894736842 / 3.04, w = scr_w / 5.333333334, h = scr_h / 14.634146341 },
		genre_i =  { x =  scr_w / 2.5 + ((scr_w / 5.333333334 - scr_w / 13.333333333)/2), y = scr_h / 7.894736842 / 4.222222222, w = scr_w / 13.333333333,  h = scr_h / 10 },
		tplyd_t =  { x = scr_w / 1.8735363,   y = scr_h / 7.894736842 / 3.04, w = scr_w / 5.333333334, h = scr_h / 14.634146341 },
		hrsply_t = { x = scr_w / 1.498127341, y = scr_h / 7.894736842 / 3.04, w = scr_w / 5.333333334, h = scr_h / 14.634146341 },
		// ------- game info emulator, manufacture images--------
		mlogo_i = { x =  scr_w / 160, y = scr_h / 7.894736842 / 7.6, w = scr_w / 6.956521739, h = scr_h / 11.111111112 },
		emulogo_i = { x = scr_w / 1.176470588, y = scr_h / 7.894736842 / 7.6, w = scr_w / 6.9565217393, h = scr_h / 11.111111112 },
		// ------- game flyer, name, logo --------
		gname_t = { x = scr_w / 2.439024391, y = (scr_h / 2.380952380) / 2.4, w = scr_w / 3.162055336, h = scr_h / 20.689655172 },
		glogo_i = { x = scr_w / 2.439024391, y = (scr_h / 2.380952380) / 16.8, w = scr_w / 3.187250997, h = scr_h / 7.407407408 },
		flyr_i = { x = scr_w / 4.040404041, y = (scr_h / 2.380952380) / 50.4, w = scr_w / 7.207207208, h = scr_h / 3.592814372 }
	}
	
	// place logic to determine screen aspect ratio here
	local settings = deflt;	
	
	
	// menu setup
	menu <- {};
	local activeMenu = "";
	
	
	// gamelist variables
	local gl_item_p = layout_config["padding"].tointeger(); // padding to be used between each gamelist item
	local gl_cols = layout_config["g_cols"].tointeger(); // Total number of gamelist columns
	local gl_rows = layout_config["g_rows"].tointeger(); // Total number of gamelist rows
	local gl_item_h = settings.gl_height / gl_rows.tofloat();	// Total gamelist height + distribute equal sized game lists items depending on how many rows exist
	local gl_item_w = settings.gl_width / gl_cols.tofloat(); // Total gamelist width + distribute equal sized game lists items depending on how many colums exist
	local gl_aspect = ( layout_config["g_aspect"] == "On" ); // keep game list item artwork aspect ratio
	local sel_frame_w = ((gl_item_w) + (gl_item_w * ENLARGE))+4;  // set the size of the frame larger than the snaps; 						
	local sel_frame_h  = ((gl_item_h) + (gl_item_h * ENLARGE))+4; // set the size of the frame larger than the snaps; 

/////////////////////////////////
//
//	Set up the Gamelist Object
//
/////////////////////////////////

	// Create positions for all of the layout items that will 
	// need to change with the selection of the current selection 
	class Grid extends Conveyor
	{
		// used to set the index offset to the item under the cursor selection
		
		surface = null; // surface to hold all of the game informaiton and artwork
		surface_y = null; // holds original surface height for animations
		sub_surface = null; // surface to hold just the game information
		g_name_txt=null; // selected game name 
		g_logo_img= null; // selected game logo image 
		g_list_txt = null; // gamelist [filter]: [selected game number] / [total games]
		g_year_txt = null; // selected game release year
		g_plyrs_txt = null; // selected game number of players
		g_genre_img = null; // selected game genre
		g_played_txt = null; // selected game number of times played
		g_time_txt = null; // selected game total playing time
		g_man_img = null; // selected game manufacturs image
		g_emu_img = null; // selected game emulator image
		g_flyer_img = null; 	// selected game flyer image
		
		// frame selection box settings 
		ui_frame_img = null; // the selection frame
		ui_sel_x = null; // x-coordinate of the frame
		ui_sel_y = null; // y-coordinate of the frame
		
		// Misc. Settings
		my_array = null; 	// the array contanining the slots
		num_i = null; 		// the index of the current conveyour slot
		ui_click = null; 	// toggle navigation click sound 
		gl_startpostion = null; // starting y position of the game list
		gl_item_h = null; 	// game list item height
		gl_item_p = null; 	// game list item padding
		gl_height = null; 	// height of the gamelist
		gl_width = null; 	// width of the gamelist

		// navigational things
		name = null; 		// name of the current menu
		nav_down = null; 	// the menu to navigate to based on navigation settings
		nav_up = null; 	//  "" "" "" "" ""
		nav_left = null; 	//  "" "" "" "" ""
		nav_right = null; 	//  "" "" "" "" ""
		nav_back = null; 	//  "" "" "" "" ""
		nav_change = null;  // flag to see if menu should change
		nav_change_to = null; // menu to change to when necessary
		
		// Conveyour settings
		transition_ms = null; // base frame animation speed
		stride = null; // determine how many games to skip when fast navigation is active
		
		constructor()
		{
			ui_sel_x = gl_cols / 2;
			ui_sel_y = gl_rows / 2;
			stride = fe.layout.page_size = gl_rows;
			transition_ms = layout_config["ttime"].tointeger();
			nav_change = false;
			base.constructor();			
		}
		
		function update_frame()
		{		
			local click = fe.add_sound("assets/sounds/selectclick.mp3"); // load wheel click sound
			click.playing = ui_click; // play the navigation click if configured 
			
			
			
			// Movement Animation for the frame
			animation.add( PropertyAnimation( ui_frame_img, 
				{   
					property = "position",
					tween = Tween.Linear, 
					end = { 
						x = (gl_item_w * ui_sel_x) + ((scr_w - gl_width)  / 2) - ((sel_frame_w - (gl_item_w))/2) + (gl_item_p /2), 
						y = (gl_item_h * ui_sel_y) + (gl_startpostion)         - ((sel_frame_h - (gl_item_h))/2) + (gl_item_p * ui_sel_y)
					}, 
					time = transition_ms
				} ) );
				
			// Update all of the text and artwork info with currently selected game	
			g_name_txt.index_offset =
			g_logo_img.index_offset = 
			g_list_txt.index_offset = 
			g_year_txt.index_offset = 
			g_plyrs_txt.index_offset = 
			g_genre_img.index_offset = 
			g_played_txt.index_offset = 
			g_time_txt.index_offset = 
			g_man_img.index_offset = 
			g_emu_img.index_offset = get_sel() - selection_index;
			
		}
		
		function do_correction()
		{
			local corr = get_sel() - selection_index;
			foreach ( o in m_objs )
			{
				local idx = o.g_art_img.index_offset - corr;
				o.g_art_img.rawset_index_offset( idx );
			}
		}
		
		function activate()
		{
			my_array[get_sel()].grow()
			ui_frame_img.zorder = my_array[get_sel()].gl_item_sur.zorder +1;
			ui_frame_img.alpha = 255;
		}
		
		function deactivate()
		{
			my_array[get_sel()].shrink()
			ui_frame_img.alpha = 0;
		}
		// get the current position of the frame (is the same index for the snap under the frame)
		function get_sel()
		{	
			return ( ui_sel_y * gl_cols + ui_sel_x );
		}
		
		function selected_game()
		{
			return get_sel() - selection_index
		}
		
		// logic used to move the frame
		function move_frame( direction )
		{
		
			switch ( direction )	
			{
			case "left":
				if ( ui_sel_x > 0 ) 
				{
					my_array[get_sel()].shrink();
					ui_sel_x--;
					update_frame();
					my_array[get_sel()].grow();
					ui_frame_img.zorder = my_array[get_sel()].gl_item_sur.zorder +1;
				}
				else
				{
					transition_swap_point=0.0;
				//	do_correction();
				//	fe.signal( "prev_page" );
					update_frame();
					return false;
				}
				
				return true;
				break;
				
			case "right":
				if ( ui_sel_x < gl_cols - 1 ) 
				{
					my_array[get_sel()].shrink();
					ui_sel_x++;
					update_frame();
					my_array[get_sel()].grow();
					ui_frame_img.zorder = my_array[get_sel()].gl_item_sur.zorder +1;
				}
				else
				{					
					transition_swap_point=0.0;
				//	do_correction();
				//	fe.signal( "next_page" );
					return false;
					update_frame();
				}
				
				return true;
				break;
				
			case "up":
				transition_swap_point=0.0;
				if ( ui_sel_y > 0 ) 
				{
					my_array[get_sel()].shrink();
					ui_sel_y--;
					update_frame();
					my_array[get_sel()].grow();
					ui_frame_img.zorder = my_array[get_sel()].gl_item_sur.zorder +1;
				}
				else
				{
					nav_change = true;
					nav_change_to = nav_up;
					return false;
				}
				return true;
				break;
				
			case "down":
				transition_swap_point=0.0;
				if ( ui_sel_y < gl_rows - 1 ) 
				{
					my_array[get_sel()].shrink();
					ui_sel_y++;
					update_frame();
					my_array[get_sel()].grow();
					ui_frame_img.zorder = my_array[get_sel()].gl_item_sur.zorder +1;
				}
				else
				{
					nav_change = true;
					nav_change_to = nav_down;
					return false;
				}
				return true;
				break;
				
			case "back":					
				nav_change = true;
				nav_change_to = nav_down;
				return false;
				break;
				
			case "select":
			
				reset_index();
				break;
			

			}
			
			// return the selected index offset of the current frame
			return false;
		}
		function reset_index()
		{
				// Correct the list index if it doesn't align with
				// the game our frame is on
				//
				enabled=false; // turn conveyor off for this switch
				local frame_index = get_sel();
			
				fe.list.index += frame_index - selection_index;

				set_selection( frame_index );
				update_frame();
				
				enabled=true; // re-enable conveyor
		
		}
		function set_slots( objs, sel_index=-1 )
		{
			if ( sel_index < 0 )
				selection_index = objs.len() / 2;
			else
				selection_index = sel_index;

			m_objs = [];

			for ( local i=0; i<objs.len(); i++ )
			{
				m_objs.push( objs[i] );
				m_objs[i].m_base_progress = i.tofloat() / objs.len();

				m_objs[i].m_base_io = i - selection_index;

				m_objs[i].reset_index_offset();
				
				//animate the items for the initail_setup
				m_objs[i].initial_load_setup( m_objs[i].m_base_progress, 0 ); // comment to remove animation
				//m_objs[i].on_progress( m_objs[i].m_base_progress, 0 ); // uncomment to remove animation
			}
		}
		
		function on_transition( ttype, var, ttime )
		{
			
			switch ( ttype )
			{
			case Transition.StartLayout:
			case Transition.FromGame:
				ui_frame_img.alpha = 255;
				break;

			case Transition.ToGame:
			case Transition.EndLayout:
				
				ui_frame_img.alpha = 0;

				break;
			}

			return base.on_transition( ttype, var, ttime );
		}
		function hide_gameinfo()
		{

			animation.add( PropertyAnimation( surface,
				{   
					property = "y",
					tween = Tween.Expo,
					easing = Easing.Out,
					end = scr_h + 1
					time = 600,
				} ) );
		}
		
		function show_gameinfo()
		{
		
		// create squeeze in animate for the menu
		animation.add( PropertyAnimation( surface,
			{   
				property = "y",
				tween = Tween.Expo,
				easing = Easing.Out,
				end = surface_y,
				time = 600,
			} ) );		
		
		}
	}
	
////////////////////////////////
//
//  Setup Conveyour Slots
//
////////////////////////////////
	class MySlot extends ConveyorSlot
	{
		
		g_art_img = null; 			// object's artwork to use for the gamelist
		g_bg_img= null; 			// object's game text background found underneath the game artwork (optional)
		g_name_txt=null; 			// object's game name  
		sel_status = null; 			// toggle "currently selected" flag for this object
		g_bloomActive = null;		// toggle the bloom effect for this object
		g_bloomOn = null; 			// Bloom settings when on
		g_bloomOff = null; 			// Bloom settings when off
		gl_item_p = null;			// Padding to place between each game list item
		gl_startpostion = null;		// starting y position of the game list
		gl_height = null;			// gamelist height
		gl_width = null; 			// gamelist width
		gl_item_h = null;			// gamelist item height
		gl_item_w = null;			// gamelist item width
		gl_item_sur = null;			// gamelist surface
		gl_item_zo = null; 			// current zorder of the object		
		num_i = null; 				// the index of the current conveyour slot 
		transition_ms = null; 		// conveyour speed
		favorite_img =  null;		// the favorite icon
		favorite_slot = null		// the slot to find the add / remove in the menu
		borderOn = false;			// flag to show game name border 
		m_shifted = false;
		
		constructor( num, gw, gh )
		{
			
			gl_item_h = gh;
			gl_item_w = gw;
			transition_ms = layout_config["ttime"].tointeger();
			
			num_i = num;
			sel_status = false; 
			g_bloomActive = false;
			
			// set the gamename correctly
			fe.add_transition_callback( this, "update_name" );

			g_bloomOn = fe.add_shader( Shader.Fragment, "assets/shaders/bloom_shader.frag" )
			g_bloomOn.set_texture_param("bgl_RenderedTexture");
			g_bloomOff = fe.add_shader( Shader.Empty, "assets/shaders/bloom_shader.frag" )
		
			base.constructor();
		}
		
		function initial_load_setup( progress, var )
		{
			if ( var == 0 )
			m_shifted = false;
			// coveyour is set to scroll horizontally
			local r = num_i / gl_cols;
			local c = num_i % gl_cols;

			if ( abs( var ) < gl_rows )
			{	
				animation.add( PropertyAnimation( gl_item_sur, 
				{   
					property = "position",
					tween = Tween.Linear,
					easing = Easing.In,
					start = {
						x = ((gl_width * ( progress * gl_rows - r ) +  ((scr_w - gl_width) / 2))+ gl_item_p),
						y = (scr_h * -1) + (r * gl_item_h) + (r * gl_item_p)
					},
					end = { 
						x = ((gl_width * ( progress * gl_rows - r ) +  ((scr_w - gl_width) / 2)) + gl_item_p),
						y = gl_startpostion + (r * gl_item_h) + (r * gl_item_p)
					}, 	
					time = transition_ms * 4
				} ) );										
			}
			
			(sel_status) ? g_art_img.video_flags = Vid.Default : Vid.NoAudio // turn on the artworks video sound if currently selected
		}
		
		function on_progress( progress, var )
		{
			if ( var == 0 )
				m_shifted = false;
		
			// //Vertical Flow (from grid script)
			// local r = num_i % gl_rows;
			// local c = num_i / gl_rows;

			// if ( abs( var ) < gl_rows )
			// {
				// gl_item_sur.x = c * gl_item_w + gl_item_p;
				// gl_item_sur.y = gl_startpostion
					// + gl_height * ( progress * gl_cols - c ) + gl_item_p;
			// }
			// else
			// {
				// local prog = ::menu["gamelist"].transition_progress;
				// if ( prog > ::menu["gamelist"].transition_swap_point )
				// {
					// if ( var > 0 ) c++;
					// else c--;
				// }

				// if ( var > 0 ) prog *= -1;

				// gl_item_sur.x = ( c + prog ) * gl_item_w + gl_item_p;
				// gl_item_sur.y = gl_startpostion + r * gl_item_h + gl_item_p;
			// }
		
			
			// coveyour is set to scroll horizontally
			local r = num_i / gl_cols;
			local c = num_i % gl_cols;
	
			if ( abs( var ) < gl_rows)
			{
				if (sel_status == true)
				{
					gl_item_sur.x = (((gl_width * ( progress * gl_rows - r ) +  ((scr_w - gl_width) / 2)) + gl_item_p)) - (gl_item_w * ENLARGE / 2);
					gl_item_sur.y = (gl_startpostion + (r * gl_item_h) + (r * gl_item_p)) - (gl_item_h * ENLARGE / 2);
				
				} else {
					gl_item_sur.x = ((gl_width * ( progress * gl_rows - r ) +  ((scr_w - gl_width) / 2)) + gl_item_p) ;
					gl_item_sur.y = gl_startpostion + (r * gl_item_h) + (r * gl_item_p);
				}

			}
			
			g_art_img.video_flags = (sel_status) ?  Vid.Default : Vid.NoAudio // turn on the artworks video sound if currently selected
			
		}
		
		// turn on/off the favorite icon
		function set_favorite()
		{	
			favorite_img.visible  = (fe.game_info(Info.Favourite, g_art_img.index_offset) == "1") ;
		}
		
		function preserveAspect(value)
		{
			g_art_img.preserve_aspect_ratio = value;
		}
		
		function activateBloom()
		{
			g_art_img.shader = (g_bloomActive && sel_status) ? g_bloomOn : g_bloomOff;
		}
		
		function swap( other )
		{
			
			g_art_img.swap( other.g_art_img );
		}

		function set_index_offset( io )
		{
			g_art_img.index_offset = io;
		}

		function reset_index_offset()
		{
			g_art_img.rawset_index_offset( m_base_io ); 
		}
					
		// set game name
		function set_gametitle()
		{
			
			g_name_txt.msg = fe.game_info(Info.Title, g_art_img.index_offset);

		}
		function grow()
		{
			sel_status = true;
			activateBloom();
			gl_item_sur.zorder= gl_item_zo + ( gl_rows * gl_cols );
			animation.add( ScaleWidthHeight( this.gl_item_sur, 
			{   
				property = "scale",
				tween = Tween.Linear, 
				end = { 
					w = gl_item_w + (gl_item_w * ENLARGE), 
					h = gl_item_h + (gl_item_h * ENLARGE) 
				}, 
				time = transition_ms 
			} ) );
			
			return;
		}
		
		function shrink()
		{	
			sel_status = false;
			activateBloom();
			gl_item_sur.zorder = gl_item_zo;
			animation.add( ScaleWidthHeight( this.gl_item_sur, 
			{   
				property = "scale",
				tween = Tween.Linear, 
				end = { 
					w = gl_item_w - gl_item_p , 
					h = gl_item_h 
				}, 
				time = transition_ms 
			} ) );
			
			return;
		}
		
		// set favorite icon during after game transition
		function update_name(ttype, var, ttime)
		{
			switch ( ttype )
			{
				case Transition.ToNewList:
				case Transition.StartLayout:
				case Transition.FromOldSelection: // set the favorite icon
				{
					this.set_favorite();
					(borderOn) ? this.set_gametitle() : null;
					
				}
			}
				
			return false;
		}
	}

////////////////////////////////
//
//  Setup Main Menu Object
//
////////////////////////////////

	class arcadebliss_menu
	{

		
		
		// used to animate the menu items
		gamelist = null; // reference to the gamelist object
		
		//frame selection box settings
		ui_frame_img = null; // frame image
		ui_sel_x = null; // frame image position index / menu is horizontal only so no y is needed
		ui_click = null; // toggle navigation click sound 
			
		// Misc
		startpostion_y = null; // starting y position of the menu list
		item_h = null; // menu list item height
		item_p = null; // menu list item padding
		height = null; // height of the menu
		width = null;  // width of the menu
		new_x = null;  // x coordinate of the menu item during animation
		stride = null; // how many pixels to move the current menu item
		transition_ms = layout_config["ttime"].tointeger(); // how fast to move the menu
		
		// Menu Objects
		slot_names = null;	// name of the menu items in the slot
		slots = null; 		// container for all the menu item images
		active_item = null; // the current menu item under the cursor
		surface = null;		// the surface holding all menu items for animation
		r_arrow_i = null;	// menu arrow right
		l_arrow_i = null;	// menu arrow left
		favorite_slot = null;		// location of the favorite menu item
		
		
		// Navigation Variables
		name = null; 		// name of the current menu
		nav_down = null; 	// the menu to navigate to based on navigation settings
		nav_up = null; 		//  "" "" "" "" ""
		nav_left = null; 	//  "" "" "" "" ""
		nav_right = null; 	//  "" "" "" "" ""
		nav_back = null; 	//  "" "" "" "" ""
		nav_change = null;  //  flag to signal the current menu has been navigated away from
		nav_change_to = null // used to determine which menu to navigaton to after deactivation
		
		constructor()
		{
			slots = [];
			slot_names = [];
			stride = scr_w/4;
			new_x = stride;
			active_item = 1;
			
		}
		
		function move_frame(direction)
		{
			// animate the menu selection
			switch ( direction )	
			{
				case "left":
				case "right":
					update_frame(direction);
					return true;
					break;
					
				case "up":
				case "down":
					nav_change = true;
					nav_change_to = nav_up;
					return true;
					break;


				case "select":
				
					// open the current menu item
					// the game our frame is on
					menu_select();
					return true;
					break;
					
			
			}
			return false;
		}
		
		function menu_select()
		{
			// change the active menu to the one selected
			nav_change = true;
			nav_change_to = slot_names[active_item];
		}
		
		function update_frame(direction)
		{
			// determine how to move
			local i = 0;
			local index = null;
			local resting_spot = null;
			
			if (direction == "left")
			{
				// move all slots left
				index = (active_item + 1 == slots.len() ) ? 0 : active_item + 1
				
				while (i < 3)
				{
					// Loop thru the visible slots and move them to the right
					if (slots[index].x + stride + slots[index].width > scr_w)
						resting_spot = slots[index].width + scr_w
					else
						resting_spot = slots[index].x + stride
						
					animation.add( PropertyAnimation( slots[index], 
					{   
						property = "x",
						tween = Tween.Linear,
						end = resting_spot,
						time = transition_ms * 0.5,

					} ) );			
					i++;
					index--;
					if (index < 0 )
						index = slots.len()-1;
				
				}
				
				// move the 4th menu item offscreen to the left and animate it in
				animation.add( PropertyAnimation( slots[index], 
				{   
					property = "x",
					tween = Tween.Linear,
					start = 0 - slots[index].width,
					end = stride - (slots[index].width / 2),
					time = transition_ms  * 0.5,

				} ) );
				active_item--;
				if (active_item < 0)
				active_item = slots.len()-1;	
			
			} else {
				// move all slots right
				index = (active_item - 1 < 0 ) ? slots.len()-1 : active_item - 1
				
				while (i < 3)
				{
					// Loop thru the visible slots and move them to the left
					if (slots[index].x - stride < 0)
						resting_spot = 0 - slots[index].width
					else
						resting_spot = slots[index].x - stride
						
					animation.add( PropertyAnimation( slots[index], 
					{   
						property = "x",
						tween = Tween.Linear,
						end = resting_spot,
						time = transition_ms * 0.5,

					} ) );			
					i++;
					index++;
					if (index > slots.len()-1 )
						index = 0;
				
				}
				
				// move the 4th menu item offscreen to the right and animate it in
				animation.add( PropertyAnimation( slots[index], 
				{   
					property = "x",
					tween = Tween.Linear,
					start = scr_w + slots[index].width,
					end = (stride * 3 ) - (slots[index].width / 2),
					time = transition_ms  * 0.5,

				} ) );
				active_item++;
				if (active_item > slots.len()-1)
				active_item = 0;
			
			} 
		}
		
		function activate()
		{
			// only animate if the menu is not in its original spot
			if (surface.y !=settings.mbkgrd_s.y )
			{
				//animate menu up
				animation.add( PropertyAnimation( surface,
					{   
						property = "y",
						tween = Tween.Expo,
						easing = Easing.Out,
						end = settings.mbkgrd_s.y,
						time = 500,
					} ) );
				
				// animate gameinfo up
				gamelist.show_gameinfo();
				
				// show the menu arrows
				r_arrow_i.alpha = 255;
				l_arrow_i.alpha = 255;

				// tell the game list to navigate back to "main"
				gamelist.nav_up = gamelist.nav_down = "main"
				
			}
			
			// show the frame
			ui_frame_img.alpha = 255;
		}
		
		function deactivate()
		{
			// hide the frame
			ui_frame_img.alpha = 0;

			
			// only animate the menu if a menu item is chosen
			if ((nav_change == true) && (nav_change_to != "gamelist")) 
			{
				//hide the gamelist info
				gamelist.hide_gameinfo();
				
				// tell the gamelist to navigate back to "search" if active
				if (nav_change_to == "search")
				{
					gamelist.nav_up = gamelist.nav_down = "search"
				}
				
				//animate menu down
				animation.add( PropertyAnimation( surface, 
					{   
						property = "y",
						tween = Tween.Expo,
						easing = Easing.Out,
						end = scr_h - surface.height,
						time = 500,

					} ) );
				// hide menu arrows
				r_arrow_i.alpha = 0;
				l_arrow_i.alpha = 0;

			}
			
		}
		
		function toggle_fav()
		{
			local fav = (fe.game_info(Info.Favourite, gamelist.selected_game()) == "1");
			if (fav)
				slots[favorite_slot].file_name = "assets/UIelements/menu_remove_favorite.png";
			else
				slots[favorite_slot].file_name = "assets/UIelements/menu_add_favorite.png";
			
		}

		
		function add_item( item , value )
		{
			
			slots.push(item);
			slot_names.push(value);

			item.x = new_x - (item.width/2);

			//set the location of favorite so the image can be toggle when needed
			if (value = "favorite")
				favorite_slot = slot_names.len() -2;
			
			if (new_x + stride + item.width > scr_w)
				new_x = new_x + scr_w;
			else
				new_x = new_x + stride;	
		}
			
	}
	
//////////////////////////////////
//
// Setup Favorite Object
//
//////////////////////////////////
	class FavoriteMenu
	{
		name = null;
		nav_down = null; 	// the menu to navigate to based on navigation settings
		nav_up = null; 		//  "" "" "" "" ""
		nav_left = null; 	//  "" "" "" "" ""
		nav_right = null; 	//  "" "" "" "" ""
		nav_back = null; 	//  "" "" "" "" ""
		nav_change = null;  //
		nav_change_to = null; //
		gamelist = null;
		
		constructor()
		{
			nav_change = true;  	//
			nav_change_to = "main" 	//
			
		}
		
		function move_frame(direction)
		{
			return true;
		}
		
		function activate()
		{		
			nav_change = true;  	//
			nav_change_to = "main" 	//
			gamelist.reset_index;
			fe.signal("add_favourite");
			fe.signal("back");
		}
		
		function deactivate()
		{
			nav_change = true;  	//
			nav_change_to = "main" 	//
		}
		
	}



//////////////////////////////////
//
// Setup Search Object
//
//////////////////////////////////
	class SearchMenu
	{

	// ToDO
	// 1. fix the select sounds (look for "click")
		
		name = null;
		keyboard = null;
		surface = null;			// the surface that is to be animated
		sounds_active = null;	// turn on/off the menu click sound
		search_all = null;	// determine if search should change the filter to all when starting
		current_filter_index = null;
		nav_down = null; 	// the menu to navigate to based on navigation settings
		nav_up = null; 		//  "" "" "" "" ""
		nav_left = null; 	//  "" "" "" "" ""
		nav_right = null; 	//  "" "" "" "" ""
		nav_back = null; 	//  "" "" "" "" ""
		nav_change = null;  //
		nav_change_to = null //
		
		// setup values to draw the keyboard
		item_x_start = null; //the beginning place to draw the keyboard x
		item_y_start = null; //the beginning place to draw the keyboard y
		kb_key_h =  null;
		kb_key_w =  null;
		padding_x =  null;
		padding_y =  null;
		
		// Search text box
		search_box = null;	
		search_results = null;
		
		
		ui_frame_img = null;		// Selection image
		ui_sel_x = null;	// cursor position index x
		ui_sel_y = null;	// cursor position index y
		
		constructor ()
		{
			ui_sel_x = 0;
			ui_sel_y = 0;
		}
		
		function init_search()
		{
			// Add all objects to a surface for later animation
			surface.alpha = 0;
			
			// draw keyboard
			local i = -1;
			local col = 0;
			local x = item_x_start;
			local y = item_y_start;
			local key = null;
			local previous_letter = null;
			local letter = null;
			local w = null;


			foreach (row in keyboard.name)
			{	
				keyboard.img.append({row=[]}); // append a new row
				y += padding_y;
				i += 1;
				x=item_x_start;
				
				foreach (letter in keyboard.name[i].row)
				{	

					if ((letter == "favorite") || (letter == "done"))
						w = (kb_key_w *3) + padding_x * 2;
					else if (letter == "SYMSPACE")
						w = (kb_key_w *4) + padding_x * 3;
					else 
						w = kb_key_w;
					
					key = surface.add_image("assets/keyboards/" + letter + ".png", x ,y ,w , kb_key_h);
					keyboard.img[i].row.append(key);
					
					x += (padding_x + key.width); // move x the width of the last key and add the padding	

				}
			}
			
			// add the selection graphic above the items 
			ui_frame_img.set_pos( 
				keyboard.img[0].row[0].x, 
				keyboard.img[0].row[0].y,
				keyboard.img[0].row[0].width,
				keyboard.img[0].row[0].height);
			ui_frame_img.zorder = (keyboard.img[i].row[ keyboard.img[i].row.len()-1].zorder) + 1;
		}
	
		function addKeys(letter) // determine which keys to send to the search routine
		{
			local str = null;
			
			switch (letter)
			{
				case "SYM-":
				case "SYM_":
				case "SYM.":
					str = letter.slice(3,4);
					if (search_box.msg !="")
						search_box.msg = search_box.msg + str;
					break;
				
				case "SYMDEL":
					str = search_box.msg;
					if (str != "" )
						search_box.msg = str.slice(0, str.len()-1)
					break;
				
				case "favorite":
				case "done":
					search_box.msg = "";
					break;
				
				case "SYMSPACE":
					str = search_box.msg;
					search_box.msg = str + " ";
					break;
				
				default:
					search_box.msg = search_box.msg + letter;
			}
			applySearch();

		}
		
		function applySearch() // perform a search
		{		
			local text = null;
			local results = null;
			try
			{
				text = search_box.msg.tolower();
				local rule = "Title contains " + _massage(text);
				//print( "Rule: " + rule );
				
				fe.list.search_rule = ( text.len() > 0 ) ? rule : "";
				(fe.list.search_rule == "") ? search_results.alpha = 0 : search_results.alpha = 255;
				
				
			} catch ( err ) { print( "Unable to apply filter: " + err ); }
		}
		
		function _massage( str ) // create a regular expression when seaching
		{
			
			// to do: change so the search string is case independent
			local words = split( str, " " );

			local temp="";
			foreach ( w in words )
			{
				if ( temp.len() > 0 )
					temp += " ";

				local f = w.slice( 0, 1 );
				temp += "["+f.toupper()+f.tolower()+"]"+w.slice(1);
			}

			return temp;
		}
				function move_frame(direction)
		{
			// animate the menu selection
			switch ( direction )	
			{
				case "left":
				if ( ui_sel_x > 0 ) 
				{
					ui_sel_x--;
					update_frame();
				}
				else
				{
					ui_sel_x = keyboard.img[ui_sel_y].row.len()-1;
					update_frame();
				}
				return true;
				break;
				
				case "right":
				if ( ui_sel_x < keyboard.img[ui_sel_y].row.len()-1 ) 
				{
					ui_sel_x++;
					update_frame();
				}
				else
				{
					ui_sel_x = 0;
					update_frame();
				}
				return true;
				break;
					
				case "up":
				if ( ui_sel_y > 0 ) 
				{
					ui_sel_y--;
					update_frame();
				}
				else
				{
					// go to the gamelist
					nav_change = true;
					nav_change_to = nav_up;
				}
				return true;
				break;
				
				case "down":
				if ( ui_sel_y < keyboard.img.len()-1 ) 
				{
					ui_sel_y++;
					if (ui_sel_y == keyboard.img.len()-1 )
						update_frame(true);
					else
						update_frame();
				}
				else
				{
				// go to the gamelist
					nav_change = true;
					nav_change_to = nav_up;
				}
				return true;
				break;
				
				case "select":
					select_key();
					return true;
					break;
					
				case "back":
					nav_change = true;
					nav_change_to = nav_back;
					return true;
					break;
			}
			return true;
		}
		
		function set_favorite()
		{
			fe.signal("add_favourite");	
		}
		
		function update_frame(move_to_last = false)
		{
			if (move_to_last)
			{	
				if (ui_sel_x < 4)
					ui_sel_x = 0;
				else if (ui_sel_x < 8)
					ui_sel_x = 1;
				else 
					ui_sel_x = 2;
			}
			
			
			ui_frame_img.set_pos(keyboard.img[ui_sel_y].row[ui_sel_x].x, keyboard.img[ui_sel_y].row[ui_sel_x].y);
			ui_frame_img.width = keyboard.img[ui_sel_y].row[ui_sel_x].width;
			
		}
		
		function select_key()
		{
			// performs action when item under the cursor has been pressed
			local key = keyboard.img[ui_sel_y].row[ui_sel_x]; // the fe.image object for the chose key
			local letter = keyboard.name[ui_sel_y].row[ui_sel_x]; // the letter chosen on the on-screen keyboard
		//	local click = fe.add_sound( fe.script_dir + "sounds/selectclick.mp3", true );
			
			
			animation.add(PropertyAnimation(key,{
				property = "scale",
				time = 75,
				end = 3.5
			} ));
			
			//click.playing = sounds_active;
			
			animation.add(PropertyAnimation(key,{
				property = "scale",
				time = 75,
				end = 1.0,
				delay = 100
			}));
			
			if (letter == "done")
			{
				addKeys(letter);
				nav_change = true;
				nav_change_to = nav_back;
			} else if (letter == "favorite") {
				set_favorite();
			} else {
				addKeys(letter);
				return;
			}	
				
				return; 	 
		}
		function activate()
		{
			
			//show the selection box
			ui_frame_img.alpha = 255;
			
			// only animate in if going back to the main menu (configured in "nav_back")
			if ((nav_change_to == nav_back) || nav_change_to == null)
			{
				current_filter_index = fe.list.filter_index;
				
				if (search_all)
				{
					local i=0;
					foreach (filter in fe.filters)
					{
						
						if (filter.name.toupper() == "ALL")
						{	
							fe.list.filter_index = i;
							break;
						}
						
						i++;
					}
				}
				
				// fade menu in
				animation.add( PropertyAnimation( surface,
					{   
						property = "alpha",
						tween = Tween.Expo,
						easing = Easing.Out,
						end = 255,
						time = 1000,
					} ) );
				
				// create squeeze in animate for the menu
				animation.add( PropertyAnimation( surface,
					{   
						property = "height",
						tween = Tween.Expo,
						easing = Easing.Out,
						start = 0
						end = scr_h / 2.068965517,
						time = 600,
					} ) );
			}	
		
		}
		
		function deactivate()
		{

				//hide the selection box
				ui_frame_img.alpha = 0;
				
				// only animate out if going back to the main menu (configured in "nav_back")
				if (nav_change_to == nav_back)
				{
				
				// create squeeze out animate for the menu
				animation.add( PropertyAnimation( surface,
					{   
						property = "height",
						tween = Tween.Expo,
						easing = Easing.Out,
						end = 0,
						time = 600,
					} ) );		

				// fade menu out
				animation.add( PropertyAnimation( surface,
					{   
						property = "alpha",
						tween = Tween.Expo,
						easing = Easing.Out,
						end = 0,
						time = 1000,
					} ) );

		
				if (search_all)
				{	
					fe.list.filter_index = current_filter_index;
				}
			}
		}
	}
//////////////////////////////////
//
// Setup Layout Artwork
//
//////////////////////////////////

	//add background image
	if ( (layout_config[ "bg_art" ] == "none" ))
	{		
		null;
	}
	else if ( (layout_config[ "bg_art" ] == "file" ))
	{		
		fe.add_image( "assets/backgrounds/black.png", 0, 0, scr_w, scr_h );
	}	else
	{
		bg_surface = fe.add_surface( scr_w, scr_h);
		bg_img = FadeArt( layout_config["bg_art"], 0, 0, scr_w ,scr_h, bg_surface );
		bg_surface.set_pos( 0, 0 );
		bg_img.trigger = Transition.EndNavigation;
		bg_img.video_flags = Vid.NoAudio;

		// Add Blur Shader to the Background picture
		if (layout_config["bg_blur"] == "Yes")
		{
			bg_shaderH = bg_shaderV = fe.add_shader( Shader.Fragment, "assets/shaders/frag.txt" );
			bg_shaderH.set_texture_param( "source");
			bg_shaderV.set_texture_param( "source");
			bg_shaderH.set_param("offsetFactor", 0.002000, 0);
			bg_shaderV.set_param("offsetFactor", 0, 0.002000);
			bg_surface.shader = bg_shaderH;
			bg_img.shader = bg_shaderV;
		}
	}

	
	//Add UI overlay
	local ui_overlay = fe.add_image( "assets/UIelements/overlay.png", 0, 0, scr_w , scr_h );
	
	//clock
	local clock_i = fe.add_image( "assets/UIelements/clock.png", settings.clk_i.x, settings.clk_i.y, settings.clk_i.w, settings.clk_i.h );
	local clock_t = fe.add_text( "", settings.clk_t.x, settings.clk_t.y, settings.clk_t.w, settings.clk_t.h );
	fe.add_ticks_callback( this, "update_clock" );
	function update_clock( ttime )
	{
		local now = date();
		clock_t.msg = format("%02d", now.hour ) + ":" + format("%02d", now.min );
	}
	
		
	// display indicater
	local mini_display_i = fe.add_image( "assets/displays/[DisplayName].png", settings.mdpy_i.x, settings.mdpy_i.y, settings.mdpy_i.w, settings.mdpy_i.h );
	
	// Set the gamelist settings
	::menu["gamelist"] <- Grid();
	menu["gamelist"].gl_item_h = gl_item_h;
	menu["gamelist"].gl_startpostion = settings.gl_startpostion;
	menu["gamelist"].gl_item_p = gl_item_p;
	menu["gamelist"].gl_height = settings.gl_height;
	menu["gamelist"].gl_width = settings.gl_width;
	menu["gamelist"].name = "gamelist";
	menu["gamelist"].nav_up = menu["gamelist"].nav_down = "main";
	
	// Populate the gamelist
	local my_array = [];
	for ( local i=0; i < gl_rows * gl_cols; i++)
	{
		my_array.push( MySlot( i, gl_item_w, gl_item_h ) );
		my_array[i].gl_item_p = gl_item_p;
		my_array[i].gl_startpostion = settings.gl_startpostion
		my_array[i].gl_height = settings.gl_height;
		my_array[i].gl_width = settings.gl_width;
		
		// configure Artwork and the surface
		my_array[i].gl_item_sur = fe.add_surface(gl_item_w - gl_item_p, gl_item_h);
		my_array[i].g_art_img = my_array[i].gl_item_sur.add_artwork( 
			layout_config["g_art"], 
			0, 
			0, 
			gl_item_w - gl_item_p, 
			gl_item_h
		);
		my_array[i].g_art_img.trigger = Transition.EndNavigation;
		my_array[i].gl_item_zo = my_array[i].gl_item_sur.zorder;
		
		// place game name and border if it fits
		if ((scr_h / gl_item_h < 2.55) && (layout_config["show_name"] == "Yes"))
		{
			// black_border
			my_array[i].g_bg_img = my_array[i].gl_item_sur.add_image("assets/UIelements/black.png",
			0,
			gl_item_h - (gl_item_h / 6.967741935) + 1,
			gl_item_w - gl_item_p,
			gl_item_h / 6.9677419354 
			);
			
			// game text
			my_array[i].g_name_txt = my_array[i].gl_item_sur.add_text(
				"",
				0,
				my_array[i].g_bg_img.y + ((my_array[i].g_bg_img.height - gl_item_h / 12.5)/2) ,
				gl_item_w - gl_item_p, gl_item_h / 12.5 
			);
			
			my_array[i].borderOn = true;
		} 		
		// bloom the selected game if selected
		if ( layout_config["gl_shader"] == "Yes" ) 
			my_array[i].g_bloomActive = true;
		
		// keep the game aspect ratio if configured
		my_array[i].preserveAspect(gl_aspect);
		
		// set the location of the favorite image;
		my_array[i].favorite_img = 	my_array[i].gl_item_sur.add_image(
			"assets/UIelements/" + layout_config["favicon"].tolower() + "-favorite.png", 
			my_array[i].g_art_img.width - (my_array[i].g_art_img.height / 9.44),
			3, 
			my_array[i].g_art_img.height / 9.44, 
			my_array[i].g_art_img.height / 9.44
		);
		my_array[i].favorite_img.visible = true;
		
	}
	menu["gamelist"].set_slots( my_array, menu["gamelist"].get_sel() ); 
	menu["gamelist"].my_array = my_array;	// allow the gamelist to access the slots directly
	
	// Show game list and current game number in the header
	menu["gamelist"].g_list_txt = fe.add_text( "[FilterName]: [ListEntry] / [ListSize]", settings.gl_t.x, settings.gl_t.y, settings.gl_t.w, settings.gl_t.h );

	//
	// show selected game details
	//
	// ------------ create game info surface ------------
	menu["gamelist"].surface = fe.add_surface(settings.gi_surface.w, settings.gi_surface.h);
	menu["gamelist"].surface_y = settings.gi_surface.y;
	menu["gamelist"].sub_surface = menu["gamelist"].surface.add_surface(settings.gi_subsurface.w, settings.gi_subsurface.h);
	menu["gamelist"].surface.set_pos(settings.gi_surface.x, settings.gi_surface.y);
	menu["gamelist"].sub_surface.set_pos(settings.gi_subsurface.x, settings.gi_subsurface.y);
	// -------------- images ------------------
	local game_info_bgimg = menu["gamelist"].sub_surface.add_image("assets/UIelements/overlay-gameinfo.png",0,0,menu["gamelist"].sub_surface.width, menu["gamelist"].sub_surface.height )
	menu["gamelist"].g_genre_img = menu["gamelist"].sub_surface.add_image( "[!Genre]", settings.genre_i.x, settings.genre_i.y, settings.genre_i.w, settings.genre_i.h );
	menu["gamelist"].g_man_img = menu["gamelist"].sub_surface.add_image( "assets/publishers/[Manufacturer].png", settings.mlogo_i.x, settings.mlogo_i.y, settings.mlogo_i.w, settings.mlogo_i.h )
	menu["gamelist"].g_emu_img = menu["gamelist"].sub_surface.add_image( "assets/emu_logos/[Emulator].png", settings.emulogo_i.x, settings.emulogo_i.y, settings.emulogo_i.w, settings.emulogo_i.h )
	menu["gamelist"].g_logo_img = menu["gamelist"].surface.add_artwork( layout_config["logo"], settings.glogo_i.x, settings.glogo_i.y, settings.glogo_i.w, settings.glogo_i.h )
	menu["gamelist"].g_flyer_img = menu["gamelist"].surface.add_artwork( layout_config["flyer"], settings.flyr_i.x, settings.flyr_i.y, settings.flyr_i.w, settings.flyr_i.h )
	// ------------ game info labels ----------
	local year_lbl_t = menu["gamelist"].sub_surface.add_text( "YEAR", settings.ylbl_t.x, settings.ylbl_t.y, settings.ylbl_t.w, settings.ylbl_t.h );
	local players_lbl_t = menu["gamelist"].sub_surface.add_text( "[!playerstext]", settings.plbl_t.x, settings.plbl_t.y, settings.plbl_t.w, settings.plbl_t.h );
	local genre_lbl_t = menu["gamelist"].sub_surface.add_text( "GENRE", settings.glbl_t.x, settings.glbl_t.y, settings.glbl_t.w, settings.glbl_t.h );
	local howoften_lbl_t = menu["gamelist"].sub_surface.add_text( "PLAY COUNT", settings.holbl_t.x, settings.tplbl_t.y, settings.tplbl_t.w, settings.tplbl_t.h );
	local howlong_lbl_t = menu["gamelist"].sub_surface.add_text( "PLAY TIME", settings.tplbl_t.x, settings.tplbl_t.y, settings.tplbl_t.w, settings.tplbl_t.h );
	// --------------- text -------------------
	menu["gamelist"].g_year_txt = menu["gamelist"].sub_surface.add_text( "[Year]", settings.year_t.x, settings.year_t.y, settings.year_t.w, settings.year_t.h );
	menu["gamelist"].g_plyrs_txt = menu["gamelist"].sub_surface.add_text( "[Players]", settings.plyr_t.x, settings.plyr_t.y, settings.plyr_t.w, settings.plyr_t.h );
	menu["gamelist"].g_played_txt = menu["gamelist"].sub_surface.add_text( "[PlayedCount]", settings.tplyd_t.x, settings.tplyd_t.y, settings.tplyd_t.w, settings.tplyd_t.h );
	menu["gamelist"].g_time_txt = menu["gamelist"].sub_surface.add_text( "[!playtime]", settings.hrsply_t.x, settings.hrsply_t.y, settings.hrsply_t.w, settings.hrsply_t.h );
	menu["gamelist"].g_name_txt = menu["gamelist"].surface.add_text( "[Title]", settings.gname_t.x, settings.gname_t.y, settings.gname_t.w, settings.gname_t.h )

	// add the gamelist frame selection box
	menu["gamelist"].ui_frame_img = fe.add_image( "assets/UIelements/selection.png", 0, 0, sel_frame_w, sel_frame_h );
	menu["gamelist"].ui_frame_img.alpha = 0;

	
	// Pulsating Aminamtion for the selection box
	animation.add( PropertyAnimation( menu["gamelist"].ui_frame_img, 
		{   
			property = "color",
			tween = Tween.Linear, 
			start = {red=255 ,green=255, blue=255},
			end = {red=236, green=47, blue=47},
			pulse = true,
			time = layout_config["ttime"].tointeger() / 1.45,

		} ) );

	// have the game info sub surface animate in on first launch and on layout changes
	// -------------------- remove game info -----------------------
	menu["gamelist"].sub_surface.y = settings.gi_subsurface.h + settings.gi_surface.h;
	// ------------- animate in ----------------------
	animation.add( PropertyAnimation( menu["gamelist"].sub_surface,
	{   
		when = When.StartLayout,
		property = "y",
		tween = Tween.Linear,
		easing = Easing.Out,
		start = settings.gi_subsurface.h + settings.gi_surface.h,
		end = settings.gi_subsurface.y,
		time = layout_config["ttime"].tointeger() * 4,
		
	} ) );	
	
	
	//
	// setup layout image and text settings
	//
	// ---------------------- preserve_aspect_ratio ----------------------
	mini_display_i.preserve_aspect_ratio = 
	menu["gamelist"].g_genre_img.preserve_aspect_ratio = 
	menu["gamelist"].g_man_img.preserve_aspect_ratio = 
	menu["gamelist"].g_emu_img.preserve_aspect_ratio = 
	menu["gamelist"].g_logo_img.preserve_aspect_ratio = 
	menu["gamelist"].g_flyer_img.preserve_aspect_ratio = true;
	// ----------------------- trigger -----------------------------------
	menu["gamelist"].g_flyer_img.trigger = 
	menu["gamelist"].g_genre_img.trigger = 
	menu["gamelist"].g_man_img.trigger = 
	menu["gamelist"].g_emu_img.trigger = 
	menu["gamelist"].g_logo_img.trigger = Transition.EndNavigation;
	// ----------------------- font --------------------------------------
	clock_t.font = 
	year_lbl_t.font = 
	players_lbl_t.font = 
	genre_lbl_t.font = 
	howoften_lbl_t.font = 
	howlong_lbl_t.font = 
	menu["gamelist"].g_year_txt.font = 
	menu["gamelist"].g_plyrs_txt.font = 
	menu["gamelist"].g_list_txt.font =
	menu["gamelist"].g_played_txt.font = 
	menu["gamelist"].g_time_txt.font = 
	menu["gamelist"].g_name_txt.font = settings.font;
	// ----------------------- text alignment ----------------------------
	menu["gamelist"].g_list_txt.align = 
	clock_t.align = Align.Left;
	// ----------------------- text colors -------------------------------
	menu["gamelist"].g_year_txt.set_rgb( 232, 47, 47);
	menu["gamelist"].g_plyrs_txt.set_rgb( 232, 47, 47);
	menu["gamelist"].g_played_txt.set_rgb( 232, 47, 47);
	menu["gamelist"].g_time_txt.set_rgb( 232, 47, 47);
	year_lbl_t.set_rgb( 210, 208, 208 );
	players_lbl_t.set_rgb( 210, 208, 208 );
	genre_lbl_t.set_rgb( 210, 208, 208 );
	howoften_lbl_t.set_rgb( 210, 208, 208 );
	howlong_lbl_t.set_rgb( 210, 208, 208 ); 
	menu["gamelist"].g_list_txt.set_rgb( 210, 208, 208 );
	clock_t.set_rgb( 210, 208, 208 );
	ui_overlay.set_rgb( ui_red, ui_green, ui_blue );
	game_info_bgimg.set_rgb( ui_red, ui_green, ui_blue );
	
	//
	/////////////////////////////////////////////////////
	
	// move the frame to the inital position
	menu["gamelist"].update_frame();
	my_array[menu["gamelist"].get_sel()].grow();
	menu["gamelist"].ui_frame_img.zorder = my_array[menu["gamelist"].get_sel()].gl_item_sur.zorder +1;
	
	
	// setup Main Menu
	menu["main"] <- arcadebliss_menu();	
	menu["main"].name = "main";
	menu["main"].nav_up = menu["main"].nav_down = "gamelist";
	menu["main"].gamelist = menu["gamelist"]; // allow main menu to access gamelist functions
	
	// Create Surface to hold the menu and add the items ites to simplify animation
	menu["main"].surface = fe.add_surface(settings.mbkgrd_s.w, settings.mbkgrd_s.h);
	menu["main"].surface.set_pos( settings.mbkgrd_s.x, settings.mbkgrd_s.y );
	menu["main"].startpostion_y = (settings.mbkgrd_i.h - settings.srch_i.h)/2
	
	// load main menu images 
	local menu_bg_i = menu["main"].surface.add_image( "assets/UIelements/menu_bar.png", settings.mbkgrd_i.x , settings.mbkgrd_i.y, settings.mbkgrd_i.w, settings.mbkgrd_i.h ); // add menu background
	menu["main"].add_item( menu["main"].surface.add_image( "assets/UIelements/menu_search.png", settings.srch_i.x, settings.srch_i.y, settings.srch_i.w, settings.srch_i.h ), "search" );//search menu item
	menu["main"].add_item( menu["main"].surface.add_image( "assets/UIelements/menu_filter.png", settings.flt_i.x, settings.flt_i.y, settings.flt_i.w, settings.flt_i.h ), "filter" );//change filter menu item
	menu["main"].add_item( menu["main"].surface.add_image( "assets/UIelements/menu_display.png", settings.dply_i.x, settings.dply_i.y, settings.dply_i.w, settings.dply_i.h ), "display" );//change display menu item
	if (layout_config["g_rows"] == "1") // only show add favorite if one row is visible
		menu["main"].add_item( menu["main"].surface.add_image( "assets/UIelements/menu_add_favorite.png", settings.fav_i.x, settings.fav_i.y, settings.fav_i.w, settings.fav_i.h ), "favorite" ); // add|remove favorites menu item
	menu["main"].add_item( menu["main"].surface.add_image( "assets/UIelements/menu_powerbutton.png", settings.fav_i.x, settings.fav_i.y, settings.fav_i.w, settings.fav_i.h ), "power" ); // add|remove favorites menu item
	menu_bg_i.set_rgb( ui_red, ui_green, ui_blue );
		
	// Show menu Arrows
	menu["main"].r_arrow_i = fe.add_image( "assets/UIelements/arrow_r.png", settings.ra_i.x, settings.ra_i.y, settings.ra_i.w, settings.ra_i.h );
	menu["main"].l_arrow_i = fe.add_image( "assets/UIelements/arrow_l.png", settings.la_i.x, settings.la_i.y, settings.la_i.w, settings.la_i.h );
	
	// Main Menu Selection Frame
	menu["main"].ui_frame_img = fe.add_image( "assets/UIelements/selection.png", scr_w/2 - menu["main"].stride/2, settings.mbkgrd_s.y, menu["main"].stride, settings.mbkgrd_s.h );
	menu["main"].ui_frame_img.alpha = 0;
	
	// Setup the Search menu
	// TODO: put all settings in the settings table
	menu["search"] <- SearchMenu();
	menu["search"].nav_back = "main";
	menu["search"].nav_up = "gamelist";
	menu["search"].search_all = true;
	menu["search"].current_filter_index = fe.list.filter_index;
	menu["search"].item_x_start = scr_w / 3.47826087;
	menu["search"].item_y_start = 12;
	menu["search"].kb_key_h = scr_w / 29.629629629;
	menu["search"].kb_key_w = scr_w / 29.629629629;
	menu["search"].padding_x = scr_w / 100;
	menu["search"].padding_y = scr_h / 17.14285714;
	// -------------- setup up surface ---------------------
	menu["search"].surface = fe.add_surface(scr_w ,scr_h / 2.068965517);
	menu["search"].surface.set_pos( 0, 340 );
	menu["search"].surface.alpha = 0;
	// ------------ add the search box ----------------------
	menu["search"].search_box = menu["search"].surface.add_text("",
		menu["search"].item_x_start,
		scr_h / 40, 
		scr_w /2.339181287 ,
		scr_h / 24);
	menu["search"].search_box.set_bg_rgb(210,208,208);
	menu["search"].search_box.font = "BebasNeue";
	menu["search"].search_box.charsize = 18;
	menu["search"].search_box.set_rgb( 236, 47, 47 );
	// ------------ add the search results message ----------------------
	menu["search"].search_results = menu["search"].surface.add_text("[ListSize] FOUND",
		menu["search"].item_x_start + scr_w /2.339181287 ,
		scr_h / 40, 
		scr_w / 4,
		scr_h / 24);
	menu["search"].search_results.font = "BebasNeue";
	menu["search"].search_results.charsize = 18;
	menu["search"].search_results.align = Align.Left;
	menu["search"].search_results.set_rgb( 236, 47, 47 );
	menu["search"].search_results.alpha = 0;
	// ------------- keyboard layout and values -------------------
	menu["search"].keyboard = 
	{
		img = [],
		name = [
			{row =["1","2","3","4","5","6","7","8","9","0"]},
			{row =["A","B","C","D","E","F","G","H","I","J"]},
			{row =["K","L","M","N","O","P","Q","R","S","T"]},
			{row =["U","V","W","X","Y","Z","SYM.","SYM-","SYM_","SYMDEL"]},
			{row =["favorite","SYMSPACE","done"]}
		],
	}
	// ------------ add the selection box image ----------------------	
	menu["search"].ui_frame_img = menu["search"].surface.add_image("assets/UIelements/selection.png");
	// ------------ initilize the search  ----------------------
	menu["search"].init_search();
	
	
	//setup favorite menu item
	menu["favorite"] <- FavoriteMenu();
	menu["favorite"].gamelist = menu["gamelist"];
	
	// set the first menu to activated
	activeMenu = "gamelist";
	
////////////////////////////////////////
//
// Layout Functions
//
///////////////////////////////////////
	// Dynamically change the genre file
	function Genre(offset)
	{
		local result = "UNKONOWN";
		local cat = " " + fe.game_info(Info.Category, offset).tolower();
		local supported = {
			//filename : [ match1, match2 ]
			"action.png": [ "action" ],
			"adventure.png": [ "adventure" ],
			"fighter.png": [ "fighting", "fighter", "beat'em up" ],
			"platform.png": [ "platformer", "platform" ],
			"puzzle.png": [ "puzzle" ],
			"racing.png": [ "racing", "race" ],
			"rpg.png": [ "rpg", "role playing", "role playing game" ],
			"shooter_flying.png": ["shooter",  "flying vertical", "flying horizontal" ],
			"shooter_gun.png": [ "gun" ],
			"shooter_gallery.png": ["gallery", "field"],
			"sports.png": [ "sports", "boxing", "golf", "baseball", "football", "soccer" ],
			"maze.png": [ "maze" ],
			"ball and paddle.png": [ "ball & paddle" ],
			"strategy.png": [ "strategy" ]
		}
		
		local matches = [];
		foreach( key, val in supported )
		{
			foreach( nickname in val )
			{
				if ( cat.find(nickname, 0) ) matches.push(key);
			}
		}
		if ( matches.len() > 0 )
			result = matches[0];
		else
			result = "unknown.png"
		
		return "assets/genres/" + result;
	}
	
	//format Players text
	function playerstext()
	{
		try
		{
		
			if (fe.game_info(Info.Players).slice(0,1) == "1")
				return "PLAYER";
			else
				return "PLAYERS";
		} catch(error) {
		
			return "UNKNOWN";
		
		}	
	}
	
	//format Play time
	function playtime()
	{
		local result = null;
		local time_measurement = null;
		local minutes = fe.game_info(Info.PlayedTime).tointeger();
		
		if (minutes == 0)
		{
			result = "--";
			
		} else if (minutes > 1439) 
		{
			time = minutes / 1440.0;
			time_measurement = "DAYS";
			result = format("%2d %s",time,time_measurement)
			
		} else if (minutes > 60.0)
		{	
			
			time = minutes / 60.0;
			time_measurement = "HRS";
			result = format("%2d %s",time,time_measurement)
			
		} else {
			
			time = minutes;
			time_measurement = "MINS";
			result = format("%2d %s",time,time_measurement)
			
		}
		return result;
	}


////////////////////////////////////////////////////
// layout Main Loop
////////////////////////////////////////////////////
	
	// move the frame located in the grid object 
	// based on joystick movement
	fe.add_signal_handler( "cursorMovement" );
	function cursorMovement(sig)
	{
		local stop_more_processing = null;
		local menu_result = null;
		
		switch (sig)
		{	
			case "down":					
			case "up":
			case "left":
			case "right":
			case "select":
			case "back":
				
				stop_more_processing = menu[activeMenu].move_frame(sig);
				

				
				if (menu[activeMenu].nav_change) 
				{
					menu[activeMenu].nav_change = false; // remove the change menu flag
					menu[activeMenu].deactivate(); 	// turn off the current menu
					activeMenu = menu[activeMenu].nav_change_to; // set the active menu to the new menu				
					menu[activeMenu].activate(); 	// activate the new menu
					stop_more_processing = true;	//set "more_processing" to false		
				} 
				
				if ((activeMenu == "gamelist") && (layout_config["g_rows"] == "1"))
				{
					menu["main"].toggle_fav();	
				}					
		}
		
		return stop_more_processing;
	}
	

