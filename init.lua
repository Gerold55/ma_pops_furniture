ma_pops_furniture = {}

--GreenDimond's code from waffle mod
local MP = core.get_modpath(core.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

ma_pops_furniture.intllib = S
dofile(MP..'/intllib.lua')

moditems = {}  -- switcher

-- TODO: fix the comments
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

if core.get_modpath("mcl_sounds") and mcl_sounds then
   sounds = mcl_sounds.node_sound_metal_defaults()
else
   if default.node_sound_metal_defaults then
      sounds = default.node_sound_metal_defaults()
   else
      sounds = default.node_sound_stone_defaults()
   end
end

dofile(MP..'/toaster.lua')
dofile(MP..'/abm.lua')
dofile(MP..'/bathroom.lua')
dofile(MP..'/bedroom.lua')
dofile(MP..'/kitchen.lua')
dofile(MP..'/living_room.lua')
dofile(MP..'/microwave.lua')
dofile(MP..'/dining_room.lua')
dofile(MP..'/outside.lua')
dofile(MP..'/misc.lua')
dofile(MP..'/oven.lua')
dofile(MP..'/joyb.lua')
dofile(MP..'/stereo.lua')
dofile(MP..'/sofa.lua')
dofile(MP..'/tv.lua')
dofile(MP..'/toys.lua')
dofile(MP..'/tools.lua')
dofile(MP..'/functions.lua')
dofile(MP..'/formspecs.lua')
dofile(MP..'/fridge.lua')
dofile(MP..'/crafts.lua')
