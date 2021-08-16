/// @description Insert description here
// You can write your code in this editor
hsp_ = lengthdir_x(spd_, dir_);
vsp_ = lengthdir_y(spd_, dir_);


if(active_ == true){
	
	
	if((x <= 0 or x >= room_width) or (y <= 0 or y >= room_height)){
		active_ = false;
	}
	
	active_ = !player_collision();
	
	var _enemy_id = instance_place(x, y, obj_enemy);
	
	if( _enemy_id != noone){
		with(_enemy_id){
			hp_ = clamp(hp_ - other.dmg_, 0, 100);
	
		}
		active_ = false;
	}
	
	
}
if(active_ == false){
	sprite_index = sp_balloon_explode;
	
	if(image_index = sprite_get_number(sp_balloon_explode) - 1){
		instance_destroy(id);
	}
	

}