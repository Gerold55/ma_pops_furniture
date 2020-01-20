minetest.register_node('ma_pops_furniture:fireplace', {
	description = 'Fireplace',
	drawtype = 'mesh',
	mesh = 'FM_fireplace_off.obj',
	tiles = {{name='default_brick.png'},{name='xpanes_bar.png'}},
	groups = {cracky=2, oddly_breakable_by_hand=6, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = moditems.STONE_SOUNDS,
	on_construct = function(pos)
			local meta = minetest.env:get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size('fuel', 1)
			inv:set_size('main', 8*4)
			meta:set_string('formspec', ma_pops_furniture.fireplace_formspec)
			meta:set_string('infotext', 'Fireplace')
		end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('fuel')
	end,
})

minetest.register_node('ma_pops_furniture:fireplace_on', {
	description = 'Fireplace',
	drawtype = 'mesh',
	mesh = 'FM_fireplace_on.obj',
	tiles = {{name='default_brick.png'},{name='xpanes_bar.png'},{name='default_tree.png'},{name='fire_basic_flame_animated.png', animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=1}}},
	groups = {cracky=2, oddly_breakable_by_hand=3, furniture=1, not_in_creative_inventory=1},
	light_source = 14,
	paramtype = 'light',
	paramtype2 = 'facedir',
	drops = 'ma_pops_furniture:fireplace',
	sounds = moditems.STONE_SOUNDS,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('fuel')
	end,
})

local c_table = { --name, material, invimg
{'Stone Coffee Table', 'cobble'},
{'Wood Coffee Table', 'wood'},
{'Acacia Wood Coffee Table', 'acacia_wood'},
{'Aspen Wood Coffee Table', 'aspen_wood'},
{'Pine Wood Coffee Table', 'pine_wood'},
{'Jungle Wood Coffee Table', 'junglewood'}
}

for i in ipairs (c_table) do
	local name = c_table[i][1]
	local material = c_table[i][2]
	local invimg = c_table[i][3]

minetest.register_node('ma_pops_furniture:c_'..material, {
	description = name,
	drawtype = 'nodebox',
	tiles = {'default_'..material..'.png'},
	groups = {choppy=2, oddly_breakably_by_hand=2, furniture=1, flammable=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
     for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'ma_pops_furniture:c_'..material then
            node.name = 'ma_pops_furniture:end_table_'..material
               minetest.set_node(pos, node)
        else
        end
    end
end,
	sounds = moditems.WOOD_SOUNDS,
	node_box = {
       type = "fixed",
       fixed = {
           {-0.5, -0.5, -0.5, -0.4, 0.0, -0.4},
           {-0.5, -0.5, 0.5, -0.4, 0.0, 0.4},
           {0.5, -0.5, -0.5, 0.4, 0.0, -0.4},
           {0.5, -0.5, 0.5, 0.4, 0.0, 0.4},
           {0.5, 0.1, 0.5, -0.5, 0.0, -0.5},
           {0.5, -0.3, 0.5, -0.5, -0.4, -0.5},
       },
   }
})
end

local end_table = { --name, material, invimg
{'Stone End Table', 'cobble'},
{'Wood End Table', 'wood'},
{'Acacia Wood End Table', 'acacia_wood'},
{'Aspen Wood End Table', 'aspen_wood'},
{'Pine Wood End Table', 'pine_wood'},
{'Jungle Wood End Table', 'junglewood'}
}

for i in ipairs (end_table) do
	local name = end_table[i][1]
	local material = end_table[i][2]
	local invimg = end_table[i][3]

minetest.register_node('ma_pops_furniture:end_table_'..material, {
	description = name,
	drawtype = 'nodebox',
	tiles = {'default_'..material..'.png'},
	groups = {choppy=2, oddly_breakably_by_hand=2, furniture=1, flammable=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = moditems.WOOD_SOUNDS,
	node_box = {
       type = "fixed",
       fixed = {
            {-0.5, -0.5, -0.5, -0.4, 0.5, -0.4},
           {-0.5, -0.5, 0.5, -0.4, 0.5, 0.4},
           {0.5, -0.5, -0.5, 0.4, 0.5, -0.4},
           {0.5, -0.5, 0.5, 0.4, 0.5, 0.4},
           {0.5, 0.4, 0.5, -0.5, 0.5, -0.5},
           {0.5, -0.3, 0.5, -0.5, -0.2, -0.5},
       },
   }
})
end

local unit_table = { --name, material
{'Wood Entertainment Unit', 'wood'},
{'Acacia Wood Entertainment Unit', 'acacia_wood'},
{'Aspen Wood Entertainment Unit', 'aspen_wood'},
{'Pine Wood Entertainment Unit', 'pine_wood'},
{'Jungle Wood Entertainment Unit', 'junglewood'}
}

for i in ipairs (unit_table) do
	local name = unit_table[i][1]
	local material = unit_table[i][2]
	local invimg = unit_table[i][3]

minetest.register_node("ma_pops_furniture:e_u_"..material, {
	description= name,
	tiles= {'default_'..material..'.png'},
	drawtype= "nodebox",
	paramtype= "light",
	paramtype2 = "facedir",
	sounds = moditems.WOOD_SOUNDS,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, furniture = 1},
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
	node_box= {
		type= "fixed",
		fixed= {
			{-0.5, -0.5, -0.5, -0.4, 0.5, 0.5},
			{0.5, -0.5, -0.5, 0.4, 0.5, 0.5},
			{-0.5, 0.4, -0.5, 0.5, 0.5, 0.5},
			{-0.5, -0.050, -0.5, 0.5, 0.050, 0.5},
			{-0.5, -0.5, 0.5, 0.5, 0.5, 0.4},
		},
	}
})
end

minetest.register_node('ma_pops_furniture:vcr_on', {
	description= "VCR",
	tiles = {
		"default_coal_block.png",
		"default_coal_block.png",
		"default_coal_block.png",
		"default_coal_block.png",
		"default_coal_block.png",
		"default_coal_block.png^mp_vcr_on.png"
	},
	drawtype= "nodebox",
	paramtype= "light",
	paramtype2 = "facedir",
	drop = 'ma_pops_furniture:vcr_off',
	sounds = moditems.WOOD_SOUNDS,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory=1, furniture = 1},
	node_box= {
		type= "fixed",
		fixed= {
			{-0.375, -0.5, -0.25, 0.375, -0.4375, 0.25},
			{-0.4375, -0.4375, -0.3125, 0.4375, -0.25, 0.3125},
		},
	},
	on_rightclick = function (pos, node, puncher)
		node.name = "ma_pops_furniture:vcr_off"
		minetest.set_node(pos, node)
	end,
})

minetest.register_node('ma_pops_furniture:vcr_off', {
	description= "VCR",
	tiles = {
		"default_coal_block.png",
		"default_coal_block.png",
		"default_coal_block.png",
		"default_coal_block.png",
		"default_coal_block.png",
		"default_coal_block.png^mp_vcr_off.png"
	},
	drawtype= "nodebox",
	paramtype= "light",
	paramtype2 = "facedir",
	drop = 'ma_pops_furniture:vcr_off',
	sounds = moditems.WOOD_SOUNDS,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box= {
		type= "fixed",
		fixed= {
			{-0.375, -0.5, -0.25, 0.375, -0.4375, 0.25},
			{-0.4375, -0.4375, -0.3125, 0.4375, -0.25, 0.3125},
		},
	},
	on_rightclick = function (pos, node, puncher)
		node.name = "ma_pops_furniture:vcr_on"
		minetest.set_node(pos, node)
	end,
})

local chair2_table = { --name, color, colorize(hex or color name:intensity(1-255))
{'Black', 'black', 'black:225'},
{'Blue', 'blue', 'blue:225'},
{'Brown', 'brown', 'brown:225'},
{'Cyan', 'cyan', 'cyan:200'},
{'Dark Green', 'dark_green', 'green:225'},
{'Dark Grey', 'dark_grey', 'black:200'},
{'Green', 'green', '#32cd32:150'},
{'Grey', 'grey', 'black:100'},
{'Magenta', 'magenta', 'magenta:200'},
{'Orange', 'orange', 'orange:225'},
{'Pink', 'pink', 'pink:225'},
{'Red', 'red', 'red:225'},
{'Violet', 'violet', 'violet:225'},
{'White', 'white', 'white:1'},
{'Yellow', 'yellow', 'yellow:225'},
}

for i in ipairs (chair2_table) do
    local name = chair2_table[i][1]
    local color = chair2_table[i][2]
    local hex = chair2_table[i][3]

local cb = "^([combine:16x16:0,0=mp_cb.png^[mask:mp_mask.png)"
local cf = "^([combine:16x16:0,0=mp_cf.png^[mask:mp_mask.png)"

minetest.register_node("ma_pops_furniture:chair2_"..color, {
    description = name.." Chair",
    tiles = {"wool_"..color..".png","wool_"..color..".png"..cb,"wool_"..color..".png"..cf,"wool_"..color..".png"..cf,"wool_"..color..".png"..cf,"wool_"..color..".png"..cf,},
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, furniture = 1, fall_damage_add_percent=-80, bouncy=80},
	sounds = {wood = {name="furn_bouncy", gain=0.8}},
    can_dig = ma_pops_furniture.sit_dig,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		pos.y = pos.y + 0  -- Sitting position
		ma_pops_furniture.sit(pos, node, clicker, pointed_thing)
		return itemstack
	end,
    node_box = {
        type = "fixed",
        fixed = {
            {-0.4, -0.5, -0.4, -0.3, -0.4, -0.3},
            {-0.4, -0.5, 0.4, -0.3, -0.4, 0.3},
            {0.4, -0.5, 0.4, 0.3, -0.4, 0.3},
            {0.4, -0.5, -0.4, 0.3, -0.4, -0.3},
            -----------------------------------
            {-0.450, -0.4, -0.450, 0.450, 0.1, 0.450},
            {-0.5, 0.1, -0.5, -0.3, 0.3, 0.0},
            {0.5, 0.1, -0.5, 0.3, 0.3, 0.0},
            {0.450, 0.1, -0.0, -0.450, 0.5, 0.450},
        },
    },
	on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:chair2_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:chair2_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:chair2_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:chair2_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:chair2_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:chair2_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:chair2_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:chair2_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:chair2_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:chair2_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:chair2_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:chair2_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:chair2_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:chair2_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:chair2_brown"
               minetest.set_node(pos, node)
        else
         ma_pops_furniture.sit(pos, node, clicker)
                      end
                     end
                    end
                   end
                  end
                 end
                end
               end
              end
             end
            end
           end
          end
         end
        end
       end
		 end
})
end

local fs_table = { --name, color, colorize(hex or color name:intensity(1-255))
{'Black', 'black', 'black:225'},
{'Blue', 'blue', 'blue:225'},
{'Brown', 'brown', 'brown:225'},
{'Cyan', 'cyan', 'cyan:200'},
{'Dark Green', 'dark_green', 'green:225'},
{'Dark Grey', 'dark_grey', 'black:200'},
{'Green', 'green', '#32cd32:150'},
{'Grey', 'grey', 'black:100'},
{'Magenta', 'magenta', 'magenta:200'},
{'Orange', 'orange', 'orange:225'},
{'Pink', 'pink', 'pink:225'},
{'Red', 'red', 'red:225'},
{'Violet', 'violet', 'violet:225'},
{'White', 'white', 'white:1'},
{'Yellow', 'yellow', 'yellow:225'},
}

for i in ipairs (fs_table) do
	local name = fs_table[i][1]
	local color = fs_table[i][2]
	local hex = fs_table[i][3]

minetest.register_node("ma_pops_furniture:fs_"..color, {
	description = name.." Footstool",
	tiles = {"wool_"..color..".png","wool_"..color..".png^mp_cb.png","wool_"..color..".png^mp_cf.png","wool_"..color..".png^mp_cf.png","wool_"..color..".png^mp_cf.png","wool_"..color..".png^mp_cf.png",},
    drawtype = "nodebox",
    paramtype = "light",
	sounds = moditems.WOOD_SOUNDS,
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, furniture = 1},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.4, -0.5, -0.4, -0.3, -0.4, -0.3},
            {-0.4, -0.5, 0.4, -0.3, -0.4, 0.3},
            {0.4, -0.5, 0.4, 0.3, -0.4, 0.3},
            {0.4, -0.5, -0.4, 0.3, -0.4, -0.3},
            -----------------------------------
            {-0.450, -0.4, -0.450, 0.450, -0.1, 0.450},
        },
    },
	on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:fs_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:fs_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:fs_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:fs_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:fs_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:fs_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:fs_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:fs_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:fs_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:fs_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:fs_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:fs_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:fs_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:fs_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:fs_brown"
               minetest.set_node(pos, node)
                      end
                     end
                    end
                   end
                  end
                 end
                end
               end
              end
             end
            end
           end
          end
         end
        end
       end
		 end
})
end
