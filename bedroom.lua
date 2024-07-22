local night_table = { --name, material, invimg
{'Wood Nightstand', 'wood'},
{'Acacia Wood Nightstand', 'acacia_wood'},
{'Aspen Wood Nightstand', 'aspen_wood'},
{'Pine Wood Nightstand', 'pine_wood'},
{'Jungle Wood Nightstand', 'junglewood'}
}

for i in ipairs (night_table) do
	local name = night_table[i][1]
	local material = night_table[i][2]
	local invimg = night_table[i][3]

minetest.register_node('ma_pops_furniture:nightstand_'..material, {
	description = name,
	drawtype = 'nodebox',
	tiles = {'default_'..material..'.png'},
	groups = {choppy=2, oddly_breakably_by_hand=2, furniture=1, flammable=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = moditems.WOOD_SOUNDS,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('storage', 3*3)
		meta:set_string('formspec',
			'size [9,10]'..
			'bgcolor[#080808BB;true]'..
			'list[current_name;storage;3,1.5;3,3;]'..
			'list[current_player;main;0.5,6.2;8,4;]')
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('storage') and inv:is_empty('storage1')
	end,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4375, 0.5, -0.4375, 0.5}, -- NodeBox1
			{-0.5, 0.4375, -0.4375, 0.5, 0.5, 0.5}, -- NodeBox2
			{-0.5, -0.4375, -0.375, 0.5, 0.4375, 0.5}, -- NodeBox3
			{-0.4375, 0.0625, -0.4375, 0.4375, 0.375, -0.375}, -- NodeBox4
			{-0.4375, -0.375, -0.4375, 0.4375, -0.0625, -0.375}, -- NodeBox5
			{-0.125, -0.3125, -0.5, 0.125, -0.125, -0.4375}, -- NodeBox6
			{-0.125, 0.125, -0.5, 0.125, 0.3125, -0.4375}, -- NodeBox7
		}
	}
})
end