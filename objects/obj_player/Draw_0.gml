/// @description Insert description here
// You can write your code in this editor
draw_self();
var _ch_percent = charge_ / 60;

sling_frame_ = round(lerp(0, 21, _ch_percent));

if(sling_angle_ < 90 or sling_angle_ > 270){
	draw_sprite_ext(sp_slingshot_low, sling_frame_, sling_x_, sling_y_, 1, 1, sling_angle_, c_white, 1);
	draw_sprite_ext(sp_slingshot_high, sling_frame_, sling_x_, sling_y_, 1, 1, sling_angle_, c_white, 1);
}else{
	draw_sprite_ext(sp_slingshot_low, sling_frame_, sling_x_, sling_y_, 1, -1, sling_angle_, c_white, 1);
	draw_sprite_ext(sp_slingshot_high, sling_frame_, sling_x_, sling_y_, 1, -1, sling_angle_, c_white, 1);
}
//draw_text(x, y - 32, string(charge_));
//draw_text(x, y - 16, string(global.hp_));

if(charging_ == true){
	if(charge_ > charge_range_[3]){
		draw_sprite_stretched(sp_misfire, 0, x - 32 + 2, y - 32, clamp(charge_, 0, charge_range_[4] - 1), 14);
	}
	if(charge_ > charge_range_[2]){
		draw_sprite_stretched(sp_perfect, 0, x - 32 + 2, y - 32, clamp(charge_, 0, charge_range_[3] - 1), 14);
	}
	if(charge_ > charge_range_[1]){
		draw_sprite_stretched(sp_good, 0, x - 32 + 2, y - 32, clamp(charge_, 0, charge_range_[2] - 1), 14);
	}
	if(charge_ > charge_range_[0]){
		draw_sprite_stretched(sp_slow, 0, x - 32 + 2, y - 32, clamp(charge_, 0, charge_range_[1] - 1), 14);
	}

	draw_sprite_stretched(sp_charge_indicator, 0, x - 32 + charge_, y - 36, 4, 24);
	draw_sprite_stretched(sp_charge_border, 0, x - 32, y - 32, 64, 16);
	
	
}
