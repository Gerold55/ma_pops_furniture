ma_pops_furniture = {}

--GreenDimond's code from waffle mod
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

ma_pops_furniture.intllib = S
dofile(minetest.get_modpath('ma_pops_furniture')..'/intllib.lua')

moditems = {}  -- switcher

if core.get_modpath("mcl_core") and mcl_core then -- means MineClone 2 is loaded, this is its core mod
	moditems.IRON_ITEM = "mcl_core:iron_ingot"   -- MCL version of iron ingot
	moditems.COAL_ITEM = "mcl_core:coalblock" -- MCL version of coal block
	moditems.CORAL_SKELETON = "mcl_nether:quartz_block" -- MCL version of green dye
	moditems.SILVER_SANDSTONE = "mcl_nether:quartz_block" -- MCL version of green dye
	moditems.INVENTORY = "mcl_inventory:crafting_formspec_bg2" -- MCL version of green dye
	moditems.INFOBOX_CAN = {}
	moditems.INFOBOX_DUMP = {}
	moditems.BOXART = "bgcolor[#d0d0d0;false]listcolors[#9d9d9d;#9d9d9d;#5c5c5c;#000000;#ffffff]" -- trying to imitate MCL boxart

else         -- fallback, assume default (MineTest Game) is loaded, otherwise it will error anyway here.
	moditems.IRON_ITEM = "default:steel_ingot"    -- MTG iron ingot
	moditems.COAL_ITEM = "default:coalblock"      -- MTG coal block
	moditems.CORAL_SKELETON = "default:coral_skeleton" -- MCL version of green dye
	moditems.SILVER_SANDSTONE = "default:silver_sandstone" -- MCL version of green dye
	moditems.INVENTORY = "default:silver_sandstone" -- MCL version of green dye
	moditems.INFOBOX_CAN = "Trash Can"
	moditems.INFOBOX_DUMP = "Dumpster"
	moditems.BOXART = ""
end

-- actual use in the code down somewhere.
material = moditems.IRON_ITEM 
sounds = moditems.WOOD_SOUNDS

_doc_items_longdesc = moditems.STRING_ITEM

local sounds

if mcl_sounds then
   sounds = mcl_sounds.node_sound_metal_defaults()
else
   if default.node_sound_metal_defaults then
      sounds = default.node_sound_metal_defaults()
   else
      sounds = default.node_sound_stone_defaults()
   end
end

dofile(minetest.get_modpath('ma_pops_furniture')..'/toaster.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/abm.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/bathroom.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/bedroom.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/kitchen.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/living_room.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/microwave.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/dining_room.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/outside.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/misc.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/oven.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/joyb.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/stereo.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/sofa.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/tv.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/toys.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/tools.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/functions.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/formspecs.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/fridge.lua')
dofile(minetest.get_modpath('ma_pops_furniture')..'/crafts.lua')