// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// MAP GENERATION AND TILING
#macro CELL_WIDTH 32
#macro CELL_HEIGHT 32
#macro FLOOR -5
#macro VOID -7

#macro NORTH 1
#macro WEST 2
#macro EAST 4
#macro SOUTH 8

#macro NEUTRAL -9
#macro DEADEND -11	//Floor tile surronded by walls on 3 sides
#macro OPEN -12		//Floor tile surrounded by walls on 1 or 0 sides
#macro OCCUPIED -10

// UTILITY
#macro CENTER_X (x + round(sprite_get_width(id) / 2))
#macro CENTER_Y (y + round(sprite_get_height(id) / 2))