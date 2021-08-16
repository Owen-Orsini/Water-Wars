/// @description Insert description here
// You can write your code in this editor
if(place_meeting(x, y, obj_player)){
	global.hp_ = clamp(global.hp_ + heal_, 0, 100);
	instance_destroy(id);
}