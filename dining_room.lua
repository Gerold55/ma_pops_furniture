local chair_table = { --name, material, invimg
{'Stone Chair', 'cobble', 'mp_chair_stone.png'},
{'Wood Chair', 'wood', 'mp_chair_wood.png'},
{'Acacia Wood Chair', 'acacia_wood', 'mp_chair_acacia_wood.png'},
{'Aspen Wood Chair', 'aspen_wood', 'mp_chair_aspen_wood.png'},
{'Pine Wood Chair', 'pine_wood', 'mp_chair_pine_wood.png'},
{'Jungle Wood Chair', 'junglewood', 'mp_chair_junglewood.png'}
}

for i in ipairs (chair_table) do
	local name = chair_table[i][1]
	local material = chair_table[i][2]
	local invimg = chair_table[i][3]

minetest.register_node('ma_pops_furniture:chair_'..material, {
	description = name,
	drawtype = 'nodebox',
	tiles = {'default_'..material..'.png'},
	groups = {choppy=2, oddly_breakably_by_hand=2, furniture=1, flammable=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = moditems.WOOD_SOUNDS,
	can_dig = ma_pops_furniture.sit_dig,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		pos.y = pos.y + 0  -- Sitting position
		ma_pops_furniture.sit(pos, node, clicker, pointed_thing)
		return itemstack
	end,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, 0.3125, -0.3125, -0.0625, 0.4375}, -- NodeBox10
			{0.3125, -0.5, 0.3125, 0.4375, -0.0625, 0.4375}, -- NodeBox11
			{-0.4375, -0.5, -0.4375, -0.3125, -0.0625, -0.3125}, -- NodeBox12
			{0.3125, -0.5, -0.4375, 0.4375, -0.0625, -0.3125}, -- NodeBox13
			{-0.4375, -0.0625, -0.4375, 0.4375, 0.0625, 0.4375}, -- NodeBox14
			{-0.4375, 0.0625, 0.3125, 0.4375, 0.8125, 0.4375}, -- NodeBox15
		}
	}
})
end

local table_table = { --name, material, invimg
{'Stone Table', 'cobble', 'mp_table_stone.png'},
{'Wood Table', 'wood', 'mp_table_wood.png'},
{'Acacia Wood Table', 'acacia_wood', 'mp_table_wood_acacia.png'},
{'Aspen Wood Table', 'aspen_wood', 'mp_table_wood_aspen.png'},
{'Pine Wood Table', 'pine_wood', 'mp_table_wood_pine.png'},
{'Jungle Wood Table', 'junglewood', 'mp_table_wood_jungle.png'}
}

for i in ipairs (table_table) do
	local name = table_table[i][1]
	local material = table_table[i][2]
	local invimg = table_table[i][3]
	
minetest.register_node('ma_pops_furniture:table_'..material, {
	description = name,
	drawtype = 'nodebox',
	tiles = {'default_'..material..'.png'},
	align_style="world",
	groups = {snappy = 2, oddly_breakable_by_hand = 2, furniture = 1, flammable = 1, table = 1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = moditems.WOOD_SOUNDS,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.375, 0.125}, -- NodeBox8
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox9
		}
	},

	after_dig_node = function(pos) ma_pops_furniture.check_table(pos, material, false, true) end,
	after_place_node = function(pos) ma_pops_furniture.check_table(pos, material, true, true) end,
	on_punch = function(pos) ma_pops_furniture.check_table(pos, material, true, true) end
})
end

local table2_table = { --name, material, invimg
{'Stone Table', 'cobble', 'mp_table_stone.png'},
{'Wood Table', 'wood', 'mp_table_wood.png'},
{'Acacia Wood Table', 'acacia_wood', 'mp_table_wood_acacia.png'},
{'Aspen Wood Table', 'aspen_wood', 'mp_table_wood_aspen.png'},
{'Pine Wood Table', 'pine_wood', 'mp_table_wood_pine.png'},
{'Jungle Wood Table', 'junglewood', 'mp_table_wood_jungle.png'}
}

for i in ipairs (table2_table) do
	local name = table2_table[i][1]
	local material = table2_table[i][2]
	local invimg = table2_table[i][3]
	
minetest.register_node('ma_pops_furniture:table2_'..material, {
	description = name,
	drawtype = 'nodebox',
	tiles = {'default_'..material..'.png'},
	align_style="world",
	groups = {snappy = 2, oddly_breakable_by_hand = 2, furniture = 1, flammable = 1, table = 1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = moditems.WOOD_SOUNDS,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox5
			{-0.4375, -0.5, -0.4375, -0.3125, 0.375, -0.3125}, -- NodeBox6
			{-0.4375, -0.5, 0.3125, -0.3125, 0.375, 0.4375}, -- NodeBox7
			{0.3125, -0.5, 0.3125, 0.4375, 0.375, 0.4375}, -- NodeBox8
			{0.3125, -0.5, -0.4375, 0.4375, 0.375, -0.3125}, -- NodeBox9
		}
	},
})
end

local table_c_table = { --name, material, invimg
{'Stone Corner Table', 'cobble', 'mp_table_stone.png'},
{'Wood Corner Table', 'wood', 'mp_table_wood.png'},
{'Acacia Corner Wood Table', 'acacia_wood', 'mp_table_wood_acacia.png'},
{'Aspen Corner Wood Table', 'aspen_wood', 'mp_table_wood_aspen.png'},
{'Pine Corner Wood Table', 'pine_wood', 'mp_table_wood_pine.png'},
{'Jungle Corner Wood Table', 'junglewood', 'mp_table_wood_jungle.png'}
}

for i in ipairs (table_c_table) do
	local name = table_c_table[i][1]
	local material = table_c_table[i][2]
	local invimg = table_c_table[i][3]
	
minetest.register_node('ma_pops_furniture:table_c_'..material, {
	description = name,
	drawtype = 'nodebox',
	tiles = {'default_'..material..'.png'},
	align_style="world",
	groups = {snappy = 2, oddly_breakable_by_hand = 2, furniture = 1, flammable = 1, table = 1, not_in_creative_inventory = 1},
	drop = 'ma_pops_furniture:table_'..material,
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = moditems.WOOD_SOUNDS,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.375, -0.5, -0.125, -0.125, 0.3125, 0.125}, -- NodeBox3
		}
	},

	after_dig_node = function(pos) ma_pops_furniture.check_table(pos, material, false, true) end,
	after_place_node = function(pos) ma_pops_furniture.check_table(pos, material, true, true) end,
	on_punch = function(pos) ma_pops_furniture.check_table(pos, material, true, true) end
})
end

local table_center_table = { --name, material, invimg
{'Stone Center Table', 'cobble', 'mp_table_stone.png'},
{'Wood Center Table', 'wood', 'mp_table_wood.png'},
{'Acacia Center Wood Table', 'acacia_wood', 'mp_table_wood_acacia.png'},
{'Aspen Center Wood Table', 'aspen_wood', 'mp_table_wood_aspen.png'},
{'Pine Center Wood Table', 'pine_wood', 'mp_table_wood_pine.png'},
{'Jungle Center Wood Table', 'junglewood', 'mp_table_wood_jungle.png'}
}

for i in ipairs (table_center_table) do
	local name = table_center_table[i][1]
	local material = table_center_table[i][2]
	local invimg = table_center_table[i][3]
	
minetest.register_node('ma_pops_furniture:table_center_'..material, {
	description = name,
	drawtype = 'nodebox',
	tiles = {'default_'..material..'.png'},
	align_style="user",
	groups = {snappy = 2, oddly_breakable_by_hand = 2, furniture = 1, flammable = 1, table = 1, not_in_creative_inventory = 1},
	drop = 'ma_pops_furniture:table_'..material,
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = moditems.WOOD_SOUNDS,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5},
		}
	},

	after_dig_node = function(pos) ma_pops_furniture.check_table(pos, material, false, true) end,
	after_place_node = function(pos) ma_pops_furniture.check_table(pos, material, true, true) end,
	on_punch = function(pos) ma_pops_furniture.check_table(pos, material, true, true) end
})
end