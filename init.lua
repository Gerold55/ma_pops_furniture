ma_pops_furniture = {}

dofile(minetest.get_modpath('ma_pops_furniture')..'/bathroom.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/bedroom.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/kitchen.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/living_room.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/dining_room.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/outside.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/misc.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/oven.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/joyb.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/stereo.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/sofa.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/tv.lua')


--GreenDimond's code from waffle mod
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

ma_pops_furniture.intllib = S
dofile(minetest.get_modpath('ma_pops_furniture')..'/toaster.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/intllib.lua')