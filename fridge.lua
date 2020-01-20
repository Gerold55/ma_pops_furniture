--
-- Freezer for mintest: a device which turns water (in buckets) into ice
-- And does a couple of other tricks, discovering which is left as a pleasant
-- surprise for the player.
--

-- enable extra popsicle types provided there are both vessels and fruits/veggies available
-- fruit + glass -> juice; juice @ freezer -> popsicle + empty glass
 
--
-- Formspecs
--

local function active_formspec(fuel_percent, item_percent)
	local formspec = 
		"size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"list[current_name;src;2.5,1;1,1;]"..
		"image[3.75,1.5;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
		(item_percent)..":gui_furnace_arrow_fg.png^[transformR270]"..
		"list[current_name;dst;4.75,0.96;3,2;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[current_name;dst]"..
		"listring[current_player;main]"..
		"listring[current_name;src]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
	return formspec
end

local inactive_formspec =
	"size[8,8.5]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"list[current_name;src;2.5,1.5;1,1;]"..
	"image[3.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
	"list[current_name;dst;4.75,0.96;3,2;]"..
	"list[current_player;main;0,4.25;8,1;]"..
	"list[current_player;main;0,5.5;8,3;8]"..
	"listring[current_name;dst]"..
	"listring[current_player;main]"..
	"listring[current_name;src]"..
	"listring[current_player;main]"..
	default.get_hotbar_bg(0, 4.25)

--
-- Node callback functions that are the same for active and inactive freezer
--

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("dst") and inv:is_empty("src")
end

	      
local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "src" then
		return stack:get_count()
	elseif listname == "dst" then
		return 0
	end
end

	      
local function allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack(from_list, from_index)
	return allow_metadata_inventory_put(pos, to_list, to_index, stack, player)
end

	      
local function allow_metadata_inventory_take(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	return stack:get_count()
end

	      
local function swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

	      
local function freezer_node_timer(pos, elapsed)
	--
	-- Inizialize metadata
	--
	local meta = minetest.get_meta(pos)

	local src_time = meta:get_float("src_time") or 0


	local inv = meta:get_inventory()
	local srclist = inv:get_list("src")

	local dstlist = inv:get_list("dst")

	--
	-- Cooking
	--

	-- takes both regular and river water
	if inv:contains_item("src", "bucket:bucket_water") or 
	      inv:contains_item("src", "bucket:bucket_river_water") then
		if inv:room_for_item("dst", "default:ice") then
			inv:remove_item("src", "bucket:bucket_water")
			inv:remove_item("src", "bucket:bucket_river_water")
			inv:add_item("dst", "default:ice")
			inv:add_item("dst", "bucket:bucket_empty")
	      end
	end
	      
	-- Check if we have cookable content
	return
end

	      
--
-- Node definitions
--
color1 = minetest.setting_get("color1") or "292421"
color2 = minetest.setting_get("color2") or "0000FF"
color3 = minetest.setting_get("color3") or "00FF00"
color4 = minetest.setting_get("color4") or "F5F5F5"
color5 = minetest.setting_get("color5") or "FF6103"
color6 = minetest.setting_get("color6") or "FF0000"
color7 = minetest.setting_get("color7") or "FFFF00"
color8 = minetest.setting_get("color8") or "FF69B4"

local fridges_list = {
	{"black", "Darkened Fridge", color1}, 
	{"blue", "Blue Fridge", color2},
	{"green", "Green Fridge", color3}, 
	{"white", "White Fridge", color4}, 
	{"orange", "Orange Fridge", color5}, 
	{"red", "Red Fridge", color6}, 
	{"yellow", "Yellow Fridge", color7}, 
	{"pink", "Pink Fridge", color8}
}

for i, fridge in ipairs(fridges_list) do
    local colour = fridge[1]
    local fridgedesc = fridge[2]
    local colour2 = fridge[3]

	minetest.register_node("ma_pops_furniture:fridge_"..colour, {
		description = fridgedesc,
		drawtype = "nodebox",
		tiles = {
			"mp_dfridge_top.png^[colorize:#"..colour2..":70",
			"mp_dfridge_bottom.png^[colorize:#"..colour2..":70",
			"mp_dfridge_right.png^[colorize:#"..colour2..":70",
			"mp_dfridge_left.png^[colorize:#"..colour2..":70",
			"mp_dfridge_back.png^[colorize:#"..colour2..":70",
			"mp_dfridge_front.png^[colorize:#"..colour2..":70"
		},
		paramtype = "light",
		paramtype2 = "facedir",
		stack_max = 1,
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.3125, 0.5, 0.5, 0.5}, -- NodeBox1
				{-0.5, -0.25, -0.375, 0.5, 0.5, -0.3125}, -- NodeBox2
				{-0.5, -0.5, -0.375, 0.5, -0.3125, -0.3125}, -- NodeBox3
				{0.375, 0, -0.4375, 0.4375, 0.5, -0.375}, -- NodeBox4
			}
		},

		after_place_node = function(pos, placer, itemstack)
			local node = minetest.env:get_node(pos)
			local p = {x=pos.x, y=pos.y, z=pos.z}
			local param2 = node.param2
			node.name = "ma_pops_furniture:fridge_top_"..colour
				pos.y = pos.y+1
			if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
				minetest.env:set_node(pos, node)
			else
				minetest.env:remove_node(p)
				return true
			end
		end,
		
		on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('storage', 6*4)
		meta:set_string('formspec',
			'size [9,10]'..
			'bgcolor[#080808BB;true]'..
			'list[current_name;storage;2,1.5;6,4;]'..
			'list[current_player;main;0.5,6.2;8,4;]')
	end,
			
		on_destruct = function(pos)
			local node = minetest.env:get_node(pos)
			local param2 = node.param2
			local abovepos = {x=pos.x, y=pos.y+1, z=pos.z}
			local abovenode = minetest.env:get_node(abovepos)
			  if abovenode.name == "ma_pops_furniture:fridge_top_"..colour and
				  abovenode.param2 == param2 then 
						minetest.env:remove_node(abovepos)
				end	
		end,
		
		
	})

minetest.register_node("ma_pops_furniture:fridge_top_"..colour, {
		description = fridgedesc,
		drawtype = "nodebox",
		tiles = {
			"mp_ufridge_top.png^[colorize:#"..colour2..":70",
			"default_wood.png^[colorize:#"..colour2..":70",
			"mp_ufridge_right.png^[colorize:#"..colour2..":70",
			"mp_ufridge_left.png^[colorize:#"..colour2..":70",
			"mp_fridge_back.png^[colorize:#"..colour2..":70",
			"mp_ufridge_front.png^[colorize:#"..colour2..":70"
		},
		paramtype = "light",
		paramtype2 = "facedir",

		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,not_in_creative_inventory=1},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.3125, 0.5, 0.5, 0.5}, -- NodeBox1
				{-0.5, 0.3125, -0.375, 0.5, 0.5, -0.3125}, -- NodeBox2
				{-0.5, -0.3125, -0.375, 0.5, 0.25, -0.3125}, -- NodeBox3
				{-0.5, -0.5, -0.375, 0.5, -0.375, -0.3125}, -- NodeBox4
				{0.375, -0.25, -0.4375, 0.4375, 0.125, -0.375}, -- NodeBox6
			}
		},
	                                     
	can_dig = can_dig,

	on_timer = freezer_node_timer,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", inactive_formspec)
		local inv = meta:get_inventory()
		inv:set_size('src', 1)
		inv:set_size('dst', 6)
	end,

	on_metadata_inventory_move = function(pos)
		local timer = minetest.get_node_timer(pos)
		timer:start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		-- start timer function, it will sort out whether freezer will work or not.
		local timer = minetest.get_node_timer(pos)
		timer:start(1.0)
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "src", drops)
		default.get_inventory_drops(pos, "dst", drops)
		drops[#drops+1] = "ma_pops_furniture:freezer"
		minetest.remove_node(pos)
		return drops
	end,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
})
minetest.register_alias("fridges:fridge_"..colour, "fridges:fridge_bottom_"..colour)
	
end
	      
minetest.register_craft({
      output = "default:snowblock 3",
      type = "shapeless",
      recipe = {
	 "default:ice"
      }
})
