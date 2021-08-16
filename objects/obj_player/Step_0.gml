/// @description Insert description here
// You can write your code in this editor
#region Inputs



var _input_shoot = mouse_check_button_pressed(I_SHOOT);
var _mouse_dir = point_direction(x, y, mouse_x, mouse_y);


#endregion
#region Movement & Collisions
input_direction_ =	point_direction(0, 0, 
						keyboard_check(I_RIGHT) - keyboard_check(I_LEFT),
						keyboard_check(I_DOWN) - keyboard_check(I_UP));
input_magnitude_ = (keyboard_check(I_RIGHT) - keyboard_check(I_LEFT) != 0) or (keyboard_check(I_DOWN) - keyboard_check(I_UP) != 0);

hsp_ = lengthdir_x(input_magnitude_ * spd_, input_direction_);
vsp_ = lengthdir_y(input_magnitude_ * spd_, input_direction_);

if(mouse_x > x){
	image_xscale = 1;
}
if(mouse_x < x){
	image_xscale = -1;
}

if(hsp_ == 0 and vsp_ == 0){
	image_index = 0;
	image_speed = 0;
}else{
	image_speed = 0.5;
	if(image_index == 0){
	image_index++;
	}
}

player_collision();

if(place_meeting(x, y, obj_portal)){
	global.portal_reached_ = true;
}

if(place_meeting(x, y, obj_portal)){
	global.portal_reached_ = true;
}

if(invuln_timer_ == 0){
	if(place_meeting(x, y, obj_enemy)){
		global.hp_ = global.hp_ - irandom_range(20, 30);
		invuln_timer_ = invuln_duration_;
	}
}else if(invuln_timer_ > 0){
	invuln_timer_--;
}
if(global.hp_ <= 0){
	global.player_death_ = true;
}
#endregion
#region Slingshot & Firing
sling_x_ = lengthdir_x(12, _mouse_dir) + x;
sling_y_ = lengthdir_y(12, _mouse_dir) + y;
sling_angle_ = point_direction(x, y, mouse_x, mouse_y);

// if you input shoot and are currently charging, you stop charging
// and if you input shoot and are not charging, then you start charging
if(global.ammo_count_ > 0){
	if(_input_shoot == true){
		if(charging_ == true){
			charge_final_ = charge_;
			charge_ = 0;
			charging_ = false;
		}else if(charging_ == false){
				charging_ = true;
		}

	}else{
		if(charging_ == true and charge_ < 60){
			charge_++;
		}
		if(charging_ == true and charge_ == 60){
			charge_final_ = charge_;
			charge_ = 0;
			charging_ = false;
		}

	}
}
if(charge_final_ > 0){
	if(charge_final_ >= charge_range_[0] and charge_final_ < charge_range_[1]){
		balloon_dmg_ = irandom_range(range_slow_[0], range_slow_[1]);
		balloon_spd_ = 2;
		charge_final_ = 0;
	}
	if(charge_final_ >= charge_range_[1] and charge_final_ < charge_range_[2]){
		balloon_dmg_ = irandom_range(range_good_[0], range_good_[1]);
		balloon_spd_ = 10;
		charge_final_ = 0;
	}
	if(charge_final_ >= charge_range_[2] and charge_final_ < charge_range_[3]){
		balloon_dmg_ = irandom_range(range_perfect_[0], range_perfect_[1]);
		balloon_spd_ = 10;
		charge_final_ = 0;
	}
	if(charge_final_ >= charge_range_[3] and charge_final_ <= charge_range_[4]){
		balloon_dmg_ = irandom_range(range_misfire_[0], range_misfire_[1]);
		balloon_spd_ = 0;
		charge_final_ = 0;
	}
}
var _id = 0;
if(balloon_dmg_ != 0){
	
		_id = instance_create_layer(sling_x_, sling_y_, "Balloon", obj_balloon);
		with(_id)
		{
			dmg_ = other.balloon_dmg_;
			dir_ = other.sling_angle_;
			spd_ = other.balloon_spd_;
		}
	if(balloon_dmg_ < 0){
		global.hp_ = clamp(global.hp_ + balloon_dmg_, 0, 100);
		with(_id)
		{
			active_ = false;
		}
	}

	balloon_dmg_ = 0;
	global.ammo_count_ = clamp(global.ammo_count_ - 1, 0, global.max_ammo_);
}



#endregion