/// @description Insert description here
// You can write your code in this editor

if(keyboard_check(vk_space) == true and init_done_ == false){
	room_goto(rm_game);
	init_done_ = true;
}

if(global.portal_reached_ == true){
	room_goto(rm_game);
	global.portal_reached_ = false;
}

if(global.player_death_ == true){
	global.player_death_ = false;
	global.ammo_count_ = 5;
	global.hp_ = 100;
	init_done_ = false;
	room_goto(rm_menu);
}

