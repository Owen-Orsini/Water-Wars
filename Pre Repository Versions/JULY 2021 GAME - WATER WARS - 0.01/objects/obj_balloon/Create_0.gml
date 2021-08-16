/// @description Insert description here
// You can write your code in this editor
active_ = true;
state_ = 0;
dir_ = 0;
spd_ = 0;
range_ = 0;
dmg_ = 0;
tilemap_ = layer_tilemap_get_id("WallTiles");
hsp_ = 0;
vsp_ = 0;
i_ = sprite_get_number(sp_balloon_explode);
image_speed = 0.5;