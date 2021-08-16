/// @description Insert description here
// You can write your code in this editor
#region Inputs
#macro I_RIGHT ord("D")
#macro I_LEFT ord("A")
#macro I_UP ord("W")
#macro I_DOWN ord("S")
#macro I_SHOOT mb_left
#endregion

global.player_id_ = id;

invuln_timer_ = 0;
invuln_duration_ = 60;

spd_ = 3;

vsp_ = 0;
hsp_ = 0;

input_direction_ = 0;
input_magnitude_ = 0;

sling_frame_ = 0;
charge_ = 0;

charging_ = false;
charge_final_ = 0;

sling_x_ = 0;
sling_y_ = 0;
sling_angle_ = 0;
balloon_dmg_ = 0;
balloon_spd_ = 0;

tilemap_ = layer_tilemap_get_id("WallTiles");

image_speed = 0.5



//shooting variables
charge_range_ = [0, 20, 35, 40, 60];

// @0 & @1 = the range in which the modifier is in effect
// @2 & @2 = the range of damage possible within modifier
range_slow_ = [1, 5];
range_good_ = [40, 60];
range_perfect_ = [100, 100];

//misfire damage is dealt to the player character
range_misfire_ = [-5, -10];