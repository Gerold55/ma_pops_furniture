local night_table = { --name, material, invimg
{'Wood Mailbox', 'wood'},
{'Acacia Wood Mailbox', 'acacia_wood'},
{'Aspen Wood Mailbox', 'aspen_wood'},
{'Pine Wood Mailbox', 'pine_wood'},
{'Jungle Wood Mailbox', 'junglewood'}
}

for i in ipairs (night_table) do
	local name = night_table[i][1]
	local material = night_table[i][2]
	local invimg = night_table[i][3]

minetest.register_node('ma_pops_furniture:mailbox_'..material, {
	description = name,
	drawtype = 'nodebox',
	tiles = {'default_'..material..'.png'},
	groups = {choppy=2, oddly_breakably_by_hand=2, furniture=1, flammable=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('storage', 3*3)
		meta:set_string('formspec',
			'size [9,10]'..
			'bgcolor[#080808BB;true]'..
			'list[current_name;storage;3,1.5;3,3;]'..
			'list[current_player;main;0.5,6.5;8,4;]')
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('storage') and inv:is_empty('storage1')
	end,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.75, 0.125}, -- NodeBox7
			{-0.25, 0.75, -0.3125, 0.25, 1.25, 0.3125}, -- NodeBox8
			{-0.25, 0.75, -0.5, 0.25, 0.8125, -0.25}, -- NodeBox9
			{-0.25, 1.1875, -0.5, 0.25, 1.25, -0.3125}, -- NodeBox10
			{-0.25, 0.8125, -0.5, -0.1875, 1.1875, -0.3125}, -- NodeBox11
			{0.1875, 0.75, -0.5, 0.25, 1.25, -0.3125}, -- NodeBox12
			{-0.1875, 1.125, -0.5, 0.1875, 1.1875, -0.3125}, -- NodeBox13
			{-0.1875, 0.8125, -0.5, 0.1875, 1, -0.4375}, -- NodeBox14
		}
	}
})
end

function ma_pops_furniture.register_hedge(name, def)

	-- register nodes
	if minetest.get_modpath("default") then
		def.sounds = def.sounds or default.node_sound_leaves_defaults()
	end

	minetest.register_node(name, {
		description = def.description or "Hedge",
		drawtype = "nodebox",
		paramtype = "light",
		tiles = {def.texture},
		groups = def.groups or
			{snappy = 3, flammable = 2, leaves = 1, hedge = 1},
		waving = 1,
		node_box = {
			type = "connected",
			fixed = {{-5/16, -0.5, -5/16, 5/16, 5/16, 5/16}},
			connect_left = {{-0.5, -0.5, -5/16, -5/16, 5/16, 5/16}},
			connect_right = {{5/16, -0.5, -5/16, 0.5, 5/16, 5/16}},
			connect_front = {{-5/16, -0.5, -0.5, 5/16, 5/16, -5/16}},
			connect_back = {{-5/16, -0.5, 5/16, 5/16, 5/16, 0.5}},
		},
		connects_to = {"group:fence", "group:wood", "group:tree", "group:hedge"},
		light_source = def.light_source or 0,
		sounds = def.sounds,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local pos_under = {x = pos.x, y = pos.y - 1, z = pos.z}
			local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
			local node_under = string.gsub(minetest.get_node(pos_under).name, "_full$", "")
			local node_above = string.gsub(minetest.get_node(pos_above).name, "_full$", "")

			if minetest.get_item_group(node_under, "hedge") == 1 then
				minetest.set_node(pos_under, {name = node_under .. "_full"})
			end
			if minetest.get_item_group(node_above, "hedge") == 1 then
				minetest.set_node(pos, {name = name .. "_full"})
			end
		end,
		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			local pos_under = {x = pos.x, y = pos.y - 1, z = pos.z}
			local node_under = string.gsub(minetest.get_node(pos_under).name, "_full$", "")
			if minetest.get_item_group(node_under, "hedge") == 1 and
					digger and digger:is_player() then
				minetest.set_node(pos_under, {name = node_under})
			end
		end,
	})

	minetest.register_node(name .. "_full", {
		description = def.description or "Hedge",
		drawtype = "nodebox",
		paramtype = "light",
		tiles = {def.texture},
		groups = def.groups or
			{snappy = 3, flammable = 2, leaves = 1, hedge = 1,
			not_in_creative_inventory = 1},
		waving = 1,
		node_box = {
			type = "connected",
			fixed = {{-5/16, -0.5, -5/16, 5/16, 0.5, 5/16}},
			connect_left = {{-0.5, -0.5, -5/16, -5/16, 0.5, 5/16}},
			connect_right = {{5/16, -0.5, -5/16, 0.5, 0.5, 5/16}},
			connect_front = {{-5/16, -0.5, -0.5, 5/16, 0.5, -5/16}},
			connect_back = {{-5/16, -0.5, 5/16, 5/16, 0.5, 0.5}},
		},
		connects_to = {"group:fence", "group:wood", "group:tree", "group:hedge"},
		light_source = def.light_source or 0,
		sounds = def.sounds,
		drop = name,
		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			local pos_under = {x = pos.x, y = pos.y - 1, z = pos.z}
			local node_under = string.gsub(minetest.get_node(pos_under).name, "_full$", "")
			if minetest.get_item_group(node_under, "hedge") == 1 and
					digger and digger:is_player() then
				minetest.set_node(pos_under, {name = node_under})
			end
		end,
	})

	-- register crafting recipe
	minetest.register_craft({
		output = name .. " 4",
		recipe = {
			{def.material, def.material, def.material},
			{def.material, def.material, def.material},
		}
	})
end


-- register hedges if default mod found
if minetest.get_modpath("default") then

	ma_pops_furniture.register_hedge("ma_pops_furniture:apple_hedge", {
		description = "Apple Hedge",
		texture = "default_leaves.png",
		material = "default:leaves",
	})

	ma_pops_furniture.register_hedge("ma_pops_furniture:jungle_hedge", {
		description = "Jungle Hedge",
		texture = "default_jungleleaves.png",
		material = "default:jungleleaves",
	})

	ma_pops_furniture.register_hedge("ma_pops_furniture:pine_hedge", {
		description = "Pine Hedge",
		texture = "default_pine_needles.png",
		material = "default:pine_needles",
	})

	ma_pops_furniture.register_hedge("ma_pops_furniture:acacia_hedge", {
		description = "Acacia Hedge",
		texture = "default_acacia_leaves.png",
		material = "default:acacia_leaves",
	})

	ma_pops_furniture.register_hedge("ma_pops_furniture:aspen_hedge", {
		description = "Aspen Hedge",
		texture = "default_aspen_leaves.png",
		material = "default:aspen_leaves",
	})

end


-- alternative recipes using bush leaves
	minetest.register_craft({
		output = "hedges:apple_hedge 4",
		recipe = {
			{"default:bush_leaves", "default:bush_leaves", "default:bush_leaves"},
			{"default:bush_leaves", "default:bush_leaves", "default:bush_leaves"},
		}
	})

		minetest.register_craft({
		output = "hedges:acacia_hedge 4",
		recipe = {
			{"default:acacia_bush_leaves", "default:acacia_bush_leaves", "default:acacia_bush_leaves"},
			{"default:acacia_bush_leaves", "default:acacia_bush_leaves", "default:acacia_bush_leaves"},
		}
	})

minetest.register_node('ma_pops_furniture:birdbath', {
	description = 'Birdbath',
	drawtype = 'mesh',
	mesh = 'FM_birdbath.obj',
	tiles = {{name='default_stone.png'},{name='default_water_source_animated.png', animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=2.0}}},
	groups = {cracky=2, oddly_breakable_by_hand=5, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node('ma_pops_furniture:doorbell', {
	description = 'Doorbell',
	drawtype = 'nodebox',
	tiles = {
		"mp_db_top.png",
		"mp_db_top.png",
		"mp_db_right.png",
		"mp_db_left.png",
		"default_wood.png",
		"mp_db_front.png"
	},
	groups = {cracky=2, oddly_breakable_by_hand=5, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	on_rightclick = function(pos, node, clicker, itemstack)
		node.name = "ma_pops_furniture:doorbell_ring"
		minetest.swap_node(pos, node)
		-- one second ring.
		minetest.get_node_timer(pos):start(1.0)
	end,
	sounds = default.node_sound_stone_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.375, 0.4375, 0.125, -0.125, 0.5},
			{-0.0625, -0.3125, 0.375, 0.0625, -0.1875, 0.4375},
		},
	}
})

minetest.register_node('ma_pops_furniture:doorbell_ring', {
	description = 'Doorbell (ring)',
	drawtype = 'nodebox',
	tiles = {
		"mp_db_top.png",
		"mp_db_top.png",
		"mp_db_right.png",
		"mp_db_left.png",
		"default_wood.png",
		"mp_db_front.png"
	},
	groups = {cracky=2, oddly_breakable_by_hand=5, furniture=1, not_in_creative_inventory=1},
	drop = 'ma_pops_furniture:doorbell',
	on_timer = function(pos,elapsed)
		local node = minetest.get_node(pos)
		node.name = "ma_pops_furniture:doorbell"
		minetest.swap_node(pos, node)
	end,
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_stone_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.375, 0.4375, 0.125, -0.125, 0.5},
			{-0.0625, -0.3125, 0.375, 0.0625, -0.1875, 0.4375},
		},
	}
})


minetest.register_node('ma_pops_furniture:stone_path_1', {
	description = 'Stone Path',
	drawtype = 'mesh',
	mesh = 'FM_stone_path_1.obj',
	tiles = {'default_stone.png'},
	groups = {cracky=2, oddly_breakable_by_hand=5, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = 'fixed',
		fixed = {-.5, -.5, -.5, .5, -.4, .5},
		},
	collision_box = {
		type = 'fixed',
		fixed = {-.5, -.5, -.5, .5, -.4, .5},
		},
	on_place = function(itemstack, placer, pointed_thing)
		local stack = ItemStack("ma_pops_furniture:stone_path_" .. math.random(1,4))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("ma_pops_furniture:stone_path_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 4 do
minetest.register_node('ma_pops_furniture:stone_path_'..i, {
	description = 'Stone Path',
	drawtype = 'mesh',
	mesh = 'FM_stone_path_'..i..'.obj',
	tiles = {'default_stone.png'},
	groups = {cracky=2, oddly_breakable_by_hand=5, furniture=1, not_in_creative_inventory=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_stone_defaults(),
	drop = 'ma_pops_furniture:stone_path_1',
	selection_box = {
		type = 'fixed',
		fixed = {-.5, -.5, -.5, .5, -.4, .5},
		},
	collision_box = {
		type = 'fixed',
		fixed = {-.5, -.5, -.5, .5, -.4, .5},
		},
})
end

minetest.register_node("ma_pops_furniture:outdoor_lamp", {
   description = "Outdoor Lamp",
   tiles = {
		"default_stone.png",
		"default_stone.png^mp_light_off.png",
		"default_stone.png",
		"default_stone.png",
		"default_stone.png",
		"default_stone.png"
},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   on_rightclick = function (pos, node, player, itemstack, pointed_thing)
   node.name = "ma_pops_furniture:outdoor_lamp_on"
   minetest.set_node(pos, node)
   end,
   groups = {choppy = 2, oddly_breakable_by_hand = 2},
   node_box = {
       type = "fixed",
       fixed = {
           {-0.125, 0.25, -0.125, 0.125, 0.5, 0.125},
       },
   }
})

minetest.register_node("ma_pops_furniture:outdoor_lamp_on", {
   description = "Outdoor Lamp On",
   tiles = {
		"default_stone.png",
		"default_stone.png^mp_light_on.png",
		"default_stone.png",
		"default_stone.png",
		"default_stone.png",
		"default_stone.png"
},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   light_source =  14,
   drop = 'ma_pops_furniture:outdoor_lamp',
   on_rightclick = function (pos, node, player, itemstack, pointed_thing)
   node.name = "ma_pops_furniture:outdoor_lamp"
minetest.set_node(pos, node)
end,
   groups = {choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
   node_box = {
       type = "fixed",
       fixed = {
           {-0.125, 0.25, -0.125, 0.125, 0.5, 0.125},
       },
   }
})