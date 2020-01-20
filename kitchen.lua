local counter_table = { --name, color, colorize(hex or color name:intensity(1-255))
{'Black', 'black', 'black:200'},
{'Blue', 'blue', 'blue:125'},
{'Brown', 'brown', 'brown:75'},
{'Cyan', 'cyan', 'cyan:125'},
{'Dark Green', 'dark_green', 'green:190'},
--{'Dark Grey', 'dark_grey', 'black:200'},
{'Green', 'green', '#32cd32:125'},
--{'Grey', 'grey', 'black:150'},
{'Magenta', 'magenta', 'magenta:190'},
{'Orange', 'orange', 'orange:125'},
{'Pink', 'pink', 'pink:190'},
{'Red', 'red', 'red:125'},
{'Violet', 'violet', 'violet:125'},
{'White', 'white', 'white:125'},
{'Yellow', 'yellow', 'yellow:125'},
}

for i in ipairs (counter_table) do
	local name = counter_table[i][1]
	local color = counter_table[i][2]
	local hex = counter_table[i][3]

minetest.register_node("ma_pops_furniture:counter_"..color, {
	description = name.. " Counter (Vertical Drawers)",
	tiles = {
		"default_coral_skeleton.png^[colorize:"..hex,
		"mp_enc_bottom.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_right.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_left.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_back.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = moditems.WOOD_SOUNDS,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('storage', 6*6)
		meta:set_string('formspec',
			'size [9,10.5]'..
			'bgcolor[#080808BB;true]'..
			'list[current_name;storage;1.5,.2;6,6;]'..
			'list[current_player;main;0.5,6.5;8,4;]')
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('storage') and inv:is_empty('storage1')
	end,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.4375, -0.375, 0.5, 0.375, 0.5},
			{-0.4375, -0.375, -0.4375, -0.0625, 0.3125, -0.375},
			{0.0625, -0.375, -0.4375, 0.4375, 0.3125, -0.375},
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5},
			{-0.1875, -0.0625, -0.5, -0.125, 0, -0.4375},
			{0.125, -0.0625, -0.5, 0.1875, 0, -0.4375},
			{-0.5, -0.5, -0.3125, 0.5, -0.4375, 0.5},
		}
	},
	on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:counter_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:counter_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:counter_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:counter_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:counter_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:counter_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:counter_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:counter_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:counter_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:counter_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:counter_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:counter_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:counter_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:counter_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:counter_brown"
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

minetest.register_node("ma_pops_furniture:counter2_"..color, {
	description = name.. " Counter",
	tiles = {
		"default_coral_skeleton.png^[colorize:"..hex,
		"mp_enc_bottom.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_right.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_left.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_back.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_back.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	sounds = moditems.WOOD_SOUNDS,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.4375, -0.375, 0.5, 0.375, 0.5}, 
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5},
			{-0.5, -0.5, -0.3125, 0.5, -0.4375, 0.5},
		}
	},
	on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:counter2_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:counter2_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:counter2_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:counter2_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:counter2_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:counter2_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:counter2_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:counter2_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:counter2_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:counter2_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:counter2_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:counter2_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:counter2_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:counter2_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:counter2_brown"
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

minetest.register_node("ma_pops_furniture:counter3_"..color, {
	description = name.. " Counter (Horizontal Drawers)",
	tiles = {
		"default_coral_skeleton.png^[colorize:"..hex,
		"mp_enc_bottom.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_right.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_left.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_back.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_front2.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = moditems.WOOD_SOUNDS,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('storage', 6*6)
		meta:set_string('formspec',
			'size [9,10.5]'..
			'bgcolor[#080808BB;true]'..
			'list[current_name;storage;1.5,.2;6,6;]'..
			'list[current_player;main;0.5,6.5;8,4;]')
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('storage') and inv:is_empty('storage1')
	end,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.4375, -0.375, 0.5, 0.375, 0.5}, 
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5},
			{-0.5, -0.5, -0.3125, 0.5, -0.4375, 0.5}, 
			{-0.4375, 0, -0.4375, 0.4375, 0.3125, -0.375}, 
			{-0.4375, -0.375, -0.4375, 0.4375, -0.0625, -0.375},
			{-0.1875, 0.125, -0.5, 0.1875, 0.1875, -0.4375},
			{-0.1875, -0.25, -0.5, 0.1875, -0.1875, -0.4375},
		}
	},
	on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:counter3_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:counter3_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:counter3_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:counter3_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:counter3_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:counter3_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:counter3_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:counter3_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:counter3_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:counter3_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:counter3_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:counter3_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:counter3_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:counter3_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:counter3_brown"
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

minetest.register_node("ma_pops_furniture:counter1_" ..color, {
	description = name.. " Counter (Corner)",
	tiles = {
		"default_coral_skeleton.png^[colorize:"..hex,
		"mp_corn_r_bottom.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_back.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_back.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_back.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_back.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	sounds = moditems.WOOD_SOUNDS,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{0.5, 0.5, 0.5, -0.5, -0.5, -0.5}, -- NodeBox1
		}
	},
	on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:counter1_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:counter1_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:counter1_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:counter1_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:counter1_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:counter1_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:counter1_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:counter1_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:counter1_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:counter1_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:counter1_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:counter1_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:counter1_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:counter1_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:counter1_brown"
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

minetest.register_node("ma_pops_furniture:sink_" ..color, {
	description = name.. " Counter (Sink)",
	tiles = {
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_sink_top.png",
		"mp_enc_bottom.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_right.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_left.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_back.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_enc_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = moditems.WOOD_SOUNDS,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('storage', 6*6)
		meta:set_string('formspec',
			'size [9,10.5]'..
			'bgcolor[#080808BB;true]'..
			'list[current_name;storage;1.5,.2;6,6;]'..
			'list[current_player;main;0.5,6.5;8,4;]')
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('storage') and inv:is_empty('storage1')
	end,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.3125, 0.5, -0.4375, 0.5}, -- NodeBox1
			{-0.5, -0.4375, -0.375, 0.5, 0.375, 0.5}, -- NodeBox2
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox3
			{-0.4375, -0.375, -0.4375, -0.0625, 0.3125, -0.375}, -- NodeBox4
			{0.0625, -0.375, -0.4375, 0.4375, 0.3125, -0.375}, -- NodeBox5
			{-0.1875, -0.0625, -0.5, -0.125, 0, -0.4375}, -- NodeBox6
			{0.125, -0.0625, -0.5, 0.1875, 0, -0.4375}, -- NodeBox7
		}
	},
	on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:sink_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:sink_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:sink_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:sink_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:sink_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:sink_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:sink_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:sink_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:sink_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:sink_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:sink_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:sink_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:sink_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:sink_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:sink_brown"
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

minetest.register_node("ma_pops_furniture:upcabinet_"..color, {
description = name.." Upper Cabinets",
	tiles = {
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_up_top.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_up_bottom.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_up_right.png",
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_up_left.png",
		"default_coral_skeleton.png^[colorize:"..hex,
		"default_coral_skeleton.png^[colorize:"..hex.."^mp_up_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('storage', 3*3)
		meta:set_string('formspec',
			'size [9,10.5]'..
			'bgcolor[#080808BB;true]'..
			'list[current_name;storage;3,1.3;3,3;]'..
			'list[current_player;main;0.5,6.5;8,4;]')
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('storage') and inv:is_empty('storage1')
	end,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.3125, -0.375, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.4375, -0.25, -0.4375, -0.0625, 0.4375, -0.375}, -- NodeBox2
			{0.0625, -0.25, -0.4375, 0.4375, 0.4375, -0.375}, -- NodeBox3
			{-0.1875, -0.1875, -0.5, -0.125, 0, -0.4375}, -- NodeBox4
			{0.125, -0.1875, -0.5, 0.1875, 0, -0.4375}, -- NodeBox5
		}
	},
	on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:upcabinet_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:upcabinet_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:upcabinet_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:upcabinet_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:upcabinet_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:upcabinet_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:upcabinet_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:upcabinet_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:upcabinet_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:upcabinet_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:upcabinet_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:upcabinet_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:upcabinet_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:upcabinet_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:upcabinet_brown"
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

local counter_table = { --name, material
{'Wooden', 'wood'},
{'Acacia', 'acacia_wood'},
{'Jungle', 'junglewood' },
{'Pine', 'pine_wood'},
{'Aspen', 'aspen_wood'},
}

for i in ipairs (counter_table) do
	local name = counter_table[i][1]
	local material = counter_table[i][2]

minetest.register_node("ma_pops_furniture:counter_"..material, {
	description = name.. " Counter (Vertical Drawers)",
	tiles = {
		"default_"..material..".png",
		"mp_enc_bottom.png",
		"default_"..material..".png^mp_enc_right.png",
		"default_"..material..".png^mp_enc_left.png",
		"default_"..material..".png^mp_enc_back.png",
		"default_"..material..".png^mp_enc_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('storage', 6*6)
		meta:set_string('formspec',
			'size [9,10.5]'..
			'bgcolor[#080808BB;true]'..
			'list[current_name;storage;1.5,.2;6,6;]'..
			'list[current_player;main;0.5,6.5;8,4;]')
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('storage') and inv:is_empty('storage1')
	end,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.4375, -0.375, 0.5, 0.375, 0.5},
			{-0.4375, -0.375, -0.4375, -0.0625, 0.3125, -0.375},
			{0.0625, -0.375, -0.4375, 0.4375, 0.3125, -0.375},
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5},
			{-0.1875, -0.0625, -0.5, -0.125, 0, -0.4375},
			{0.125, -0.0625, -0.5, 0.1875, 0, -0.4375},
			{-0.5, -0.5, -0.3125, 0.5, -0.4375, 0.5},
		}
	},
})

minetest.register_node("ma_pops_furniture:counter2_"..material, {
	description = name.. " Counter",
	tiles = {
		"default_"..material..".png",
		"mp_enc_bottom.png",
		"default_"..material..".png^mp_enc_right.png",
		"default_"..material..".png^mp_enc_left.png",
		"default_"..material..".png^mp_enc_back.png",
		"default_"..material..".png^mp_enc_back.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.4375, -0.375, 0.5, 0.375, 0.5}, 
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5},
			{-0.5, -0.5, -0.3125, 0.5, -0.4375, 0.5},
		}
	},
})

minetest.register_node("ma_pops_furniture:counter3_"..material, {
	description = name.. " Counter (Horizontal Drawers)",
	tiles = {
		"default_"..material..".png",
		"mp_enc_bottom.png",
		"default_"..material..".png^mp_enc_right.png",
		"default_"..material..".png^mp_enc_left.png",
		"default_"..material..".png^mp_enc_back.png",
		"default_"..material..".png^mp_enc_front2.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('storage', 6*6)
		meta:set_string('formspec',
			'size [9,10.5]'..
			'bgcolor[#080808BB;true]'..
			'list[current_name;storage;1.5,.2;6,6;]'..
			'list[current_player;main;0.5,6.5;8,4;]')
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('storage') and inv:is_empty('storage1')
	end,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.4375, -0.375, 0.5, 0.375, 0.5}, 
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5},
			{-0.5, -0.5, -0.3125, 0.5, -0.4375, 0.5}, 
			{-0.4375, 0, -0.4375, 0.4375, 0.3125, -0.375}, 
			{-0.4375, -0.375, -0.4375, 0.4375, -0.0625, -0.375},
			{-0.1875, 0.125, -0.5, 0.1875, 0.1875, -0.4375},
			{-0.1875, -0.25, -0.5, 0.1875, -0.1875, -0.4375},
		}
	},
})

minetest.register_node("ma_pops_furniture:counter1_" ..material, {
	description = name.. " Counter (Corner)",
	tiles = {
		"default_"..material..".png",
		"mp_corn_r_bottom.png",
		"default_"..material..".png^mp_enc_back.png",
		"default_"..material..".png^mp_enc_back.png",
		"default_"..material..".png^mp_enc_back.png",
		"default_"..material..".png^mp_enc_back.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{0.5, 0.5, 0.5, -0.5, -0.5, -0.5}, -- NodeBox1
		}
	},
})

minetest.register_node("ma_pops_furniture:sink_" ..material, {
	description = name.. " Counter (Sink)",
	tiles = {
		"default_"..material..".png^mp_sink_top.png",
		"mp_enc_bottom.png",
		"default_"..material..".png^mp_enc_right.png",
		"default_"..material..".png^mp_enc_left.png",
		"default_"..material..".png^mp_enc_back.png",
		"default_"..material..".png^mp_enc_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('storage', 6*6)
		meta:set_string('formspec',
			'size [9,10.5]'..
			'bgcolor[#080808BB;true]'..
			'list[current_name;storage;1.5,.2;6,6;]'..
			'list[current_player;main;0.5,6.5;8,4;]')
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('storage') and inv:is_empty('storage1')
	end,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.3125, 0.5, -0.4375, 0.5}, -- NodeBox1
			{-0.5, -0.4375, -0.375, 0.5, 0.375, 0.5}, -- NodeBox2
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox3
			{-0.4375, -0.375, -0.4375, -0.0625, 0.3125, -0.375}, -- NodeBox4
			{0.0625, -0.375, -0.4375, 0.4375, 0.3125, -0.375}, -- NodeBox5
			{-0.1875, -0.0625, -0.5, -0.125, 0, -0.4375}, -- NodeBox6
			{0.125, -0.0625, -0.5, 0.1875, 0, -0.4375}, -- NodeBox7
		}
	},
})

minetest.register_node("ma_pops_furniture:upcabinet_"..material, {
description = name.." Upper Cabinets",
	tiles = {
		"default_"..material..".png^mp_up_top.png",
		"default_"..material..".png^mp_up_bottom.png",
		"default_"..material..".png^mp_up_right.png",
		"default_"..material..".png^mp_up_left.png",
		"default_"..material..".png",
		"default_"..material..".png^mp_up_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('storage', 3*3)
		meta:set_string('formspec',
			'size [9,10.5]'..
			'bgcolor[#080808BB;true]'..
			'list[current_name;storage;3,1.3;3,3;]'..
			'list[current_player;main;0.5,6.5;8,4;]')
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('storage') and inv:is_empty('storage1')
	end,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.3125, -0.375, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.4375, -0.25, -0.4375, -0.0625, 0.4375, -0.375}, -- NodeBox2
			{0.0625, -0.25, -0.4375, 0.4375, 0.4375, -0.375}, -- NodeBox3
			{-0.1875, -0.1875, -0.5, -0.125, 0, -0.4375}, -- NodeBox4
			{0.125, -0.1875, -0.5, 0.1875, 0, -0.4375}, -- NodeBox5
		}
	},
})
end

minetest.register_node("ma_pops_furniture:upcabinet_corner", {
description = "Upper Cabinets(corner)",
	tiles = {
		"mp_grif_sides.png",
		"mp_grif_sides.png",
		"mp_grif_sides.png",
		"mp_grif_sides.png",
		"mp_grif_sides.png",
		"mp_grif_sides.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
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
			{-0.5, -0.3125, -0.5, 0.5, 0.5, 0.5},
		}
	}
})

minetest.register_node("ma_pops_furniture:dw", {
	description= "Dishwasher",
	tiles = {
		"mp_dw_top.png",
		"mp_dw_bottom.png",
		"mp_dw_left.png",
		"mp_dw_right.png",
		"mp_dw_back.png",
		"mp_dw_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, 0.4375}, 
			{-0.5, -0.4375, -0.4375, 0.5, 0.5, 0.5}, 
			{-0.5, 0.3125, -0.5, 0.5, 0.5, -0.4375}, 
			{-0.4375, -0.4375, -0.5, 0.4375, 0.25, 0.5}, 
		}
	}
})

minetest.register_node("ma_pops_furniture:oven_overhead", {
	description= "Oven Overhead",
	tiles = {
		"mp_camp_top.png",
		"mp_camp_bottom.png",
		"mp_camp_left.png",
		"mp_camp_right.png",
		"mp_camp_back.png",
		"mp_camp_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, 0.4375, -0.4375, 0.4375, 0.5, 0.4375}, 
			{-0.5, 0.25, -0.5, 0.5, 0.4375, 0.5}, 
		}
	}
})

minetest.register_node("ma_pops_furniture:microwave", {
   description = "Microwave",
   tiles = {
		"mp_mw_top.png",
		"mp_mw_bottom.png",
		"mp_mw_right.png",
		"mp_mw_left.png",
		"mp_mw_back.png",
		"mp_mw_front.png"
	},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
   node_box = {
       type = "fixed",
       fixed = {
           {-0.4375, -0.4375, -0.3125, 0.4375, 0.0625, 0.3125},
			{-0.375, -0.5, -0.25, 0.375, -0.4375, 0.25}, 
       },
   }
})

minetest.register_node("ma_pops_furniture:coffee_maker", {
	description = "Coffee Maker",
	tiles = {
		"mp_cof_top.png",
		"mp_cof_bottom.png",
		"mp_cof_right.png",
		"mp_cof_left.png",
		"mp_cof_back.png",
		"mp_cof_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.0625, 0, -0.4375, 0.4375},
			{-0.4375, -0.5, 0.3125, 0, 0.1875, 0.4375}, 
			{-0.4375, -0.0625, 0, 0, 0.25, 0.4375}, 
			{-0.375, -0.4375, 0, -0.0625, -0.125, 0.25}, 
			{-0.25, -0.375, -0.125, -0.1875, -0.1875, 0.0625}, 
		}
	}
})

minetest.register_node("ma_pops_furniture:coffee_cup", {
	description = "Coffee Cup",
	tiles = {
		"mp_cof_top.png",
		"mp_cof_top.png",
		"mp_cof_right.png",
		"mp_cof_left.png",
		"mp_cof_back.png",
		"mp_cof_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakably_by_hand=2, furniture=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, 0, -0.0625, -0.1875, 0.3125}, -- NodeBox1
			{-0.25, -0.3125, -0.125, -0.1875, -0.25, 0}, -- NodeBox2
			{-0.25, -0.4375, -0.125, -0.1875, -0.375, 0}, -- NodeBox3
			{-0.25, -0.375, -0.125, -0.1875, -0.3125, -0.0625}, -- NodeBox4
		}
	}
})

minetest.register_node("ma_pops_furniture:toaster", {
   description = "Toaster",
   tiles = {
		"mp_toas_top.png",
		"mp_toas_bottom.png",
		"mp_toas_right.png",
		"mp_toas_left.png",
		"mp_toas_back.png",
		"mp_toas_front.png"
	},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
   node_box = {
       type = "fixed",
       fixed = {
           {-0.375, -0.5, 0, 0.375, -0.0625, 0.3125},
		   {-0.4375, -0.1875, 0.0625, -0.375, -0.125, 0.25},
       },
   }
})

minetest.register_node("ma_pops_furniture:faucet_kitchen", {
   description = "Kitchen Faucet",
   tiles = {
		"mp_grif_top.png",
		"mp_grif_sides.png",
		"mp_grif_sides.png",
		"mp_grif_sides.png",
		"mp_grif_sides.png",
		"mp_grif_sides.png"
	},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
   node_box = {
       type = "fixed",
       fixed = {
			{-0.0625, -0.5, 0.375, 0.0625, -0.1875, 0.4375},
			{-0.0625, -0.1875, 0.0625, 0.0625, -0.125, 0.4375},
			{-0.0625, -0.25, 0.0625, 0.0625, -0.1875, 0.125},
			{0.125, -0.5, 0.3125, 0.25, -0.375, 0.4375},
			{-0.25, -0.5, 0.3125, -0.125, -0.375, 0.4375},
       },
   }
})

minetest.register_node("ma_pops_furniture:cutting_board", {
   description = "Cutting Board",
   tiles = {
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png"
	},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
   node_box = {
       type = "fixed",
       fixed = {
			{-0.4375, -0.5, -0.25, 0.25, -0.4375, 0.25},
			{0.25, -0.5, -0.0625, 0.4375, -0.4375, 0.0625},
       },
   }
})

minetest.register_node("ma_pops_furniture:tile_kitchen", {
   description = "White Kitchen Tile",
   tiles = {
		"mp_kitchen_tile.png",
		"mp_kitchen_tile.png",
		"mp_kitchen_tile.png",
		"mp_kitchen_tile.png",
		"mp_kitchen_tile.png",
		"mp_kitchen_tile.png"
	},
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
})

minetest.register_node("ma_pops_furniture:tile_floor_kitchen", {
   description = "Checker Kitchen Floor Tile",
   tiles = {
		"mp_kitchen_floor_tile.png",
		"mp_kitchen_floor_tile.png",
		"mp_kitchen_floor_tile.png",
		"mp_kitchen_floor_tile.png",
		"mp_kitchen_floor_tile.png",
		"mp_kitchen_floor_tile.png"
	},
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
})

minetest.register_node('ma_pops_furniture:trash_can', {
	description = 'Trash Can',
	drawtype = 'nodebox',
	tiles = {'default_steel_block.png'},
	groups = {cracky=2, oddly_breakably_by_hand=2, furniture=1},
	--inventory_image = 'fm_chair_stone.png',
	paramtype = 'light',
	paramtype2 = 'facedir',
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}, -- NodeBox1
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375}, -- NodeBox2
			{-0.125, 0.4375, -0.3125, 0.125, 0.5, 0.3125}, -- NodeBox3
		}
	},
	sounds = moditems.WOOD_SOUNDS,
		on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
			"size[8,9]" ..
			"button[0,0;2,1;empty;Empty Trash]" ..
			"list[context;trashlist;3,1;2,3;]" ..
			"list[current_player;main;0,5;8,4;]"
		)
		meta:set_string("infotext", "Trash Can")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
		inv:set_size("trashlist", 2*3)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
				return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in trash can at " .. minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to trash can at " .. minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from trash can at " .. minetest.pos_to_string(pos))
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if fields.empty then
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_list("trashlist", {})
			minetest.sound_play("trash", {to_player=sender:get_player_name(), gain = 1.0})
			minetest.log("action", sender:get_player_name() ..
				" empties trash can at " .. minetest.pos_to_string(pos))
		end
	end
})