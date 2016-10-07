///////////////////////////////////
//
//  Define GameList Conveyour 
//
///////////////////////////////////	
	class GameList extends Conveyor
	{
		
		menu_type = null;// configure the type of menu object this is references (type{})
	
		surface = null; // surface to hold all of the game informaiton and artwork (and other menus) 
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
		// m_objs: the array contanining the slots
		ui_click = null; 	// toggle navigation click sound 
		menu_width = null; 	// width of the gamelist or menu

		// navigational variables
		name = null; 		// name of the current menu
		nav_down = null; 	// the menu to navigate to based on navigation settings
		nav_up = null; 		//  "" "" "" "" ""
		nav_left = null; 	//  "" "" "" "" ""
		nav_right = null; 	//  "" "" "" "" ""
		nav_back = null; 	//  "" "" "" "" ""
		nav_change = null;  // flag to see if menu should change
		nav_change_to = null; // menu to change to when necessary
		
		// Conveyour settings
		//transition_ms: base frame animation speed
		//stride = null:  determine how many games to skip when fast navigation is active
		
		// handle fake transitions for menu other than the gamelist
		running = false; // is the transition loop running?
		start_time = -1; // the start time of the loop transition
		end_time = 0; // the endtime of the loop transition
		movement = 0; // the amount of items to move when transitioning
		
		slot_rows = null;
		slot_cols = null;
		
		constructor(menu)
		{
			name = menu;
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
							x = m_objs[get_sel()].orig_x, 
							y = m_objs[get_sel()].orig_y
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
			
			m_objs[get_sel()].sel_status = true;
		}
		
		function do_correction()
		{
			local corr = get_sel() - selection_index;
			foreach ( o in m_objs )
			{
				local idx = o.g_art_sur.index_offset - corr;
				o.g_art_sur.rawset_index_offset( idx );
			}
		}
		
		function activate()
		{
	
			m_objs[get_sel()].sel_status = true;
			ui_frame_img.zorder = m_objs[get_sel()].gl_item_sur.zorder +1;
			ui_frame_img.alpha = 255;
			if (name !="gamelist")
			{
			
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
		
			m_objs[get_sel()].sel_status = false;
			ui_frame_img.alpha = 0;
			if (name !="gamelist")
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
			}
		}
		// get the current position of the frame (is the same index for the snap under the frame)
		function get_sel()
		{	
			return ( ui_sel_x * slot_rows + ui_sel_y );
		}
		
		function selected_item()
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
					m_objs[get_sel()].sel_status = false;
//					m_objs[get_sel()].shrink();
					ui_sel_x--;
					update_frame();
//					m_objs[get_sel()].grow();
//					m_objs[get_sel()].sel_status = true;
					ui_frame_img.zorder = m_objs[get_sel()].gl_item_sur.zorder +1;
				}
				else
				{
//					m_objs[get_sel()].sel_status = false;
//					m_objs[get_sel()].shrink();
					transition_swap_point=1.0;
					do_correction();
					fe.signal("prev_page");
//					m_objs[get_sel()].grow();
				}
				
				return true;
				break;
				
			case "right":
				if ( ui_sel_x < slot_cols - 1 ) 
				{
				
					m_objs[get_sel()].sel_status = false;
//					m_objs[get_sel()].shrink();
					ui_sel_x++;
					update_frame();
//					m_objs[get_sel()].grow();
//					m_objs[get_sel()].sel_status = true;
					ui_frame_img.zorder = m_objs[get_sel()].gl_item_sur.zorder +1;
				}
				else
				{					
//					m_objs[get_sel()].sel_status = false;
				//					m_objs[get_sel()].shrink();
					transition_swap_point=1.0;
					do_correction();
					fe.signal("next_page");
//					m_objs[get_sel()].grow();
				}
				
				return true;
				break;
				
			case "up":
				transition_swap_point=0.0;
				if ( ui_sel_y > 0 ) 
				{
//					m_objs[get_sel()].shrink();
					ui_sel_y--;
					update_frame();
//					m_objs[get_sel()].grow();
					ui_frame_img.zorder = m_objs[get_sel()].gl_item_sur.zorder +1;
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
				if ( ui_sel_y < slot_rows - 1 ) 
				{
//					m_objs[get_sel()].shrink();
					ui_sel_y++;
					update_frame();
//					m_objs[get_sel()].grow();
					ui_frame_img.zorder = m_objs[get_sel()].gl_item_sur.zorder +1;
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
			default:
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
				// m_objs[i].on_progress( m_objs[i].m_base_progress, 0 ); // uncomment to remove animation
				
			}
		}
		
		function on_transition( ttype, var, ttime )
		{
			
			switch ( ttype )
			{
			case Transition.FromGame:
				ui_frame_img.alpha = 255; // 
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
	
///////////////////////////////////
//
//  Define Gamelist Conveyour Slots
//
///////////////////////////////////
	class GameListSlot extends ConveyorSlot
	{
		
		g_art_img = null; 			// object's artwork to use for the gamelist
		g_art_sur = null;			// object's artwork surface to use for the gamelist 
		g_bg_img= null; 			// object's game text background found underneath the game artwork (optional)
		g_name_txt=null; 			// object's game name  
		sel_status = null; 			// toggle "currently selected" flag for this object.
		prev_sel_status = null;		// previous sel_status before it changed. Decides if object should be animated.
		g_bloomActive = null;		// toggle the bloom effect for this object
		g_bloomOn = null; 			// Bloom settings when on
		g_bloomOff = null; 			// Bloom settings when off

		menulist = null;
		
		startpostion = null;		// starting y position of the game list
		menu_height = null;			// gamelist height
		menu_width = null; 			// gamelist width

		item_padding = null;		// Padding to place between each game list item
		item_height = null;			// gamelist item height
		item_width = null;			// gamelist item width

		gl_item_sur = null;			// gamelist item surface
		gl_item_zo = null; 			// current zorder of the object		
		num_i = null; 				// the index of the current conveyour slot 
		transition_ms = null; 		// conveyour speed
		favorite_img =  null;		// the favorite icon
		favorite_slot = null		// the slot to find the add / remove in the menu
		borderOn = false;			// flag to show game name border 
		m_shifted = false;
		orig_x = null;
		orig_y = null;
		slot_cols = null; 			// number of columns in the list
		slot_rows = null;			// number of rows in the list
		
		
		
		constructor( num )
		{
						
			num_i = num;
			sel_status = false; 
			g_bloomActive = false;
			
			// set the gamename correctly
			fe.add_transition_callback( this, "update_name" );
			fe.add_ticks_callback(this, "animate_gameitem");

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
			local r = num_i % slot_rows;
			local c = num_i / slot_rows;
			
				animation.add( PropertyAnimation( gl_item_sur, 
				{   
					property = "position",
					tween = Tween.Linear,
					easing = Easing.In,
					start = {
						x = ((menu_width * ( progress * slot_rows - r ) + ((scr_w - menu_width) / 2))),
						y = (scr_h * -1) + (r * item_height)
					},
					end = { 
						x = (c * item_width ) + ((scr_w - menu_width)/2) - ((item_width * ENLARGE)/ slot_cols) - item_padding/2,
						y = startpostion + menu_height * ( progress * slot_cols - c )
					}, 	
					time = transition_ms * 6,
				} ) );										
			
			g_art_img.video_flags = (sel_status) ?  Vid.Default : Vid.NoAudio // turn on the artworks video sound if currently selected
			
			// Record the original x,y positions of the list item
			orig_x = (c * item_width ) + ((scr_w - menu_width)/2) - ((item_width * ENLARGE)/ slot_cols) - item_padding/2;
			orig_y =  (startpostion + menu_height * ( progress * slot_cols - c ));			
		}
		
		function on_progress( progress, var )
		{
			
			local adjust = null;
			if ( var == 0 )
				m_shifted = false;
		
			//Vertical Flow (from grid script)
			 local r = num_i % slot_rows;
			 local c = num_i / slot_rows;
		
			if ( abs( var ) < slot_rows )
			{
				gl_item_sur.x = (c * item_width ) + ((scr_w - menu_width)/2) - ((item_width * ENLARGE)/ slot_cols) - item_padding/2;
				gl_item_sur.y = (startpostion + menu_height * ( progress * slot_cols - c ));
				
			} else {
				local prog = ::menu["gamelist"].transition_progress;
				if ( prog > ::menu["gamelist"].transition_swap_point )
				{
					if ( var > 0 ) c++;
					else c--;
				}

				if ( var > 0 ) prog *= -1;

				gl_item_sur.x = (( c + prog ) * item_width  + ((scr_w - menu_width)/2) - ((item_width * ENLARGE)/ slot_cols) - item_padding/2);
				gl_item_sur.y = (startpostion + r * item_height);
			}
			
			g_art_img.video_flags = (sel_status) ?  Vid.Default : Vid.NoAudio; // turn on the artworks video sound if currently selected
			(sel_status) ? grow() : shrink();
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
			g_art_sur.shader = (g_bloomActive && sel_status) ? g_bloomOn : g_bloomOff;
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
			gl_item_sur.zorder= gl_item_zo + ( slot_rows * slot_cols );

			animation.add( ScaleWidthHeight( this.g_art_sur, 
			{   
				property = "scale",
				tween = Tween.Linear, 
				when = When.Always,
				end = { 
					w = (item_width + item_width * ENLARGE) - item_padding, 
					h = (item_height + item_height * ENLARGE)- item_padding
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
			animation.add( ScaleWidthHeight( this.g_art_sur, 
			{   
				property = "scale",
				tween = Tween.Linear, 
				when = When.Always,
				end = { 
					w = item_width  - item_padding, 
					h = item_height - item_padding
				}, 
				time = transition_ms * 2
			} ) );
			
			return;
		}
		
		function animate_gameitem(ttime)
		{
			
			if (prev_sel_status != sel_status)
			{
				(sel_status) ? grow() : shrink();
				prev_sel_status = sel_status;
			}
			
			
			
			
		}
		// set favorite icon after game transition
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
