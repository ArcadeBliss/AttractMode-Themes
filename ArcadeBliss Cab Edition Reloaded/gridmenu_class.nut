//////////////////////////////////////////////////
//
//	Define the Conveyour object used for
//  Displays and Filters
//
//////////////////////////////////////////////////

	class MenuList extends Conveyor
	{	
		menu_type = null; // configure the type of menu object this is references (type{})
		surface = null;   // surface to hold menu list items 
		surface_y = null; // holds original surface height for animations
		// frame selection box settings 
		ui_frame_img = null; // the selection frame
		ui_sel_x = null;  // x-coordinate of the frame
		ui_sel_y = null;  // y-coordinate of the frame
		
		// Misc. Settings
		// m_objs: the array contanining the slots
		ui_click = null; 	// toggle navigation click sound 
		menu_cols = null;		// number of columns
		menu_rows = null;		// number of rows
		menu_height = null; 	// height of the gamelist or menu
		
		// navigational variables
		menu_name = null; 		// menu_name of the current menu
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
		
		// handle fake transitions for menu
		running = false; // is the transition loop running?
		start_time = -1; // the start time of the loop transition
		end_time = 0; // the endtime of the loop transition
		movement = 0; // the amount of items to move when transitioning
		
		constructor(name, ttime, menu_switch)
		{
			menu_name = name;
			ui_sel_x = 0;
			ui_sel_y = 0;
			transition_ms = ttime;
			nav_change = false;
			
			// listen for ticks to handle the fake transition
			fe.add_ticks_callback( this, "ticks_callback" )
			menu_type = menu_switch; // set the variables for the grid
		}
		
		

		
		// function updates the fake transition movement 
		function update_conveyour(tickstime)
		{
			if ((running) && (start_time == -1))
			{
				start_time = tickstime;
				end_time = transition_ms + start_time;
				// start the update
				//	debug("update_conveyour: start_transition:"+movement);
				on_transition(Transition.ToNewSelection, movement , 0);
			
				return;
			}
				// stop updating the transition
			if ((running) && (end_time < tickstime))
			{
				start_time = -1;
				running = false;
				// have to do one last transition to tell the transition to stop
				on_transition(Transition.ToNewSelection, movement, tickstime - start_time );
			//	debug("update_conveyour: stop_transition");
				return;
			}	else {
			//	debug("update_conveyour: update_transition");
				on_transition(Transition.ToNewSelection, movement, tickstime - start_time );
			}
		}
		

		// starts the fake transition 
		function start_transition(var)
		{
			if (running)
				return;
				
			movement = var;
			running = true;
		//	debug("start_transition:"+ movement +" "+ running);
			
		}
		
		// handles moving the fake transiton lists if enabled
		function move_list(direction = "right", amount = 1 )
		{

			switch (direction)
			{
				case "adjust":
					amount += menu_type.list_index;
					menu_type.list_index = (amount > menu_type.total - 1 ) ? amount % menu_type.total : amount;
					break;
				case "right":
					menu_type.list_index += amount;
					menu_type.list_index = (menu_type.list_index > menu_type.total -1 ) ? menu_type.list_index % menu_type.total : menu_type.list_index;
					start_transition(amount)
					break;
				case "left":
					menu_type.list_index -= amount;
					menu_type.list_index = (menu_type.list_index < 0) ? (menu_type.total) - (abs(menu_type.list_index) % menu_type.total) : menu_type.list_index
					start_transition(amount * -1)
					break;
			}
		}
		
		function update_frame()
		{		
			
			local click = fe.add_sound("assets/sounds/selectclick.mp3"); // load wheel click sound
			click.playing = true; // play the navigation click if configured 

			animation.add( PropertyAnimation( ui_frame_img, 
			{   
				property = "position",
				tween = Tween.Linear, 
				end = { 
						x = surface.x + m_objs[get_sel()].orig_x - (m_objs[get_sel()].item_width * ENLARGE)/2, 
						y = surface_y + m_objs[get_sel()].orig_y - (m_objs[get_sel()].item_height * ENLARGE)/2
				}, 
				time = transition_ms
			} ) );	
		}
		
		function do_correction()
		{
			// local corr = get_sel() - selection_index;
			// debug("selection index:" +selection_index + " get_sel" + get_sel())
			foreach ( o in m_objs )
			{
			//	local idx = o.m_art_img.index_offset - corr;
				local idx = o.m_num
				o.m_art_img.index_offset = idx;
			}
		}
		
		function activate()
		{
			m_objs[get_sel()].grow()
			ui_frame_img.alpha = 255;
			
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
				end = menu_height,
				time = 600,
			} ) );
		}	
			
		
		function deactivate()
		{
			m_objs[get_sel()].shrink()
			ui_frame_img.alpha = 0;				
	
			// create squeeze out animate for the menu
			animation.add( PropertyAnimation( surface,
				{   
					property = "height",
					tween = Tween.Expo,
					easing = Easing.Out,
					start = menu_height,
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
		
		// get the current position of the frame (is the same index for the snap under the frame)
		function get_sel()
		{	
			
			return ( ui_sel_x * menu_rows + ui_sel_y );
		}
		
		function selected_item()
		{
			local temp = menu_type.list_index + (get_sel()-selection_index);
			local temp2 = null;
			local result = null;
			local file = null;
			
			if (temp < 0)
			{
				temp2 = (menu_type.total - (abs(temp) % menu_type.total));
				result = (temp2 < menu_type.total) ? temp2 : 0;

			}	
			else
				result = (temp > menu_type.total -1 ) ? temp % (menu_type.total) : temp;	
				
			return result;	
		}
		
		// logic used to move the frame
		function move_frame( direction )
		{
		
			switch ( direction )	
			{
			case "left":
				if ( ui_sel_x > 0 ) 
				{
					m_objs[get_sel()].shrink();
					ui_sel_x--;
					update_frame();
					m_objs[get_sel()].grow();
				}
				else
				{
					m_objs[get_sel()].shrink();
					transition_swap_point=0.3;
					do_correction();
					move_list(menu_type.left, stride);
					m_objs[get_sel()].grow();
				}
				
				return true;
				break;
				
			case "right":
				if ( ui_sel_x < menu_cols - 1 ) 
				{
					m_objs[get_sel()].shrink();
					ui_sel_x++;
					update_frame();
					m_objs[get_sel()].grow();
				//	ui_frame_img.zorder = m_objs[get_sel()].m_art_img.zorder +1;
				}
				else
				{					
					m_objs[get_sel()].shrink();
					transition_swap_point=0.3;
					do_correction();
					move_list(menu_type.right, stride);
					m_objs[get_sel()].grow();
				}
				
				return true;
				break;
				
			case "up":
				transition_swap_point=0.0;
				if ( ui_sel_y > 0 ) 
				{
					m_objs[get_sel()].shrink();
					ui_sel_y--;
					update_frame();
					m_objs[get_sel()].grow();
				}
				else
				{
					return false;
				}
				return true;
				break;
				
			case "down":
				transition_swap_point=0.0;
				if ( ui_sel_y < menu_rows - 1 ) 
				{
					m_objs[get_sel()].shrink();
					ui_sel_y++;
					update_frame();
					m_objs[get_sel()].grow();
				}
				else
				{
					return false;
				}
				return true;
				break;
				
			case "back":					
				nav_change = true;
				nav_change_to = nav_back;
				return false;
				break;
				
			case "select":
				
				local choice = selected_item();
				reset_index();	
				menu_type.choice(choice);
				nav_change = true;
				nav_change_to = nav_back;
				return false;
				break;
			
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
		
			move_list("adjust", frame_index - selection_index);

			set_selection( frame_index );
			update_frame();
			
			enabled=true; // re-enable conveyor
		}
		
		//handle ticks for all animations
		function ticks_callback(ttime)
		{
		   if (running) { 
			update_conveyour(ttime)
			}	
		
		   return
		}
		
		// Internal swap function used in on_transition()
		function _swap( var, adjust )
		{
			local a = ( stride < abs( var ) ) ? stride : abs( var );

			if ( var < 0 )
			{
				for ( local i=0; i < a; i++ )
					m_objs[ m_objs.len() - a + i].set_index_offset(
						m_objs[i].m_base_io); // removed adjustment function

				for ( local i=m_objs.len()-1; i>=a; i-- )
					m_objs[i].swap( m_objs[i-a] );
			}
			else
			{
				for ( local i=0; i < a; i++ )
					m_objs[i].set_index_offset(
						m_objs[m_objs.len() - a + i].m_base_io ); // removed adjustment function

				for ( local i=0; i < m_objs.len()-a; i+=1 )
					m_objs[i].swap( m_objs[i+a] );
			}
		}
		
	}
	
///////////////////////////////////
//
//  Define Menulist Conveyour Slots
//
///////////////////////////////////
	class MenuListSlot extends ConveyorSlot
	{
		m_num = null;
		current_index = null;
		m_shifted = false;
		m_art_img = null;
		initial_start = null;
		menu_type = null;
		item_width = null;
		item_height = null;
		item_padding = null;
		startpostion = null;
		menu_height = null;
		menu_width = null;
		slot_rows = null;
		slot_cols = null;
		menulist = null;
		menu_type = null;
		sel_status = false;
		orig_x = null;
		orig_y = null;
		
		constructor( num )
		{
			
			m_num = num;
			initial_start = true;
			base.constructor();
		}
		
		function grow()
		{
			sel_status = true;
//			activateBloom();
			m_art_img.zorder = 100;
			animation.add( ScaleWidthHeight( this.m_art_img, 
			{   
				property = "scale",
				tween = Tween.Linear, 
				end = { 
					w = item_width + (item_width * ENLARGE) - item_padding, 
					h = item_height + (item_height * ENLARGE) - item_padding 
				}, 
				time = transition_ms 
			} ) );
			
			return;
		}
		
		function shrink()
		{	
			sel_status = false;
			m_art_img.zorder = 0;
//			activateBloom();
			animation.add( ScaleWidthHeight( this.m_art_img, 
			{   
				property = "scale",
				tween = Tween.Linear, 
				end = { 
					w = item_width - item_padding, 
					h = item_height - item_padding 
				}, 
				time = transition_ms 
			} ) );
			
			return;
		}
		
		function get_artwork(offset){
			local temp = menu_type.list_index + offset;
			local temp2 = null;
			local result = null;
			local file = null;
			
			if (temp < 0)
			{
				temp2 = (menu_type.total - (abs(temp) % menu_type.total));
				result = (temp2 < menu_type.total) ? temp2 : 0;

			}	
			else
				result = (temp > menu_type.total -1 ) ? temp % (menu_type.total) : temp;
			
			file = menu_type.filename(result);
			current_index = result;
			return file;
		}
		
		function on_progress( progress, var )
		{
			if ( var == 0 )
				m_shifted = false;

				local r = m_num % slot_rows;
				local c = m_num / slot_rows;
			
			if ( abs( var ) < slot_rows )
			{
				if (sel_status != true)
				{
					m_art_img.x = (c * item_width)  + ((menu_width - (item_width*slot_rows))/2);
					m_art_img.y = startpostion + menu_height * ( progress * slot_cols - c ) ;
				
				} else {
					
					m_art_img.x = (c * item_width) + ((menu_width - (item_width*slot_rows))/2) - ((item_width * ENLARGE)/2);
					m_art_img.y = startpostion + menu_height * ( progress * slot_cols - c ) - (item_height * ENLARGE / 2);
				
				}
			} else {
				local prog = menulist.transition_progress;
				if ( prog > menulist.transition_swap_point )
				{
					if ( var > 0 ) c++;
					else c--;
				}

				if ( var > 0 ) prog *= -1;

				m_art_img.x = ( c + prog ) * item_width  + ((menu_width - (item_width*slot_rows))/2);
				m_art_img.y = (startpostion + r * item_height);
			}
				
			if (orig_x == null)
			{
				orig_x = (c * item_width ) + (( menu_width - ( item_width * slot_rows ))/2);
				orig_y =  startpostion + menu_height * ( progress * slot_cols - c )
			}
		}

		function swap( other )
		{
	//		debug("MySlot"+ m_num + ":swap")
			m_art_img.swap( other.m_art_img );
		}

		function set_index_offset( io )
		{

		//	 debug("MySlot"+ m_num + " set_index_offset: old:" + m_art_img.index_offset +" new:"+ io  )
			 if (m_art_img.index_offset != io)
			 { 
				m_art_img.index_offset = io
				local cur_filename = get_artwork(io)
			
				if (m_art_img.file_name != cur_filename)
				 {
					m_art_img.file_name = cur_filename
				 }
			 }
		}
		function reset_index_offset()
		{
			// debug("MySlot"+ m_num + " reset_index_offset: old-" + m_art_img.index_offset +" new-"+ m_base_io  )
			m_art_img.index_offset = m_base_io ;
			if (initial_start)
			{
				local cur_filename = get_artwork(m_base_io)
				m_art_img.file_name = cur_filename;
				initial_start = false;
			}
		}
		
	}
