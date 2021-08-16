/// @description Insert description here
// You can write your code in this editor
if(hp_ == 0){
	instance_destroy(id);
}

if(global.player_id_ == collision_rectangle(x - aggro_range_ / 2, y - aggro_range_ / 2, x + aggro_range_ / 2, y + aggro_range_ / 2, obj_player, false, true))
{
	var _path = point_direction(x, y, obj_player.x, obj_player.y)
	x = x + lengthdir_x(spd_, _path);
	y = y + lengthdir_y(spd_, _path);
	
	if(_path <= 90 or _path >= 270){
	image_xscale = 1;
	}else{
	image_xscale = -1;
	}

}


