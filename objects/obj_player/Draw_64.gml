/// @description Insert description here
// You can write your code in this editor

// Health Bar
var _hp_color = c_green;
var _hp_percent = global.hp_ / global.max_hp_;

if(_hp_percent <= 0.25){
	_hp_color = c_red;
}else if(_hp_percent <= 0.50){
		_hp_color = c_red;
}else if(_hp_percent <= 0.75){
		_hp_color = c_yellow;
}else if(_hp_percent <= 1){
		_hp_color = c_green;
}

draw_sprite_stretched_ext(sp_charge_border, 0, 10, 40, 404, 32, c_white, 0.5);
draw_sprite_stretched_ext(sp_bit, 0, 12, 42, 4*global.hp_, 28, _hp_color, 0.5);
draw_sprite_stretched_ext(sp_hp, 0, 14, 42, 48, 32, c_white, 1);

// Ammo Counter
for(i = 0; i < global.ammo_count_; i++){
	draw_sprite_stretched_ext(sp_balloon, 0, 12 + i * 30, 80, 30, 30, c_white, 1);
}

