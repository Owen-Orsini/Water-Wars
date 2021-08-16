/// @description Insert description here
// You can write your code in this editor
if(place_meeting(x, y, obj_player)){
	global.ammo_count_ = clamp(global.ammo_count_ + refill_, 0, global.max_ammo_);
	instance_destroy(id);
}