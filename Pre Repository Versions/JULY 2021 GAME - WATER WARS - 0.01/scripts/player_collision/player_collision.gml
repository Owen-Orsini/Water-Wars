// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_collision()
{
	
var _collision = false;


// Horizontal Tiles
if(tilemap_get_at_pixel(tilemap_, x + hsp_, y) > 0)
{
	x -= x mod CELL_WIDTH;
	if (sign(hsp_) == 1) x += CELL_WIDTH - 1;
	hsp_ = 0;
	_collision = true;

}

//Horizontal Move Commit
x += hsp_;

// Vertical Tiles
if(tilemap_get_at_pixel(tilemap_, x, y + vsp_) > 0)
{
	y -= y mod CELL_WIDTH;
	if (sign(vsp_) == 1) y += CELL_WIDTH - 1;
	vsp_ = 0;
	_collision = true;

}

// Vertical Tiles
y += vsp_;


return _collision;

}