/// @description Insert description here
// You can write your code in this editor
view_width_=1440/5;
view_height_=1080/5;

global.window_scale_=4;

//x_off_ = sprite_get_width(sp_player) / 2;
//y_off_ = sprite_get_height(sp_player) / 2;

x_off_ = 0;
y_off_ = 0;

window_set_size(view_width_*global.window_scale_, view_height_*global.window_scale_);
alarm[0] = 1;

surface_resize(application_surface, view_width_ *global.window_scale_, view_height_*global.window_scale_);

