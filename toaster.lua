local S = ma_pops_furniture.intllib

--Toaster and Toast--
minetest.register_node("ma_pops_furniture:toaster", {
	description = S("Toaster"),
	tiles = {
		"mp_toas_top.png",
		"mp_toas_bottom.png",
		"mp_toas_right.png",
		"mp_toas_left.png",
		"mp_toas_back.png",
		"mp_toas_front.png"
	},
	walkable = false,
	groups = { snappy=3 },
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	drawtype = "nodebox",
	node_box = {
       type = "fixed",
       fixed = {
           {-0.375, -0.5, 0, 0.375, -0.0625, 0.3125},
		   {-0.4375, -0.1875, 0.0625, -0.375, -0.125, 0.25},
       },
   },
})

local function breadslice_on_use(itemstack, user, pointed_thing)
	local node, pos
	if pointed_thing.under then
		pos = pointed_thing.under
		node = minetest.get_node(pos)
	end

	local pname = user:get_player_name()

	if node and pos and (node.name == "ma_pops_furniture:toaster") then
		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			else
				if itemstack:get_count() >= 2 then
					itemstack:take_item(2)
					minetest.set_node(pos, {name = "ma_pops_furniture:toaster_with_breadslice", param2 = node.param2})
				return itemstack
			end
		end
	else
		return minetest.do_item_eat(2, nil, itemstack, user, pointed_thing)
	end
end

if minetest.registered_items["farming:bread_slice"] then
	minetest.override_item("farming:bread_slice", {on_use = breadslice_on_use })
	minetest.register_alias("ma_pops_furniture:breadslice", "farming:bread_slice")
else
	minetest.register_craftitem("ma_pops_furniture:breadslice", {
		description = S("Slice of Bread"),
		inventory_image = "mp_breadslice.png",
		groups = {flammable = 2},
		on_use = breadslice_on_use,
	})
end

if minetest.registered_items["farming:toast"] then
	minetest.register_alias("ma_pops_furniture:toast", "farming:toast")
else
	minetest.register_craftitem("ma_pops_furniture:toast", {
		description = S("Toast"),
		inventory_image = "mp_toast.png",
		on_use = minetest.item_eat(3),
		groups = {flammable = 2},
	})
end

minetest.register_node("ma_pops_furniture:toaster_with_breadslice", {
	description = S("Toaster with Breadslice"),
	tiles = {
		"mp_toas_top_bread.png",
		"mp_toas_bottom.png",
		"mp_toas_right_bread.png",
		"mp_toas_left_bread.png",
		"mp_toas_back_bread.png",
		"mp_toas_front_bread.png"
	},
	walkable = false,
	groups = {not_in_creative_inventory=1},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	diggable = false,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, 0, 0.375, -0.0625, 0.3125}, -- NodeBox1
			{-0.25, -0.0625, 0.0625, 0.25, 0.0625, 0.125}, -- NodeBox2
			{-0.25, -0.0625, 0.1875, 0.25, 0.0625, 0.25}, -- NodeBox3
			{-0.4375, -0.1875, 0.0625, -0.375, -0.125, 0.25}, -- NodeBox4
		},
	},
	on_punch = function(pos, node, clicker, itemstack, pointed_thing)
		local fdir = node.param2
		minetest.set_node(pos, { name = "ma_pops_furniture:toaster_toasting_breadslice", param2 = fdir })
		minetest.after(6, minetest.set_node, pos, { name = "ma_pops_furniture:toaster_with_toast", param2 = fdir })
		minetest.sound_play("toaster", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5
		})
		return itemstack
	end
})

minetest.register_node("ma_pops_furniture:toaster_toasting_breadslice", {
	description = S("Toaster Toasting Slice of Bread"),
	tiles = {
		"mp_toas_top_bread_on.png",
		"mp_toas_bottom.png",
		"mp_toas_right_bread.png",
		"mp_toas_left_toast_side.png",
		"mp_toas_back_side.png",
		"mp_toas_front_side.png"
	},
	walkable = false,
	groups = {not_in_creative_inventory = 1 },
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	diggable = false,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, 0, 0.375, -0.0625, 0.3125}, -- NodeBox1
			{-0.4375, -0.375, 0.0625, -0.375, -0.3125, 0.25}, -- NodeBox4
		},
	},
})

minetest.register_node("ma_pops_furniture:toaster_with_toast", {
	description = S("Toaster with Toast"),
		tiles = {
		"mp_toas_top_toast.png",
		"mp_toas_bottom.png",
		"mp_toas_right_toast.png",
		"mp_toas_left_toast.png",
		"mp_toas_back_toast.png",
		"mp_toas_front_toast.png"
	},
	walkable = false,
	groups = { snappy=3, not_in_creative_inventory=1 },
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, 0, 0.375, -0.0625, 0.3125}, -- NodeBox1
			{-0.25, -0.0625, 0.0625, 0.25, 0.0625, 0.125}, -- NodeBox2
			{-0.25, -0.0625, 0.1875, 0.25, 0.0625, 0.25}, -- NodeBox3
			{-0.4375, -0.1875, 0.0625, -0.375, -0.125, 0.25}, -- NodeBox4
		},
	},
	on_punch = function (pos, node, player, pointed_thing)
		local inv = player:get_inventory()
		local left = inv:add_item("main", "ma_pops_furniture:toast 2")
		if left:is_empty() then
			minetest.set_node(pos, {name = "ma_pops_furniture:toaster", param2 = node.param2})
		end
	end
})
	
--Slice of Bread (only if not farming one used)
if not minetest.registered_items["farming:bread_slice"] then
	minetest.register_craft({
		output = 'ma_pops_furniture:breadslice 2',
		type = "shapeless",
		recipe = {"farming:bread", "ma_pops_furniture:knife"},
		replacements = {{"ma_pops_furniture:knife", "ma_pops_furniture:knife"}},
	})
end