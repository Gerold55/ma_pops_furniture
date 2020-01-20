minetest.register_node("ma_pops_furniture:smoke_detector", {
	description = "Smoke Detector",
	tiles = {
		"mp_t.png",
		"mp_b.png",
		"mp_si.png",
		"mp_si.png",
		"mp_si.png",
		"mp_si.png"
	},
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	on_timer = function(pos,elapsed)
		if minetest.find_node_near(pos, 20, {"fire:basic_flame"}, false) then
			local node = minetest.get_node(pos)
			node.name = "ma_pops_furniture:smoke_detector_on"
			minetest.remove_node(pos)
			minetest.add_node(pos, node)
			minetest.get_node_timer(pos):start(0.0)
		else
			-- Update every 10 seconds.
			minetest.get_node_timer(pos):start(10.0)
		end
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		minetest.get_node_timer(pos):start(0.0)
	end,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, 0.375, -0.375, 0.375, 0.5, 0.375}, -- NodeBox1
			{-0.3125, 0.3125, -0.3125, 0.3125, 0.375, 0.3125}, -- NodeBox2
		}
	}
})

minetest.register_node("ma_pops_furniture:smoke_detector_on", {
	description = "Smoke Detector",
	tiles = {
		"mp_t.png",
		"mp_b.png",
		"mp_si.png",
		"mp_si.png",
		"mp_si.png",
		"mp_si.png"
	},
	on_destruct = function(pos)
		local meta = minetest.get_meta(pos)
		if meta then
			local tmp = meta:to_table()
			if tmp then
				if tmp.fields.sound_handle then
					minetest.sound_stop(tmp.fields.sound_handle)
					tmp.fields.sound_handle = nil
					meta:from_table(tmp)
				end
			end
		end
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		if meta then
			local tmp = meta:to_table()
			if tmp then
				if tmp.fields.sound_handle then
					minetest.sound_stop(tmp.fields.sound_handle)
					tmp.fields.sound_handle = nil
					minetest.get_node_timer(pos):start(3.0)
					meta:from_table(tmp)
				end
			end
		end
	end,
	drop = 'ma_pops_furniture:smoke_detector',
	groups = {cracky = 3, oddly_breakable_by_hand = 3, not_in_creative_inventory=  1},
	on_timer = function(pos,elapsed)
		if minetest.find_node_near(pos, 20, {"fire:basic_flame"}, false) then
			-- Play sound.
			local meta = minetest.get_meta(pos)
			if meta then
				local tmp = meta:to_table()
				if tmp then
					if not tmp.fields.sound_handle then
						local handle = minetest.sound_play("mp_smoke_detector", {pos = pos, gain = 2.1,max_hear_distance = 96,loop = true})
						tmp.fields.sound_handle = handle
					end
				end
				meta:from_table(tmp)
			end
			-- Update every 1.0 second.
			minetest.get_node_timer(pos):start(1.0)
		else
			local meta = minetest.get_meta(pos)
			if meta then
				local tmp = meta:to_table()
				if tmp then
					minetest.sound_stop(tmp.fields.sound_handle)
					if tmp.fields.sound_handle then
						tmp.fields.sound_handle = nil
						meta:from_table(tmp)
					end
				end
			end
			local node = minetest.get_node(pos)
			node.name = "ma_pops_furniture:smoke_detector"
			minetest.remove_node(pos)
			minetest.add_node(pos, node)
			minetest.get_node_timer(pos):start(0.0)
		end
	end,
	drawtype = "nodebox",
	paramtype = "light",
	light_source = light,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, 0.375, -0.375, 0.375, 0.5, 0.375}, -- NodeBox1
			{-0.3125, 0.3125, -0.3125, 0.3125, 0.375, 0.3125}, -- NodeBox2
		}
	}
})

minetest.register_lbm({
	label = "Replace all smoke detector's that are turned on.",
	name = "ma_pops_furniture:replace_smoke_detector_on",
	nodenames = {"ma_pops_furniture:smoke_detector_on"},
	run_at_every_load = true,
	action = function(pos, node)
		node.name = "ma_pops_furniture:smoke_detector"
		minetest.remove_node(pos)
		minetest.add_node(pos, node)
		minetest.get_node_timer(pos):start(0.0)
	end
})

minetest.register_node("ma_pops_furniture:barrel", {
	description = "Barrel",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {
		"mp_barrel.png", --top
		"mp_barrel.png", --bottom
		"mp_barrel.png^[transformR90", --right
		"mp_barrel.png^[transformR90", --left
		"mp_barrel_top.png", --back
		"mp_barrel_top.png" --front
	},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('storage', 9*3)
		meta:set_string('formspec',
			'size [9,9]'..
			'bgcolor[#080808BB;false]'..
			'list[current_name;storage;0,0.2;9,3;]'..
			'list[current_player;main;0.5,5;8,4;]')
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('storage') and inv:is_empty('storage1')
	end,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		}
	}
})

minetest.register_node("ma_pops_furniture:blinds", {
   description = "Blinds",
   tiles = {"mp_blinds.png"},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, furniture = 1},
   sunlight_propagates = true;
   node_box = {
       type = "fixed",
       fixed = {
           {-0.5, 0.5, 0.5, 0.5, 0.4, 0.4},
           {-0.5, 0.3, 0.5, 0.5, 0.2, 0.4},
           {-0.5, 0.1, 0.5, 0.5, 0.0, 0.4},
           {-0.5, -0.1, 0.5, 0.5, -0.2, 0.4},
           {-0.5, -0.3, 0.5, 0.5, -0.4, 0.4},
       },
   }
})

minetest.register_node("ma_pops_furniture:light", {	
	description = "Ceiling Light",
	tiles = {
		"default_coral_skeleton.png",
		"mp_ceiling_light_bottom.png",
		"mp_ceiling_light_side.png",
		"mp_ceiling_light_side.png",
		"mp_ceiling_light_side.png",
		"mp_ceiling_light_side.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
	node.name = "ma_pops_furniture:light_on"
	minetest.set_node(pos, node)
	end,
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.4375, -0.25, 0.25, 0.5, 0.25}, -- NodeBox1
			{-0.125, 0.3125, -0.125, 0.125, 0.4375, 0.125}, -- NodeBox2
			{-0.1875, -0.0625, -0.1875, 0.1875, 0.3125, 0.1875}, -- NodeBox3
		},
	}
})

minetest.register_node("ma_pops_furniture:light_on", {	
	description = "Ceiling Light",
	tiles = {
		"default_coral_skeleton.png",
		"mp_ceiling_light_bottom.png",
		"mp_ceiling_light_side.png",
		"mp_ceiling_light_side.png",
		"mp_ceiling_light_side.png",
		"mp_ceiling_light_side.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "ma_pops_furniture:light",
	light_source = 14,
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
	node.name = "ma_pops_furniture:light"
	minetest.set_node(pos, node)
	end,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.4375, -0.25, 0.25, 0.5, 0.25}, -- NodeBox1
			{-0.125, 0.3125, -0.125, 0.125, 0.4375, 0.125}, -- NodeBox2
			{-0.1875, -0.0625, -0.1875, 0.1875, 0.3125, 0.1875}, -- NodeBox3
		},
	}
})

minetest.register_node("ma_pops_furniture:ceiling_lamp", {
   description = "Ceiling Lamp",
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
   node.name = "ma_pops_furniture:ceiling_lamp_on"
   minetest.set_node(pos, node)
   end,
   groups = {choppy = 2, oddly_breakable_by_hand = 2},
   node_box = {
       type = "fixed",
       fixed = {
           {-0.050, 0.5, -0.050, 0.050, -0.2, 0.050},
           {-0.1, -0.0, -0.1, 0.1, -0.2, 0.1},
           {-0.2, -0.1, -0.2, 0.2, -0.2, 0.2},
           {-0.3, -0.2, -0.3, 0.3, -0.5, 0.3},
       },
   }
})

minetest.register_node("ma_pops_furniture:ceiling_lamp_on", {
   description = "Ceiling Lamp On",
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
   drop = 'ma_pops_furniture:ceiling_lamp',
   on_rightclick = function (pos, node, player, itemstack, pointed_thing)
   node.name = "ma_pops_furniture:ceiling_lamp"
minetest.set_node(pos, node)
end,
   groups = {choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
   node_box = {
       type = "fixed",
       fixed = {
           {-0.050, 0.5, -0.050, 0.050, -0.2, 0.050},
           {-0.1, -0.0, -0.1, 0.1, -0.2, 0.1},
           {-0.2, -0.1, -0.2, 0.2, -0.2, 0.2},
           {-0.3, -0.2, -0.3, 0.3, -0.5, 0.3},
       },
   }
})

minetest.register_node("ma_pops_furniture:fan_on", {
   description = "Fan (on)",
   tiles = {
		"default_coral_skeleton.png",
		"default_coral_skeleton.png",
		"default_coral_skeleton.png",
		"default_coral_skeleton.png",
		{
			name = "mp_fan_on.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.3
			},
		},
},
   drawtype = "nodebox",
   drop = 'ma_pops_furniture:fan_off',
   paramtype2 = "facedir",
   on_rightclick = function (pos, node, player, itemstack, pointed_thing)
node.name = "ma_pops_furniture:fan_off"
minetest.set_node(pos, node)
end,
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1},
   node_box = {
       type = "fixed",
       fixed = {
          {-0.5, 0.5, 0.2, 0.5, -0.5, -0.2},
       },  
   }
})
minetest.register_node("ma_pops_furniture:fan_off", {
   description = "Fan",
   tiles = {
		"default_coral_skeleton.png",
		"default_coral_skeleton.png",
		"default_coral_skeleton.png",
		"default_coral_skeleton.png",
	    "mp_fan_off.png",
		"mp_fan_off.png",
},
   drawtype = "nodebox",
   drop = 'ma_pops_furniture:fan_off',
   paramtype2 = "facedir",
   on_rightclick = function (pos, node, player, itemstack, pointed_thing)
node.name = "ma_pops_furniture:fan_on"
minetest.set_node(pos, node)
end,
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
   node_box = {
       type = "fixed",
       fixed = {
          {-0.5, 0.5, 0.2, 0.5, -0.5, -0.2},
       },  
   }
})

minetest.register_node("ma_pops_furniture:ac", {
   description = "AC",
   tiles = {
		"mp_ac_top.png",
		"mp_ac_top.png",
		"mp_ac_top.png",
		"mp_ac_top.png",
		"mp_ac_b.png",
		"mp_ac_f.png",
		},
   drawtype = "nodebox",
   paramtype = "light",
   drop = 'ma_pops_furniture:ac',
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
   node_box = {
       type = "fixed",
       fixed = {
          {0.5, 0.5, 0.5, -0.5, -0.5, -0.4},
          {0.5, 0.2, -0.5, -0.5, -0.5, -0.4},
       },  
   }
})

local lamp_table = { --name, color, colorize(hex or color name:intensity(1-255))
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

for i in ipairs (lamp_table) do
	local name = lamp_table[i][1]
	local color = lamp_table[i][2]
	local hex = lamp_table[i][3]

minetest.register_node("ma_pops_furniture:lamp_"..color, {
	description= name.. " Lamp",
	tiles= {"mp_lt.png","mp_lb_middle.png^[colorize:"..hex.."^mp_lb.png","mp_ls.png^[colorize:"..hex.."^mp_ls_top.png","mp_ls.png^[colorize:"..hex.."^mp_ls_top.png","mp_ls.png^[colorize:"..hex.."^mp_ls_top.png","mp_ls.png^[colorize:"..hex.."^mp_ls_top.png",},
	drawtype= "nodebox",
	light_source =  14,
	paramtype = "facedir",
	drop= 'ma_pops_furniture:lamp_off_'..color,
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
		node.name = "ma_pops_furniture:lamp_off_"..color
		minetest.set_node(pos, node)
	end,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1, furniture = 1},
	node_box= {
		type= "fixed",
		fixed= {
			{-0.25, -0.4375, -0.25, 0.25, -0.0625, 0.25},
			{-0.375, -0.0625, -0.375, 0.375, 0.5, 0.375},
			{-0.1875, -0.4375, -0.1875, 0.1875, -0.5, 0.1875},
		},
	},
	on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:lamp_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:lamp_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:lamp_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:lamp_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:lamp_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:lamp_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:lamp_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:lamp_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:lamp_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:lamp_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:lamp_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:lamp_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:lamp_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:lamp_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:lamp_brown"
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

minetest.register_node("ma_pops_furniture:lamp_off_"..color, {
	description= name.. " Lamp",
	tiles= {"mp_lt.png","mp_lb_middle.png^[colorize:"..hex.."^mp_lb.png","mp_ls.png^[colorize:"..hex.."^mp_ls_top.png","mp_ls.png^[colorize:"..hex.."^mp_ls_top.png","mp_ls.png^[colorize:"..hex.."^mp_ls_top.png","mp_ls.png^[colorize:"..hex.."^mp_ls_top.png",},
	drawtype= "nodebox",
	paramtype = "facedir",
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
		node.name = "ma_pops_furniture:lamp_"..color
		minetest.set_node(pos, node)
	end,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, furniture = 1},
	node_box= {
		type= "fixed",
		fixed= {
			{-0.25, -0.4375, -0.25, 0.25, -0.0625, 0.25},
			{-0.375, -0.0625, -0.375, 0.375, 0.5, 0.375},
			{-0.1875, -0.4375, -0.1875, 0.1875, -0.5, 0.1875},
		},
	},
	on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:lamp_off_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:lamp_off_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:lamp_off_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:lamp_off_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:lamp_off_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:lamp_off_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:lamp_off_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:lamp_off_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:lamp_off_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:lamp_off_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:lamp_off_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:lamp_off_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:lamp_off_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:lamp_off_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:lamp_off_brown"
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

local curtain_table = { --name, color, colorize(hex or color name:intensity(1-255))
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

for i in ipairs (curtain_table) do
	local name = curtain_table[i][1]
	local color = curtain_table[i][2]
	local hex = curtain_table[i][3]

minetest.register_node("ma_pops_furniture:curtains_"..color, {
	description= name.. " Curtains",
	tiles= {"default_acacia_tree.png","wool_"..color..".png^mp_curtainb.png","wool_"..color..".png^mp_curtains.png","wool_"..color..".png^mp_curtains.png","wool_"..color..".png^mp_curtains.png","wool_"..color..".png^mp_curtains.png",},
	drawtype= "nodebox",
	paramtype= "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, furniture = 1},
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		node.name = "ma_pops_furniture:curtains_closed_"..color 
		minetest.set_node(pos, node)
	end,
	node_box= {
		type= "fixed",
		fixed= {
			{-0.5, -0.3, 0.5, -0.2, 0.5, 0.4},
			{-0.5, -0.5, 0.5, -0.3, -0.3, 0.4},
			{-0.5, 0.5, 0.5, 0.5, 0.2, 0.4},
			{-0.5, 0.5, 0.5, 0.5, 0.440, 0.350},
			{0.5, -0.3, 0.5, 0.2, 0.5, 0.4},
			{0.5, -0.5, 0.5, 0.3, -0.3, 0.4},
		},
	},
	on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:curtains_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:curtains_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:curtains_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:curtains_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:curtains_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:curtains_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:curtains_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:curtains_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:curtains_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:curtains_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:curtains_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:curtains_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:curtains_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:curtains_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:curtains_brown"
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

minetest.register_node("ma_pops_furniture:curtains_closed_"..color, {
   description = name.." Closed Curtains",
   tiles= {"default_acacia_tree.png","wool_"..color..".png^mp_curtainb.png","wool_"..color..".png^mp_curtains.png","wool_"..color..".png^mp_curtains.png","wool_"..color..".png^mp_curtains.png","wool_"..color..".png^mp_curtains.png",},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1, furniture = 1},
   drop = "ma_pops_furniture:curtains_"..color,
   on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		node.name = "ma_pops_furniture:curtains_"..color 
		minetest.set_node(pos, node)
	end,
   node_box = {
       type = "fixed",
       fixed = {
           {-0.5, -0.5, 0.5, 0.5, 0.5, 0.4},
		   {-0.5, 0.5, 0.5, 0.5, 0.440, 0.350},

       },
   },
   on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:curtains_closed_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:curtains_closed_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:curtains_closed_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:curtains_closed_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:curtains_closed_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:curtains_closed_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:curtains_closed_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:curtains_closed_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:curtains_closed_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:curtains_closed_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:curtains_closed_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:curtains_closed_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:curtains_closed_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:curtains_closed_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:curtains_closed_brown"
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

minetest.register_node("ma_pops_furniture:curtains_2_tall_"..color, {
	description= name.. " Tall Curtains",
	tiles = {"wool_"..color..".png"},
	drawtype= "nodebox",
	paramtype= "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, furniture = 1},
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		node.name = "ma_pops_furniture:curtains_2_tall_closed_"..color 
		minetest.set_node(pos, node)
	end,
	node_box= {
		type= "fixed",
		fixed= {
			{-0.5, -0.3, 0.5, -0.2, 0.5, 0.4},
			{-0.5, -0.5, 0.5, -0.3, -0.3, 0.4},
			{-0.5, 0.5, 0.5, 0.5, 0.2, 0.4},
			{0.5, -0.3, 0.5, 0.2, 0.5, 0.4},
			{0.5, -0.5, 0.5, 0.3, -0.3, 0.4},
			{-0.5, -0.5, 0.5, -0.3, -1.2, 0.4},
			{0.5, -0.5, 0.5, 0.3, -1.2, 0.4},
			{-0.5, -1.2, 0.5, -0.4, -1.5, 0.4},
			{0.5, -1.2, 0.5, 0.4, -1.5, 0.4},
		},
	},
	on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:curtains_2_tall_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:curtains_2_tall_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:curtains_2_tall_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:curtains_2_tall_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:curtains_2_tall_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:curtains_2_tall_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:curtains_2_tall_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:curtains_2_tall_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:curtains_2_tall_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:curtains_2_tall_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:curtains_2_tall_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:curtains_2_tall_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:curtains_2_tall_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:curtains_2_tall_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:curtains_2_tall_brown"
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

minetest.register_node("ma_pops_furniture:curtains_2_tall_closed_"..color, {
	description= name.. " Closed Tall Curtains",
	tiles = {"wool_"..color..".png"},
	drawtype= "nodebox",
	paramtype= "light",
	paramtype2 = "facedir",
	drop = "ma_pops_furniture:curtains_2_tall_"..color,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1},
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		node.name = "ma_pops_furniture:curtains_2_tall_"..color 
		minetest.set_node(pos, node)
	end,
	node_box= {
		type= "fixed",
		fixed= {
			   {0.5, 0.5, 0.5, -0.5, -1.5, 0.4},
		},
	},
	on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:curtains_2_tall_closed_brown"
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

minetest.register_node("ma_pops_furniture:computer", {
	description = "Computer",
	tiles = {
        "mp_s.png^mp_top.png",
        "mp_s.png",
        "mp_s.png",
        "mp_s.png",
        "mp_s.png",
        "mp_s.png^mp_f.png"
    },
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=2, oddly_breakable_by_hand=2, furniture=1, flammable=1},
	sounds = moditems.WOOD_SOUNDS,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.1875, 0.5, -0.25, 0.5},
			{-0.5, -0.5, -0.5, 0.1875, -0.375, -0.25},
			{0.25, -0.5, -0.5, 0.4375, -0.375, -0.25},
			{-0.125, -0.25, 0.0625, 0.125, -0.0625, 0.25}, 
			{-0.3125, -0.125, -0.25, 0.3125, 0.5, 0.3125}, 
			{-0.25, 0, 0.3125, 0.25, 0.375, 0.5},
		}
	}
})

local stool_table = { --name, color, colorize(hex or color name:intensity(1-255))
{'Black', 'black', 'black:225'},
{'Blue', 'blue', 'blue:150'},
{'Brown', 'brown', 'brown:100'},
{'Cyan', 'cyan', 'cyan:150'},
{'Dark Green', 'dark_green', 'green:200'},
--{'Dark Grey', 'dark_grey', 'black:200'},
{'Green', 'green', '#32cd32:150'},
--{'Grey', 'grey', 'black:150'},
{'Magenta', 'magenta', 'magenta:200'},
{'Orange', 'orange', 'orange:150'},
{'Pink', 'pink', 'pink:150'},
{'Red', 'red', 'red:150'},
{'Violet', 'violet', 'violet:150'},
{'White', 'white', 'white:150'},
{'Yellow', 'yellow', 'yellow:150'},
}

for i in ipairs (stool_table) do
	local name = stool_table[i][1]
	local color = stool_table[i][2]
	local hex = stool_table[i][3]

minetest.register_node("ma_pops_furniture:stool_"..color, {
	description = name.. " Stool",
	tiles = {
		"mp_stool_top1.png^mp_stool_top.png^[colorize:"..hex.."^mp_stool_top1.png",
		"default_coral_skeleton.png",
		"default_coral_skeleton.png",
		"default_coral_skeleton.png",
		"default_coral_skeleton.png",
		"default_coral_skeleton.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
	can_dig = ma_pops_furniture.sit_dig,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		pos.y = pos.y + 0  -- Sitting position
		ma_pops_furniture.sit(pos, node, clicker, pointed_thing)
		return itemstack
	end,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, -0.1875, 0.375, -0.1875}, -- NodeBox1
			{-0.375, -0.5, 0.1875, -0.1875, 0.375, 0.375}, -- NodeBox2
			{0.1875, -0.5, 0.1875, 0.375, 0.375, 0.375}, -- NodeBox3
			{0.1875, -0.5, -0.375, 0.375, 0.375, -0.1875}, -- NodeBox4
			{-0.375, 0.1875, -0.375, 0.375, 0.375, 0.375}, -- NodeBox5
			{0.25, -0.375, -0.1875, 0.3125, -0.3125, 0.1875}, -- NodeBox6
			{-0.1875, -0.375, -0.3125, 0.1875, -0.3125, -0.25}, -- NodeBox7
			{-0.1875, -0.375, 0.25, 0.1875, -0.3125, 0.3125}, -- NodeBox8
			{-0.3125, -0.375, -0.1875, -0.25, -0.3125, 0.1875}, -- NodeBox9
			{-0.3125, 0.375, -0.3125, 0.3125, 0.4375, 0.3125}, -- NodeBox10
		}
	},
	on_punch = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:stool_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:stool_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:stool_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:stool_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:stool_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:stool_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:stool_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:stool_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:stool_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:stool_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:stool_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:stool_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:stool_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:stool_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:stool_brown"
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

minetest.register_node("ma_pops_furniture:stairs", {
	description= "Stairs",
	tiles = {
		"default_coral_skeleton.png",
		"default_coral_skeleton.png",
		"default_coral_skeleton.png^mp_stairs_side.png",
		"default_coral_skeleton.png^mp_stairs_side.png^[transformFX",
		"default_coral_skeleton.png^mp_stairs_back.png",
		"default_coral_skeleton.png^mp_stairs_front.png"
	},
	drawtype = "mesh",
	mesh= "stairs.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.375, 0, 0.5, 0.5, 0.5}, -- NodeBox18
			{-0.5, -0.125, -0.5, 0.5, 0, 0}, -- NodeBox19
			{-0.0625, -0.375, -0.3125, 0.0625, -0.125, -0.1875}, -- NodeBox20
			{-0.0625, -0.25, 0.1875, 0.0625, 0.375, 0.3125}, -- NodeBox21
			{-0.0625, -0.375, -0.1875, 0.0625, -0.25, 0.3125}, -- NodeBox23
			{-0.0625, -0.25, 0.0625, 0.0625, -0.125, 0.1875}, -- NodeBox24
		}
	}
})

minetest.register_node("ma_pops_furniture:lamp_1", {
        description = "lamp",
        	tiles = {
		"default_stone.png",
		"default_stone.png",
		"default_stone.png",
		"default_stone.png",
		"default_stone.png",
		"default_stone.png"
	},
	groups = {cracky=2, oddly_breakable_by_hand=3},
	on_construct = function(pos)
    if minetest.get_node(vector.add(pos, vector.new(0, 1, 0))).name == "air" then 
    minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z}, {name = "ma_pops_furniture:lamp_2_off"}) 
    end 
    
	 if minetest.get_node(vector.add(pos, vector.new(0, 1, 0))).name ~= "air" then 
	 if minetest.get_node(vector.add(pos, vector.new(0, 1, 0))).name ~= "ma_pops_furniture:lamp_2_off" then 
	 minetest.set_node({x = pos.x, y = pos.y, z = pos.z},{name = "air"}) 
	 end
	 end
	 
	end,
	
	on_dig = function(pos, node, player)
   minetest.set_node({x = pos.x , y = pos.y + 1, z = pos.z}, {name = "air"}) 
   minetest.set_node({x = pos.x, y = pos.y, z = pos.z}, {name = "air"}) 
   end,
	
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, -0.375, 0.25}, -- NodeBox16
			{-0.0625, -0.375, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox17
		}
	}
})

minetest.register_node("ma_pops_furniture:lamp_2_on", {
        description = "lamp2",
        	tiles = {
		"mp_lt.png",
		"mp_lt.png",
		"default_stone.png^mp_ls_top.png",
		"default_stone.png^mp_ls_top.png",
		"default_stone.png^mp_ls_top.png",
		"default_stone.png^mp_ls_top.png"
	},
	groups = {cracky=2, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	drop = "test:node_1",
		on_dig = function(pos, node, player)
   minetest.set_node({x = pos.x , y = pos.y - 1, z = pos.z}, {name = "air"}) 
   minetest.set_node({x = pos.x, y = pos.y, z = pos.z}, {name = "air"}) 
   end,
	drawtype = "nodebox",
	paramtype = "light",
	light_source =  14,
    drop = 'ma_pops_furniture:lamp_2_off',
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
   node.name = "ma_pops_furniture:lamp_2_off"
   minetest.set_node(pos, node)
   end,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.0625, -0.375, 0.375, 0.5, 0.375}, -- NodeBox16
			{-0.0625, -0.5, -0.0625, 0.0625, 0.1875, 0.0625}, -- NodeBox17
		}
	}
})

minetest.register_node("ma_pops_furniture:lamp_2_off", {
        description = "lamp2",
        	tiles = {
		"mp_lt.png",
		"mp_lt.png",
		"default_stone.png^mp_ls_top.png",
		"default_stone.png^mp_ls_top.png",
		"default_stone.png^mp_ls_top.png",
		"default_stone.png^mp_ls_top.png"
	},
	groups = {cracky=2, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	drop = "test:node_1",
		on_dig = function(pos, node, player)
   minetest.set_node({x = pos.x , y = pos.y - 1, z = pos.z}, {name = "air"}) 
   minetest.set_node({x = pos.x, y = pos.y, z = pos.z}, {name = "air"}) 
   end,
	drawtype = "nodebox",
	paramtype = "light",
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
   node.name = "ma_pops_furniture:lamp_2_on"
   minetest.set_node(pos, node)
   end,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.0625, -0.375, 0.375, 0.5, 0.375}, -- NodeBox16
			{-0.0625, -0.5, -0.0625, 0.0625, 0.1875, 0.0625}, -- NodeBox17
		}
		}
})