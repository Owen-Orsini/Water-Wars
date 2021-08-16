/// @description Insert description here
// You can write your code in this editor
#macro view view_camera[0]

camera_set_view_size(view, view_width_, view_height_);

if(instance_exists(obj_player)){
	var _x = clamp(obj_player.x + x_off_ - view_width_/2, CELL_WIDTH, room_width - view_width_ - CELL_WIDTH);
	var _y = clamp(obj_player.y + y_off_ -view_height_/2, CELL_HEIGHT, room_height - view_height_ - CELL_HEIGHT);
	
	
	
	var _cur_x = camera_get_view_x(view);
	var _cur_y = camera_get_view_y(view);
	
	var _spd = .1;
	
	camera_set_view_pos(view,
						lerp(_cur_x, _x, _spd),
						lerp(_cur_y, _y, _spd));
}
