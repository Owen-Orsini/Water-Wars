/// @description Map Setup

randomize();
#region Control Variables
var _steps = 450; //number of steps controller can take
var target_level_size = 0;
var real_level_size = 0;
var _direction_change_odds = 2; //odds of changing direction, this number being the topend of a range to zero, direction only changing if it is this num, so 1 would be 50%, 2 would be 33%, and so on
var _target_ammo_pickups = irandom_range(1, 2);
var _target_health_pickups = irandom_range(1, 2);// irandom_range(1, 2);
var _target_enemies = irandom_range(3, 5);
var _spawn_zone_radius = 2;

#endregion
#region Grid and Controller set up
var _wall_map_id = layer_tilemap_get_id("WallTiles");
var _debug_map_id = layer_tilemap_get_id("DebugTiles");


// set up grid

width_ = room_width div CELL_WIDTH;	// get num of cells in room
height_ = room_height div CELL_HEIGHT;
grid_ = ds_grid_create(width_, height_); // create grid with desired amount of cells. Contains terrain information
grid_markup_ = ds_grid_create(width_, height_); //create grid with desired amount of cells. Contains other information

ds_grid_set_region(grid_, 0, 0, width_, height_, VOID); // fill grid with void
ds_grid_set_region(grid_markup_, 0, 0, width_, height_, VOID);

// create the controller
var _controller_x = width_ div 2 // create variables that track controller's position, starts in center of grid
var _controller_y = height_ div 2
var _controller_direction = irandom(3);

#endregion
#region Map Generation

repeat	(_steps) {
	grid_[# _controller_x, _controller_y] = FLOOR; //set current tile in grid to floor
	
	// Randomize the direction
	if( irandom(_direction_change_odds) == _direction_change_odds) {
		_controller_direction = irandom(3);
	}
	
	// Move the controller
	var _x_direction = lengthdir_x(1, _controller_direction * 90) //  change in movement
	var _y_direction = lengthdir_y(1, _controller_direction * 90) 
	_controller_x += _x_direction;
	_controller_y += _y_direction;
	
	// Make sure we don't go outside the grid
	if (_controller_x < 2 || _controller_x >= width_ - 2)	{	//if within 2 blocks of grid boundary. 2 blocks are left empty so that the edge blocks can be iterated through for tiling
		
		_controller_x += - _x_direction * 2;					//move away from boundary 2 blocks
	}
	if (_controller_y < 2 || _controller_y >= height_ - 2)	{
		_controller_y += - _y_direction * 2;
	}
}
#endregion
#region Map Cleanup
for	(var _y = 1; _y < height_ -1; _y++)	{
	for(var _x = 1; _x < width_ -1; _x++)	{
		if	(grid_[# _x, _y] != FLOOR) {
			var _north_tile = grid_[# _x, _y-1] == VOID; //returns 1 if tile in direction is void, 0 if not
			var _west_tile = grid_[# _x-1, _y] == VOID;
			var _east_tile = grid_[# _x+1, _y] == VOID;
			var _south_tile = grid_[# _x, _y+1] == VOID;
			
			// remove any 1x1 gaps in level
			var _tile_index = NORTH * _north_tile + WEST * _west_tile + EAST * _east_tile + SOUTH * _south_tile + 1;
			if (_tile_index == 1){
				grid_[# _x, _y] = FLOOR;
				
			
			}
		}
	}
}
#endregion
#region Bitmasking/Wall Generation
for	(var _y = 1; _y < height_ -1; _y++)	{	// Bitmasking
	for(var _x = 1; _x < width_ -1; _x++)	{
		if	(grid_[# _x, _y] != FLOOR) {
			var _north_tile = grid_[# _x, _y-1] == VOID;
			var _west_tile = grid_[# _x-1, _y] == VOID;
			var _east_tile = grid_[# _x+1, _y] == VOID;
			var _south_tile = grid_[# _x, _y+1] == VOID;
			
			var _tile_index = NORTH * _north_tile + WEST * _west_tile + EAST * _east_tile + SOUTH * _south_tile + 1;
			tilemap_set(_wall_map_id, _tile_index, _x, _y);
			
		}
	}
}
#endregion
#region Map Markup

var _total_deadend_tiles = 0;
var _total_open_tiles = 0;

for	(var _y = 1; _y < height_ -1; _y++)	{
	for(var _x = 1; _x < width_ -1; _x++)	{
		if	(grid_[# _x, _y] != VOID) {
			var _north_tile = grid_[# _x, _y-1] == FLOOR; //returns 1 if tile in direction is void, 0 if not
			var _west_tile = grid_[# _x-1, _y] == FLOOR;
			var _east_tile = grid_[# _x+1, _y] == FLOOR;
			var _south_tile = grid_[# _x, _y+1] == FLOOR;
			
			var _tile_index = NORTH * _north_tile + WEST * _west_tile + EAST * _east_tile + SOUTH * _south_tile;
			// Identifies and counts deadend tiles
			if (_tile_index == 1 or _tile_index == 2 or _tile_index == 4 or _tile_index == 8){
				grid_markup_[# _x, _y] = DEADEND;
				_total_deadend_tiles++;
			}
			// Identifies and counts open tiles
			if (_tile_index == 15 or _tile_index == 7 or _tile_index == 11 or _tile_index == 13 or _tile_index == 14){
				grid_markup_[# _x, _y] = OPEN;
				_total_open_tiles++;
				
			
			}
		}
	}
}


#endregion
#region Map Population (Deadend)

//THIS CODE IS TERRIBLE
if(_total_deadend_tiles >= 2)	{

	//Generate Player at first possible deadend
	for	(var _y = 1; _y < height_ -1; _y++)	{
		for(var _x = 1; _x < width_ -1; _x++)	{
			if(grid_markup_[# _x, _y] == DEADEND and instance_exists(obj_player) == false){
				
				instance_create_layer((_x*CELL_WIDTH) + 16, (_y*CELL_HEIGHT) + 16, "Player", obj_player);
				_total_deadend_tiles--;
				grid_markup_[# _x, _y] = OCCUPIED;
				
				for(var _yy = _y - _spawn_zone_radius; _yy <= _y + _spawn_zone_radius; _yy++){
					for(var _xx = _x - _spawn_zone_radius; _xx <= _x + _spawn_zone_radius; _xx++){
						if(grid_[# _xx, _yy] != VOID and grid_markup_[# _xx, _yy] != DEADEND){
							if(grid_markup_[# _xx, _yy] == OPEN){
								_total_open_tiles--;
							}
							grid_markup_[# _xx, _yy] = OCCUPIED;
						}
					}
				}
			
			}
		}
	}
	//Generate Portal at last possible deadend
	for	(var _y = height_ - 1; _y > 1; _y--)	{
		for(var _x = width_ -1; _x > 1; _x--)	{
			if(grid_markup_[# _x, _y] == DEADEND and instance_exists(obj_portal) == false){
				instance_create_layer(_x*CELL_WIDTH, (_y*CELL_HEIGHT), "Instances", obj_portal);
				grid_markup_[# _x, _y] = OCCUPIED;
				_total_deadend_tiles--;
			
			}
		}
	}

	while(true){
		for	(var _y = 1; _y < height_ -1; _y++)	{
			for(var _x = 1; _x < width_ -1; _x++)	{
				// if there are available deadend tiles left and the current tile is a deadend
				if	(_total_deadend_tiles > 0 and grid_markup_[# _x, _y] == DEADEND) {
					// if a random number ranging from 0 to the total num of deadend tiles equals 0
					if(irandom(_total_deadend_tiles) == 0)	{
						//if target ammo pickups is greater than zero AND a random number ranging from 0 to 1 equals 1
						if(_target_ammo_pickups > 0 and irandom(1) == 1)	{
							instance_create_layer(_x*CELL_WIDTH, _y*CELL_HEIGHT, "Pickups", obj_ammo_pickup);
							_target_ammo_pickups--;
							_total_deadend_tiles--;
							grid_markup_[# _x, _y] = OCCUPIED;
						//if target health pickups is greater than zero	
						}else if(_target_health_pickups > 0)	{
							instance_create_layer(_x*CELL_WIDTH, _y*CELL_HEIGHT, "Pickups", obj_health_pickup);
							_target_health_pickups--;
							_total_deadend_tiles--;
							grid_markup_[# _x, _y] = OCCUPIED;   
						}
					
					}
			
				}
			}
		}
		//if target pickups has been reached or there are no more available deadends, break while loop
		if(_total_deadend_tiles == 0 or (_target_health_pickups + _target_ammo_pickups) == 0){
			break;
		}

	}
}
#endregion
#region Map Population (Open)
if(_total_open_tiles > 0)	{
	while(true){
		for	(var _y = 1; _y < height_ -1; _y++)	{
			for(var _x = 1; _x < width_ -1; _x++)	{
				// if there are available deadend tiles left and the current tile is a deadend
				if	(_total_open_tiles > 0 and grid_markup_[# _x, _y] == OPEN) {
					// if a random number ranging from 0 to the total num of deadend tiles equals 0
					if(irandom(_total_open_tiles) == 0)	{
						//if target ammo pickups is greater than zero AND a random number ranging from 0 to 1 equals 1
						if(_target_enemies > 0)	{
							instance_create_layer(_x*CELL_WIDTH+16, _y*CELL_HEIGHT+24, "Pickups", obj_witch);
							_target_enemies--;
							_total_open_tiles--;
							grid_markup_[# _x, _y] = OCCUPIED;
						}
					
					}
			
				}
			}
		}
		//if target pickups has been reached or there are no more available deadends, break while loop
		if(_total_open_tiles == 0 or _target_enemies == 0){
			break;
		}

	}
}
#endregion 
#region Debug
if(debug_mode == true)	{
	for	(var _y = 1; _y < height_ -1; _y++)	{
		for(var _x = 1; _x < width_ -1; _x++)	{
			
			if	(grid_[# _x, _y] == VOID) {
				tilemap_set(_debug_map_id, 2, _x, _y);
			}
			if	(grid_markup_[# _x, _y] == OPEN)	{
				tilemap_set(_debug_map_id, 1, _x, _y);
			}
			if	(grid_markup_[# _x, _y] == DEADEND)	{
				tilemap_set(_debug_map_id, 3, _x, _y);
			}
			if	(grid_markup_[# _x, _y] == OCCUPIED)	{
				tilemap_set(_debug_map_id, 4, _x, _y);
			}
		}
	}
}
#endregion