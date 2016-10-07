///////////////////////////////////////////////////
//
// Attract-Mode Frontend - MiniArcadeBliss layout
//
///////////////////////////////////////////////////
class UserConfig {
	</ label="List Artwork", help="The artwork to show in the games list", options="marquee,flyer,wheel,snap,none", order=1 />
	orbit_art="snap";
	
	</ label="Logo Artwork", help="The logo artwork to show in details section", options="marquee,flyer,wheel,snap,none", order=2 />
	wheel_art="wheel";
	
	</ label="Background Artwork", help="The artwork to show in the background", options="snap,fanart,none", order=3 />
	bg_art="fanart";

	</ label="Flyer Artwork", help="The artwork to show in the details section", options="flyer,snap,wheel,marquee,none", order=4 />
	flyer_art="flyer";

	</ label="CRT Effect", help="Enable the CRT Effect (requires shader support)", options="Yes,No", order=5 />
	enable_crt="Yes";

	</ label="Game List Count", help="The number of items shown in the game list", options="3,5,7,9,11,13", order=6 />
	count="5";
	
	</ label="History.dat", help="History.dat location. Be sure to enable and config History.dat from the plugins menu.", order=7 />
	dat_path="C:\\AttractMode\\history.dat";
	
	</ label="Horizontal Navigation", help="Change Navigation to be LEFT/RIGHT instead of UP/DOWN. UP/DOWN will scroll game description text", options="YES,NO", order=8 />
	horzNav="NO";
	
	</ label="Favorite Icon Type", help="Show which favorite icon should be should on non favorite filters", options="NONE,SOLID,WIREFRAME", order=9 />
	favicon="SOLID";
}

// Load necessary modules
fe.load_module( "conveyor" );
//fe.load_module("objects\\scrollingtext");

// Include the utilities to read the history.dat file
dofile(fe.script_dir + "file_util.nut" );

// Include my changed fade.nut file to allow using default artwork when artwork is missing
dofile(fe.script_dir +  "fade.nut" );

// Load configuration from above
local my_config = fe.get_config();
local horizontalNavigation = my_config["horzNav"];

fe.layout.preserve_aspect_ratio==true;
fe.layout.width = 1280
fe.layout.height = 1024

// GAME Details Settings
const DETAILS_LEFT_ALIGNMENT = 442;
const DETAILS_BOTTOM_ALIGNMENT = 570;
const DETAILS_INFO_TAG_WIDTH = 127;
const DETAILS_INFO_TAG_OFFSET = 45;

//Overlay Menu Settings
const OVERLAY_ALPHA =190;

// TV Screen Conveyour Settings
const MWIDTH = 400 ; // standard width of each screen
const MHEIGHT = 300 ; // standard height of each screen
const GAMEITEMY = 835; // standard Y position of each screen
const SPIN_MS = 100; // conveyour spin speed
local num_sats = fe.layout.page_size = my_config["count"].tointeger()+2; // number of tv screens
local progress_correction = 1.0 / ( num_sats * 2 ); // ensures stop positions in converyor settings are referenced from the middle

//Set Layout Navigation
function LayoutNavigation(signal_str)
{
	
	local no_more_processing = false;
	if ((fe.get_input_state("Up")==true) 
		&& (signal_str=="up"))
	{
		no_more_processing = true;
	}
	if ((fe.get_input_state("Down")==true)
		&& (signal_str=="down"))
	{
		no_more_processing = true;
	}
	if ((fe.get_input_state("Left")==true)
		&& (signal_str=="up"))
	{
		no_more_processing = false;
	}
		if ((fe.get_input_state("Right")==true)
			&& (signal_str=="Down"))
	{
		no_more_processing = false;
	}
	
	return no_more_processing;
}

if (horizontalNavigation=="YES") // perform alternate layout nav if selected in options
{
	fe.add_signal_handler( "LayoutNavigation" );
}

//////////////////////////////////////////////////
//
// a class that displays images according to 
// data found in the emulator game list e.g: ersb
// graphic based upon name in a game list
//
//////////////////////////////////////////////////
	class changingImage
	{
		mode = 1;       //0 = first match, 1 = last match, 2 = random
		supported = null;
		folder=null;
		infoType=null;
		ref = null;
		
		constructor( image, sup, f, i  )
		{
			supported = sup;
			folder= f;
			infoType= i;
			ref = image;
			fe.add_transition_callback( this, "imagetransition" );
			
		
		}
	   
		function imagetransition( ttype, var, ttime )
		{
	
			if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
			{
				local cat = null;
				if (infoType==Info.Tags)
				{
					cat = " " + fe.game_info(infoType, var);
				} else {
					cat = " " + fe.game_info(infoType, var).tolower();
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
				{
					switch( mode )
					{
						case 0:
							ref.file_name = "images/" + folder + "/" + matches[0] + ".png";
							break;
						case 1:
							ref.file_name = "images/" + folder + "/" + matches[matches.len() - 1] + ".png";
							break;
						case 2:
							local random_num = floor(((rand() % 1000 ) / 1000.0) * ((matches.len() - 1) - (0 - 1)) + 0);
							ref.file_name = "images/" + folder + "/" + matches[random_num] + ".png";
							break;
					}
				} else {
					ref.file_name = "images/" + folder + "/unknown.png";
				}
			}
		}
	}


///////////////////////////////////////////////
// Class to assign the history.dat information
// to a text object called ".currom"
///////////////////////////////////////////////
	function get_hisinfo() 
	{ 
		local sys = split( fe.game_info( Info.System ), ";" );
		local rom = fe.game_info( Info.Name );
		local text = ""; 
		local currom = "";

		// 
		// we only go to the trouble of loading the entry if 
		// it is not already currently loaded 
		// 
		
		local alt = fe.game_info( Info.AltRomname );
		local cloneof = fe.game_info( Info.CloneOf );
		local lookup = get_history_offset( sys, rom, alt, cloneof );
		
		if ( lookup >= 0 ) 
		{ 

			text = get_history_entry( lookup, my_config );
 			local index = text.find("- TECHNICAL -");
			if (index >= 0)
			{	
				local tempa = text.slice(0, index);
				text = strip(tempa);
			} 
		
	 
		} else { 
			if ( lookup == -2 ) 
				text = "Index file not found.  Try generating an index from the history.dat plug-in configuration menu.";
			else 
				text = "No Information available for:  " + rom; 
		}  
		return text;
	}

//////////////////////////////////////////////////////
// class for the tv sets used in the conveyour module
//////////////////////////////////////////////////////
class GameItem
{
	snap = null;
	frame = null;
	frameback = null;
	favorite = null;
	
	constructor()
	{
		local b = fe.add_image("images/mainmenu/TVframeback.png");
		local s = fe.add_artwork(my_config["orbit_art"]);
		s.preserve_aspect_ratio=true;
		s.trigger = Transition.EndNavigation;
		local f = fe.add_image("images/mainmenu/TVframe.png");
		
		if (my_config["orbit_art"] != "snap")
		{
			b.visible = false;
			f.visible = false;
		}
		
		local favIconType="images/favorites/favorite-solid.png";
		switch (my_config["favicon"])
		{
			case "NONE":
				favIconType="images/favorites/favorite-none.png";
				break;
			case "SOLID":
				favIconType="images/favorites/favorite-solid.png"
				break;
			case "WIREFRAME":
				favIconType="images/favorites/favorite-wireframe.png"
				break;
			
		}
		
		local fav = fe.add_image(favIconType);
		fav.visible = false;
		snap = s;
		frame = f;
		frameback = b;
		favorite = fav;
	}

	
	function set_favorite()
	{

		local m=fe.game_info(Info.Favourite, snap.index_offset);
		
		if (m=="1")
			favorite.visible  = true;
		else
			favorite.visible  = false;
	}
	
	function set_size(w,h)
	{
		snap.width = w;
		frame.width = w;
		frameback.width = w;	
		snap.height = h;
		frame.height = h;
		frameback.height = h;
	}
		
	function set_x(x)
	{
		snap.x = x; 
		frame.x = x;
		frameback.x = x;
		favorite.x = x-10;
	}
	
	function set_y(y)
	{
		snap.y = y;
		frame.y = y;
		frameback.y = y;
		favorite.y = y-10;	
	}
	function set_alpha(a)
	{
		snap.alpha = a;
	}
	
	function set_bright(b)
	{
		snap.set_rgb(b,b,b);
	}

	function video_play(button) 
	{
		if (button == "ON") {
			snap.video_flags= Vid.Default;
		} else {
			snap.video_flags= Vid.NoAudio;
		}
		return;
	}
	

}

class Satellite extends ConveyorSlot
{
	//                                                       
	static x_lookup = [ -560, -360, -160, 80, 280, 440, 640, 840, 1000, 1200, 1440, 1640, 1840 ];
	static s_lookup = [ 0.85, 0.85, 0.85, 0.85, 0.85, 0.9, 1.15, 0.9, 0.85, 0.85, 0.85, 0.85, 0.85 ];
	static a_lookup = [ 0,0,0,50,150,200,255,200,150,50,0,0,0 ];
	static f_lookup = [ -60,-50,-40,-30,-20,-10,0,10,20,30,40,50,60];
	
	constructor()
	{
		local o = GameItem();
		base.constructor(o);
	}
	
	function swap( other )
	{
		m_obj.snap.swap( other.m_obj.snap );
	}
	
	function set_index_offset( io )
	{
		m_obj.snap.index_offset = io;

	}
	
	function reset_index_offset() {
		m_obj.snap.rawset_index_offset( m_base_io );

	}
	
	
	function on_progress( progress, var )
	{
		local scale;
		local new_x;
		local alpha;
		local form;
		progress += progress_correction;

		if ( progress >= 1.0 )
		{
			scale = s_lookup[ 12 ];
			new_x = x_lookup[ 12 ];
			alpha = a_lookup[ 12 ];
			form = f_lookup[ 12 ];
		}
		else if ( progress < 0 )
		{
			scale = s_lookup[ 0 ];
			new_x = x_lookup[ 0 ];
			alpha = a_lookup[ 0 ];
			form = f_lookup[ 0 ];
		}
		else
		{
			local slice = ( progress * 12.0 ).tointeger();
			local factor = ( progress - ( slice / 12.0 ) ) * 12.0;

			scale = s_lookup[ slice ]
				+ (s_lookup[slice+1] - s_lookup[slice]) * factor;

			new_x = x_lookup[ slice ]
				+ (x_lookup[slice+1] - x_lookup[slice]) * factor;

			alpha = a_lookup[ slice ]
				+ (a_lookup[slice+1] - a_lookup[slice]) * factor;
				
			form = f_lookup[ slice ]
				+ (f_lookup[slice+1] - f_lookup[slice]) * factor;

		}

	 	if (scale == 1.15) {
			m_obj.video_play("ON");
			m_obj.set_bright(255);
		} else {
			m_obj.video_play("");
			m_obj.set_bright(scale * scale* 100);
		} 
		
		m_obj.set_size(MWIDTH * scale,MHEIGHT * scale);
		m_obj.set_x(new_x - m_obj.snap.width / 2);
		m_obj.set_y(GAMEITEMY - m_obj.snap.height / 2);
	}
}


////////////////////////////////
//
//  Background
//
////////////////////////////////

	//Background picture
	local background_sur = fe.add_surface( fe.layout.width,fe.layout.height);
	local background = FadeArt( my_config["bg_art"], 0, 0, background_sur.width,background_sur.height, background_sur );
	background.preserve_aspect_ratio= true;
	background_sur.set_pos( 0, 0);
	background.trigger = Transition.EndNavigation;

	// Background
	fe.add_image("images/mainmenu/Background.png");

////////////////////////////////
//
//  Header
//
////////////////////////////////

	// Clock
	local dt = fe.add_text( "", 20, 12, 280, 25 );
	dt.set_rgb( 128, 128, 128 );
	dt.align = Align.Left;
	dt.style = Style.Bold;
	function update_clock( ttime )
	{
		local now = date();
		dt.msg = format("%02d", now.hour ) + ":" + format("%02d", now.min ) 
	}
	fe.add_ticks_callback( this, "update_clock" );

	// Emulator	
    local emulator = {
        //filename : [ match1, match2 ]
        "mame": [ "mame" ],
        "segam2": [ "adventure" ],
        "daphne": [ "fighting", "fighter", "beat'em up" ],
        "vpinball": [ "platformer", "platform" ],
        "futurepinball": [ "puzzle" ],
        "atomiswave": [ "racing", "driving" ],
        "seganaomi": [ "rpg", "role playing", "role playing game" ],
        "pcgamer": [ "shooter", "shmup" ],
        "taitotypex": [ "sports", "boxing", "golf", "baseball", "football", "soccer" ],
        "demul": [ "strategy"],
		"supermodel": [ "strategy"]
	}
	local emulator_image = fe.add_image("images/emulator/unknown.png");
	emulator_image.preserve_aspect_ratio = true;
	emulator_image.width = 280;
	emulator_image.height = 25;
	emulator_image.x = 12;
	emulator_image.y = 12;
	changingImage( emulator_image, emulator, "emulator", Info.Emulator  );

	// Total Games
	local l = fe.add_text( "[FilterName]:", 860, 12, 280, 25 );
	l.set_rgb( 128, 128, 128 );
	l.align = Align.Right;
	l.style = Style.Bold;

	local l = fe.add_text( "[ListEntry]/[ListSize]", 1130, 12, 280, 25 );
	l.set_rgb( 255, 165, 0 );
	l.align = Align.Left;
	l.style = Style.Bold;

////////////////////////////////
//
//  Game Details
//
////////////////////////////////
	
	// FylerArt
	local fyler_sur = fe.add_surface( 392,521);
	local fylerart = FadeArt( my_config["flyer_art"], 0, 0, fyler_sur.width, fyler_sur.height, fyler_sur );
	fylerart.preserve_aspect_ratio= true;
	fylerart.trigger = Transition.EndNavigation;
	fyler_sur.set_pos( 25, 87);
	
	// ESRB Rating	
    local esrb = {
        //filename : [ match1, match2 ]
        "teen": [ "teen" ],
        "everyone_10": [ "everyone_10" ],
        "everyone": [ "everyone" ],
        "mature": [ "mature" ]
    }
	local esrb_sur = fe.add_surface(60,81);
	local esrb_image = esrb_sur.add_image("images/esrb/unknown.png",0,0,60,81);
//	esrb_image.x = 340;
	esrb_sur.x = 40;
	esrb_sur.y= 512;
	changingImage( esrb_image, esrb, "esrb", Info.Tags  );

	// Title
	local l = fe.add_text("[Title]", DETAILS_LEFT_ALIGNMENT-10, 87, 810, 35 );
	l.set_rgb( 255, 255, 255 );
	l.align = Align.Left;
	l.style = Style.Bold;
	l.charsize = 35;

	// Year / Manufacturer 
	local l = fe.add_text( "[Year] ©[Manufacturer]", DETAILS_LEFT_ALIGNMENT, 87 + 40, 810, 25 );
	l.set_rgb( 255, 255, 255 );
	l.align = Align.Left;
	//l.style = Style.Bold;
	l.charsize = 18;

	//History.Dat text
	 local history =fe.add_text("", 442,188,810,290)
	history.charsize = 18;
	history.align = Align.Left;
	history.word_wrap = true;
	history.msg = "[!get_hisinfo]";
	local old_tick=0;

	function historynav( tick_time ) 
	{
	if (fe.overlay.is_up==false)
		{
			if (fe.get_input_state("Left")==true)
			{

				fe.signal("up");
			}
			if (fe.get_input_state("Right")==true)
			{
				fe.signal("down");
			}

			if (fe.get_input_state("Up")==true)
			{
				if ((old_tick+SPIN_MS) < tick_time)
				{
					history.first_line_hint--;
					old_tick=tick_time;
				}
				
			}
			if (fe.get_input_state("Down")==true)
			{
				if ((old_tick+SPIN_MS) < tick_time)
				{
					history.first_line_hint++;
					old_tick=tick_time;
				}
			}
		}
	}
	if (horizontalNavigation=="YES")
	{
		fe.add_ticks_callback("historynav");
	}

	// Total PLAYED
 	local detailsNewX= DETAILS_LEFT_ALIGNMENT;
	local l = fe.add_image("images/mainmenu/infoBackground.png");
	l.x = detailsNewX;
	l.y = DETAILS_BOTTOM_ALIGNMENT;
	local t = fe.add_text("PLAYED:", detailsNewX, DETAILS_BOTTOM_ALIGNMENT+5, 125, 22)
	t.set_rgb( 255, 255, 255 );
	t.align = Align.Left;
	t.style = Style.Bold;
	local t = fe.add_text("[PlayedCount]", detailsNewX+86, DETAILS_BOTTOM_ALIGNMENT+5, 125, 22)
	t.set_rgb( 255, 165, 0 );
	t.align = Align.Left;
	t.style = Style.Bold;
	detailsNewX = detailsNewX + DETAILS_INFO_TAG_WIDTH + DETAILS_INFO_TAG_OFFSET;
 

	// Max Players
 	local l = fe.add_image("images/mainmenu/infoBackground.png");
	l.x = detailsNewX;
	l.y = DETAILS_BOTTOM_ALIGNMENT;
	local p = fe.add_text("[Players]", detailsNewX+10, DETAILS_BOTTOM_ALIGNMENT+5 , 125, 22);
	p.set_rgb( 255, 165, 0 );
	p.align = Align.Left;
	p.style = Style.Bold; 
	local p = fe.add_text("PLAYER", detailsNewX+28, DETAILS_BOTTOM_ALIGNMENT+5 , 125, 22);
	p.set_rgb( 255, 255, 255 );
	p.align = Align.Left;
	p.style = Style.Bold;
	detailsNewX = detailsNewX + DETAILS_INFO_TAG_WIDTH + DETAILS_INFO_TAG_OFFSET;

	// Genre	
    local genre = {
        //filename : [ match1, match2 ]
        "action": [ "action" ],
        "adventure": [ "adventure" ],
        "fighter": [ "fighting", "fighter", "beat'em up" ],
        "platform": [ "platformer", "platform" ],
        "puzzle": [ "puzzle" ],
        "racing": [ "racing", "driving" ],
        "rpg": [ "rpg", "role playing", "role playing game" ],
        "shooter": [ "shooter", "shmup" ],
        "sports": [ "sports", "boxing", "golf", "baseball", "football", "soccer" ],
		"maze": [ "maze" ],
        "strategy": [ "strategy"]
    }
	local genre_image = fe.add_image("images/genre/unknown.png");
	genre_image.x = detailsNewX;
	genre_image.y= DETAILS_BOTTOM_ALIGNMENT;
	changingImage( genre_image, genre, "genre", Info.Category );
	
	detailsNewX = detailsNewX + DETAILS_INFO_TAG_WIDTH + DETAILS_INFO_TAG_OFFSET;


	// WheelArt
	local wheelart_sur = fe.add_surface( 300 ,150);
	local wheelart = FadeArt( my_config["wheel_art"], 0, 0, wheelart_sur.width ,wheelart_sur.height , wheelart_sur );
	wheelart.preserve_aspect_ratio= true;
	wheelart.trigger = Transition.EndNavigation;
	wheelart_sur.set_pos( 970, DETAILS_BOTTOM_ALIGNMENT - (wheelart_sur.height /2));

////////////////////////////////
//
//  TV Set Slider
//
////////////////////////////////

	// TV Set Sliders
	// Initialize the artworks with selection at the top
	// of the draw order
	local sats = [];
	for ( local i=0; i < num_sats  / 2; i++ )
	{
		sats.append( Satellite() );
	}


	for ( local i=0; i < ( num_sats + 1 ) / 2; i++ )
		sats.insert( num_sats / 2, Satellite() );


	//
	// Initialize a conveyor to control the artworks
	//
	local orbital = Conveyor();
	orbital.transition_ms = SPIN_MS;
	orbital.transition_swap_point = 1.0;
	orbital.set_slots(sats);

////////////////////////////////////////
//
//Configure Custom Menu
//
///////////////////////////////////////
	// Overall Surface
	local overlaySurface = fe.add_surface(1280,1024);
	overlaySurface.visible = false;
	
	// translucent background
	local overlayBackground = overlaySurface.add_image("images/overlaymenu/black.png",0,0,1280,1024);
	overlayBackground.alpha = 225;
	
	// create extra surface for the menu
	local overlayMenuSur = overlaySurface.add_surface(322,328);
	overlayMenuSur.set_pos(480,359);
	overlayMenuSur.add_image("images/overlaymenu/menuframe.png",0,40,321,256); // Add the menu frame
	local overlay_lb = overlayMenuSur.add_listbox(1,40,320,256); //Add the listbox
	overlay_lb.rows = 6; // the listbox will have 6 slots
	overlay_lb.charsize  = 22;
	overlay_lb.set_rgb( 128, 128, 128 );
	overlay_lb.sel_style = Style.Bold;
	overlay_lb.set_sel_rgb( 255, 255, 255 );
	overlay_lb.set_selbg_rgb( 255, 165, 0 );
	local overlayMenuTitle = overlayMenuSur.add_text("[DisplayName]",0,0,322,35); //Add the menu title
	overlayMenuTitle.charsize=30;
	overlayMenuTitle.style = Style.Bold;
	overlayMenuTitle.set_rgb(255,165,0);

	//clone the menu surface for the bartop picture
	overlaySurface.add_image("images/overlaymenu/black.png",330,480,100,240);
	local overlayClone = overlaySurface.add_clone(overlayMenuSur);
	overlayClone.set_pos(354,559,102,90);
	overlayClone.skew_x=12;
	overlayClone.pinch_y=8;
	overlayClone.alpha=250;
	local overlayBartop = overlaySurface.add_image("images/overlaymenu/menuBartop.png"); //add the bartop picutre
	overlayBartop.set_pos(300,480);
	
	// Show the up time
	local ut = overlaySurface.add_text( "ELASPED TIME: ", 460, 655, 280, 24 );
	ut.set_rgb( 128, 128, 128 );
	ut.align = Align.Right;
	ut.charsize=15;
	
	local ut = overlaySurface.add_text( "", 725, 655, 280, 25 );
	ut.set_rgb( 255, 165, 0 );
	ut.align = Align.Left;
	ut.charsize=15;
	
	// Function to update the time
	function update_uptime( ttime )
	{
		local mil = fe.layout.time;
		local seconds = ((mil / 1000) % 60) ;
		local minutes = ((mil / (1000*60)) % 60);
		local hours   = ((mil / (1000*60*60)) % 24);
		//ut.msg= hours+":"+minutes+":"+seconds;
				ut.msg = format("%02d", hours ) + ":" + format("%02d", minutes) + ":" + format("%02d", seconds ) 
	}
	fe.add_ticks_callback( this, "update_uptime" );
	
	// tell Attractmode we are using a custom overlay menu
	fe.overlay.set_custom_controls( overlayMenuTitle, overlay_lb );

//
// Set the shader effect if configured
//
if ( my_config["enable_crt"] == "Yes" )
{

//  Bloom shader
/* 	local sh = fe.add_shader( Shader.Fragment,"shaders/bloom_shader.frag" );
	sh.set_texture_param("bgl_RenderedTexture");
	sats[ sats.len() / 2 ].m_obj.snap.shader = sh; */

// CRT Shader
    local sh = fe.add_shader( Shader.VertexAndFragment, "shaders/crt.vert", "shaders/crt.frag" );
	sh.set_param( "rubyInputSize", 640, 480 );
    sh.set_param( "rubyOutputSize", ScreenWidth, ScreenHeight );
    sh.set_param( "rubyTextureSize", 640, 480 );
	sh.set_texture_param("rubyTexture"); 
	sats[ sats.len() / 2 ].m_obj.snap.shader = sh;
}

//
// Add fade effect when moving to/from the layout or a game
//
fe.add_transition_callback( "orbit_transition" );
function orbit_transition( ttype, var, ttime )
{
	switch ( ttype )
	{
	case Transition.EndNavigation: // set the favorite icon
		{
			foreach (o in sats)
			{
				o.m_obj.set_favorite();
			}
		}
		break;
	case Transition.StartLayout:
	case Transition.FromGame:
		if ( ttime < 255 )
		{
			foreach (o in fe.obj)
				o.alpha = ttime;

			return true;
		}
		else
		{
			foreach (o in fe.obj)
				o.alpha = 255;
		}
		break;

	case Transition.EndLayout:
	case Transition.ToGame:
		if ( ttime < 255 )
		{
			foreach (o in fe.obj)
				o.alpha = 255 - ttime;

			return true;
		}
		else
		{
			local old_alpha;
			foreach (o in fe.obj)
			{
				old_alpha = o.alpha;
				o.alpha = 0;
			}

			if ( old_alpha != 0 )
				return true;
		}

		break;
		
 	case Transition.ShowOverlay:
		overlaySurface.visible = true;
		if ( ttime < 255 )
		{
			overlaySurface.alpha = ttime;
			return true;
		}
		else
		{
				overlaySurface.alpha = 255;
		}
		break;
		
	case Transition.HideOverlay:
		if ( ttime < 255 )
		{
			overlaySurface.alpha = 255 - ttime;
			return true;
		}
		else
		{
			local old_alpha;
				old_alpha = overlaySurface.alpha;
				overlaySurface.alpha = 0;

			if ( old_alpha != 0 )
				return true;
		}
		overlaySurface.visible = false;
		break;

	}
	return false;
}
