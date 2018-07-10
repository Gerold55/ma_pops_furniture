--Overall--
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
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
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
	light_source = default.LIGHT_MAX - 1,
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
	sounds = default.node_sound_stone_defaults(),
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

--Bathroom--
minetest.register_node("ma_pops_furniture:bath_faucet", {
   description = "Bathroom Faucet",
   tiles = {
		"mp_knob_top.png",
		"mp_knob_bottom.png",
		"mp_knob_right.png",
		"mp_knob_left.png",
		"mp_knob_back.png",
		"mp_knob_front.png"
	},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
   node_box = {
       type = "fixed",
       fixed = {
			{-0.0625, -0.5, 0.3125, 0.0625, -0.1875, 0.4375},
			{-0.0625, -0.1875, 0.125, 0.0625, -0.125, 0.4375}, 
			{0.125, -0.25, 0.25, 0.25, -0.0625, 0.4375},
			{-0.25, -0.25, 0.25, -0.125, -0.0625, 0.4375},
			{-0.0625, -0.25, 0.125, 0.0625, -0.125, 0.1875},
			{-0.125, -0.1875, 0.3125, 0.125, -0.125, 0.375},
       },
   }
})

minetest.register_node("ma_pops_furniture:toilet_paper_roll_dispenser", {
   description = "Toilet Paper Roll Dispenser",
   tiles = {
		"mp_tp_top.png",
		"mp_tp_bottom.png",
		"mp_tp_right.png",
		"mp_tp_left.png",
		"mp_tp_back.png",
		"mp_tp_front.png"
	},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
   node_box = {
       type = "fixed",
       fixed = {
          {-0.3125, -0.1875, 0.4375, 0.3125, 0.125, 0.5},
		  {-0.1875, -0.125, 0.25, 0.1875, 0.0625, 0.4375},
		  {-0.25, -0.0625, 0.3125, 0.25, 0, 0.5},
       },
   }
})

minetest.register_node('ma_pops_furniture:toilet_open', {
	description = 'Toilet',
	drawtype = 'mesh',
	mesh = 'FM_toilet_open.obj',
	tiles = {{name='default_clay.png'},{name='default_wood.png'}},
	groups = {choppy=2, oddly_breakably_by_hand=2, furniture=1, not_in_creative_inventory=1},
	--inventory_image = 'fm_chair_stone.png',
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = 'fixed',
		fixed = {
			{-.35, -.5, -.35, .35, 0, .5}, -- Right, Bottom, Back, Left, Top, Front
			{-.35, 0, .2, .35, .5, .5},
			}
		},
	collision_box = {
		fixed = {
			{-.35, -.5, -.35, .35, 0, .5}, -- Right, Bottom, Back, Left, Top, Front
			{-.35, 0, .2, .35, .5, .5},
			}
		},
	on_rightclick = function(pos, node, clicker)
		ma_pops_furniture.sit(pos, node, clicker)
		end,
	on_punch = function (pos, node, puncher)
		node.name = "ma_pops_furniture:toilet_close"
		minetest.set_node(pos, node)
	end,
})

minetest.register_node('ma_pops_furniture:toilet_close', {
	description = 'Toilet',
	drawtype = 'mesh',
	mesh = 'FM_toilet_close.obj',
	tiles = {{name='default_clay.png'},{name='default_wood.png'}},
	groups = {choppy=2, oddly_breakably_by_hand=2, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = 'fixed',
		fixed = {
			{-.35, -.5, -.35, .35, 0, .5}, -- Right, Bottom, Back, Left, Top, Front
			{-.35, 0, .2, .35, .5, .5},
			}
		},
	collision_box = {
		fixed = {
			{-.35, -.5, -.35, .35, 0, .5}, -- Right, Bottom, Back, Left, Top, Front
			{-.35, 0, .2, .35, .5, .5},
			}
		},
	on_rightclick = function(pos, node, clicker)
		ma_pops_furniture.sit(pos, node, clicker)
		end,
	on_punch = function (pos, node, puncher)
		node.name = "ma_pops_furniture:toilet_open"
		minetest.set_node(pos, node)
	end,
})

minetest.register_node("ma_pops_furniture:br_sink", {
   description = "Sink (Bathroom)",
   tiles = {
		"mp_hw_top.png",
		"mp_hw_bottom.png",
		"mp_hw_right.png",
		"mp_hw_left.png",
		"mp_hw_back.png",
		"mp_hw_front.png"
	},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
   node_box = {
       type = "fixed",
       fixed = {
         {-0.4375, 0.25, -0.3125, 0.4375, 0.5, 0.5},
		 {-0.125, -0.5, 0.125, 0.125, 0.25, 0.4375},
       },
   }
})

minetest.register_node("ma_pops_furniture:mirror_closed", {
   description = "Mirror",
   tiles = {
		"mp_mirror_top.png",
		"mp_mirror_bottom.png",
		"mp_mirror_right.png",
		"mp_mirror_left.png",
		"default_wood.png",
		"mp_mirror_front.png"
	},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
   on_punch = function(pos, node, puncher)
		minetest.env:add_node(pos, {name = "ma_pops_furniture:mirror", param2 = node.param2})
		ma_pops_furniture.window_operate( pos, "ma_pops_furniture:mirror_closed", "ma_pops_furniture:mirror" );
		end,
   node_box = {
       type = "fixed",
       fixed = {
			{-0.4375, -0.375, 0.3125, 0.4375, 0.5, 0.5},
			{0, -0.375, 0.25, 0.4375, 0.5, 0.3125},
			{-0.4375, -0.375, 0.25, 2.98023e-008, 0.5, 0.3125},
       },
   }
})

minetest.register_node("ma_pops_furniture:mirror", {
   description = "Mirror (Open)",
   tiles = {
		"mp_mirror_open_top.png",
		"mp_mirror_open_bottom.png",
		"mp_mirror_open_right.png",
		"mp_mirror_open_left.png",
		"mp_mirror_front.png",
		"mp_mirror_open_front.png"
	},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   drop = "ma_pops_furniture:mirror_closed",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1},
   on_punch = function(pos, node, puncher)
		minetest.env:add_node(pos, {name = "ma_pops_furniture:mirror_closed", param2 = node.param2})
		ma_pops_furniture.window_operate( pos, "ma_pops_furniture:mirror", "ma_pops_furniture:mirror_closed" );
		end,
		on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('storage', 4*4)
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
			{-0.4375, -0.375, 0.3125, 0.4375, 0.5, 0.5},
			{0.4375, -0.375, -0.125, 0.5, 0.5, 0.3125},
			{-0.5, -0.375, -0.125, -0.4375, 0.5, 0.3125},
       },
   }
})

minetest.register_node("ma_pops_furniture:shower_base", {
   description = "Shower Base",
   tiles = {
		"mp_showbas_top.png",
		"mp_showbas_top.png",
		"mp_showbas_sides.png",
		"mp_showbas_sides.png",
		"mp_showbas_sides.png",
		"mp_showbas_sides.png"
	},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
   node_box = {
       type = "fixed",
       fixed = {
          {-0.4375, -0.5, -0.4375, 0.4375, -0.4375, 0.4375}, 
		  {0.4375, -0.5, -0.5, 0.5, -0.3125, 0.5}, 
		  {-0.5, -0.5, 0.4375, 0.5, -0.3125, 0.5},
		  {-0.5, -0.5, -0.5, -0.4375, -0.3125, 0.5}, 
		  {-0.5, -0.5, -0.5, 0.5, -0.3125, -0.4375}, 
		  {-0.125, -0.5, 0.125, 0.125, -0.375, 0.375},
       }
    },
})

minetest.register_node("ma_pops_furniture:shower_top", {
   description = "Shower Head",
   tiles = {
		"mp_shk_top.png",
		"mp_shk_bottom.png",
		"mp_shk_right.png",
		"mp_shk_left.png",
		"mp_shk_back.png",
		"mp_shk_front.png"
	},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
   node_box = {
       type = "fixed",
       fixed = {
          {-0.25, -0.5, 0.4375, 0.25, 0.5, 0.5},
		  {-0.125, 0.3125, -0.1875, 0.125, 0.4375, 0.25},
		  {-0.1875, -0.25, 0.375, -0.125, -0.1875, 0.4375},
		  {0.125, -0.25, 0.375, 0.1875, -0.1875, 0.4375},
		  {-0.1875, -0.25, 0.3125, -0.125, -0.0625, 0.375}, 
		  {0.125, -0.25, 0.3125, 0.1875, -0.0625, 0.375}, 
		  {-0.0625, 0.375, 0.25, 0.0625, 0.4375, 0.4375}, 
        },
    }
})

--Bedroom--
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

--Kitchen/Dining Room--
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
	drawtype = 'mesh',
	mesh = 'FM_chair.obj',
	tiles = {'default_'..material..'.png'},
	groups = {choppy=2, oddly_breakably_by_hand=2, furniture=1, flammable=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_wood_defaults(),
	on_rightclick = function(pos, node, clicker)
		ma_pops_furniture.sit(pos, node, clicker)
		end,
	selection_box = {
		type = 'fixed',
		fixed = {
			{-.4, -.4, -.3, .4, 0, .5},
			{-.4, 0, .3, .4, .62, .4},
			}
		},
	collision_box = {
		type = 'fixed',
		fixed = {
			{-.4, -.4, -.3, .4, 0, .5},
			{-.4, 0, .3, .4, .62, .4},
			}
		},
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
	groups = {snappy = 2, oddly_breakable_by_hand = 2, furniture = 1, flammable = 1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.3125, 0.125}, -- NodeBox2
			{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5}, -- NodeBox3
		}
	}
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
	groups = {snappy = 2, oddly_breakable_by_hand = 2, furniture = 1, flammable = 1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.375, -0.5, -0.125, -0.125, 0.3125, 0.125}, -- NodeBox3
		}
	}
})
end

local table_c2_table = { --name, material, invimg
{'Stone Corner (right) Table', 'cobble', 'mp_table_stone.png'},
{'Wood Corner (right) Table', 'wood', 'mp_table_wood.png'},
{'Acacia Corner(right)  Wood Table', 'acacia_wood', 'mp_table_wood_acacia.png'},
{'Aspen Corner (right) Wood Table', 'aspen_wood', 'mp_table_wood_aspen.png'},
{'Pine Corner (right) Wood Table', 'pine_wood', 'mp_table_wood_pine.png'},
{'Jungle Corner (right) Wood Table', 'junglewood', 'mp_table_wood_jungle.png'}
}

for i in ipairs (table_c2_table) do
	local name = table_c2_table[i][1]
	local material = table_c2_table[i][2]
	local invimg = table_c2_table[i][3]
	
minetest.register_node('ma_pops_furniture:table_c2_'..material, {
	description = name,
	drawtype = 'nodebox',
	tiles = {'default_'..material..'.png'},
	groups = {snappy = 2, oddly_breakable_by_hand = 2, furniture = 1, flammable = 1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{0.125, -0.5, -0.125, 0.375, 0.3125, 0.125}, -- NodeBox3
		}
	}
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
	groups = {snappy = 2, oddly_breakable_by_hand = 2, furniture = 1, flammable = 1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5},
		}
	}
})
end

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

minetest.register_node("ma_pops_furniture:sink", {
	description = "Counter (Sink)",
	tiles = {
		"mp_sink_top.png",
		"mp_enc_bottom.png",
		"mp_enc_right.png",
		"mp_enc_left.png",
		"mp_enc_back.png",
		"mp_enc_front.png"
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
			{-0.5, -0.5, -0.375, 0.5, -0.4375, 0.5}, -- NodeBox1
			{-0.5, -0.4375, -0.4375, 0.5, 0.375, 0.5}, -- NodeBox2
			{0.0625, -0.375, -0.5, 0.4375, 0.3125, -0.4375}, -- NodeBox3
			{-0.4375, -0.375, -0.5, -0.0625, 0.3125, -0.4375}, -- NodeBox4
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox5
		}
	}
})

minetest.register_node("ma_pops_furniture:kitchen_faucet", {
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

minetest.register_node("ma_pops_furniture:counter", {
	description = "Counter",
	tiles = {
		"mp_enc_top.png",
		"mp_enc_bottom.png",
		"mp_enc_right.png",
		"mp_enc_left.png",
		"mp_enc_back.png",
		"mp_enc_front.png"
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
			{-0.5, -0.5, -0.375, 0.5, -0.4375, 0.5}, -- NodeBox1
			{-0.5, -0.4375, -0.4375, 0.5, 0.375, 0.5}, -- NodeBox2
			{0.0625, -0.375, -0.5, 0.4375, 0.3125, -0.4375}, -- NodeBox3
			{-0.4375, -0.375, -0.5, -0.0625, 0.3125, -0.4375}, -- NodeBox4
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox5
		}
	}
})

minetest.register_node("ma_pops_furniture:counterl", {
	description = "Counter (Corner)",
	tiles = {
		"mp_corn_r_top.png",
		"mp_corn_r_bottom.png",
		"mp_corn_r_right.png",
		"mp_corn_r_left.png",
		"mp_corn_r_back.png",
		"mp_corn_r_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
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
			{0.5, 0.5, 0.5, -0.5, -0.5, -0.5}, -- NodeBox1
		}
	}
})

minetest.register_node("ma_pops_furniture:upcabinet", {
description = "Upper Cabinets",
	tiles = {
		"mp_up_top.png",
		"mp_up_bottom.png",
		"mp_up_right.png",
		"mp_up_left.png",
		"default_wood.png",
		"mp_up_front.png"
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
			{-0.5, -0.3125, -0.375, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.4375, -0.25, -0.4375, -0.0625, 0.4375, -0.375}, -- NodeBox2
			{0.0625, -0.25, -0.4375, 0.4375, 0.4375, -0.375}, -- NodeBox3
			{-0.1875, -0.1875, -0.5, -0.125, 0, -0.4375}, -- NodeBox4
			{0.125, -0.1875, -0.5, 0.1875, 0, -0.4375}, -- NodeBox5
		}
	}
})

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

minetest.register_node("ma_pops_furniture:fridge", {
	description= "Fridge",
	tiles = {
		"mp_fridge_top.png",
		"mp_fridge_bottom.png",
		"mp_fridge_right.png",
		"mp_fridge_left.png",
		"mp_fridge_back.png",
		"mp_fridge_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, furniture = 1},
		on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('storage', 6*4)
		meta:set_string('formspec',
			'size [9,10]'..
			default.gui_bg..
			default.gui_bg_img..
			default.gui_slots..
			'bgcolor[#080808BB;true]'..
			'list[current_name;storage;1.5,1;6,4;]'..
			'list[current_player;main;0.5,6;8,4;]')
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('storage') and inv:is_empty('storage1')
	end,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.3125, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.5, -0.4375, -0.375, 0.4375, 0.5, -0.3125}, -- NodeBox2
			{0.3125, -0.25, -0.5, 0.375, 0.25, -0.4375}, -- NodeBox6
			{0.3125, -0.25, -0.4375, 0.375, -0.1875, -0.375}, -- NodeBox7
			{0.3125, 0.1875, -0.4375, 0.375, 0.25, -0.375}, -- NodeBox8
		}
	}
})

--Living Room--
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
    on_rightclick = function(pos, node, clicker)
        ma_pops_furniture.sit(pos, node, clicker)
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
    }
})
end

local rbt = {name="mp_wool_coloured_rainbow.png", animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=7.0}}

local rbt_cb = {name="mp_wool_coloured_rainbow.png^mp_r_cb.png", animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=7.0}}

local rbt_cf = {name="mp_wool_coloured_rainbow.png^mp_r_cf.png", animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=7.0}}

minetest.register_node("ma_pops_furniture:chair2_rainbow", {
    description = "Rainbow Chair",
    tiles = {rbt, rbt_cb, rbt_cf, rbt_cf, rbt_cf, rbt_cf},
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, furniture = 1, fall_damage_add_percent=-80, bouncy=80},
	sounds = {wood = {name="furn_bouncy", gain=0.8}},
    on_rightclick = function(pos, node, clicker)
        ma_pops_furniture.sit(pos, node, clicker)
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
    }
})

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
    }
})
end

local rbt = {name="mp_wool_coloured_rainbow.png", animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=7.0}}

local rbt_cb = {name="mp_wool_coloured_rainbow.png^mp_r_cb.png", animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=7.0}}

local rbt_cf = {name="mp_wool_coloured_rainbow.png^mp_r_cf.png", animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=7.0}}

minetest.register_node('ma_pops_furniture:fs_rainbow', {
    description = "Rainbow Footstool",
    tiles = {rbt, rbt_cb, rbt_cf, rbt_cf, rbt_cf, rbt_cf},
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
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
    }
})

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

minetest.register_node("ma_pops_furniture:entertainment_unit_"..material, {
	description= name,
	tiles= {'default_'..material..'.png'},
	drawtype= "nodebox",
	paramtype= "light",
	paramtype2 = "facedir",
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

minetest.register_node('ma_pops_furniture:fireplace', {
	description = 'Fireplace',
	drawtype = 'mesh',
	mesh = 'FM_fireplace_off.obj',
	tiles = {{name='default_brick.png'},{name='xpanes_bar.png'}},
	groups = {cracky=2, oddly_breakable_by_hand=6, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_stone_defaults(),
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
	sounds = default.node_sound_stone_defaults(),
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('fuel')
	end,
})

minetest.register_node("ma_pops_furniture:lamp", {
	description= "Lamp",
	tiles= {"mp_lt.png","mp_lb.png","mp_ls.png","mp_ls.png","mp_ls.png","mp_ls.png",},
	drawtype= "nodebox",
	light_source =  14,
	paramtype = "facedir",
	drop= 'ma_pops_furniture:lamp_off',
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
		node.name = "ma_pops_furniture:lamp_off"
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
	}
})

minetest.register_node("ma_pops_furniture:lamp_off", {
	description= "Lamp",
	tiles= {"mp_lt.png","mp_lb.png","mp_ls.png","mp_ls.png","mp_ls.png","mp_ls.png",},
	drawtype= "nodebox",
	paramtype = "facedir",
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
		node.name = "ma_pops_furniture:lamp"
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
	}
})

minetest.register_node("ma_pops_furniture:curtains", {
	description= "Curtains",
	tiles= {"default_acacia_tree.png","mp_curtainb.png","wool_red.png^mp_curtains.png","wool_red.png^mp_curtains.png","wool_red.png^mp_curtains.png","wool_red.png^mp_curtains.png",},
	drawtype= "nodebox",
	paramtype= "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, furniture = 1},
	on_rightclick = function(pos, node, puncher)
		minetest.env:add_node(pos, {name = "ma_pops_furniture:curtains_closed", param2 = node.param2})
		ma_pops_furniture.window_operate( pos, "ma_pops_furniture:curtains", "ma_pops_furniture:curtains_closed" );
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
	}
})

minetest.register_node("ma_pops_furniture:curtains_closed", {
   description = "curtains closed",
   tiles= {"default_acacia_tree.png","mp_curtainb.png","wool_red.png^mp_curtains.png","wool_red.png^mp_curtains.png","wool_red.png^mp_curtains.png","wool_red.png^mp_curtains.png",},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1, furniture = 1},
   on_rightclick = function(pos, node, puncher)
		minetest.env:add_node(pos, {name = "ma_pops_furniture:curtains", param2 = node.param2})
		ma_pops_furniture.window_operate( pos, "ma_pops_furniture:curtains_closed", "ma_pops_furniture:curtains" );
		end,
   node_box = {
       type = "fixed",
       fixed = {
           {-0.5, -0.5, 0.5, 0.5, 0.5, 0.4},
		   {-0.5, 0.5, 0.5, 0.5, 0.440, 0.350},

       },
   }
})

minetest.register_node("ma_pops_furniture:curtains_2_tall", {
description= "Curtains 2 tall",
tiles = {"wool_red.png"},
drawtype= "nodebox",
paramtype= "light",
paramtype2 = "facedir",
groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, furniture = 1},
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
node.name = "ma_pops_furniture:curtains_2_tall_closed" minetest.set_node(pos, node)
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
}
})

minetest.register_node("ma_pops_furniture:curtains_2_tall_closed", {
description= "Curtains 2 tall closed",
tiles = {"wool_red.png"},
drawtype= "nodebox",
paramtype= "light",
paramtype2 = "facedir",
groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1},
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
node.name = "ma_pops_furniture:curtains_2_tall" minetest.set_node(pos, node)
end,
node_box= {
type= "fixed",
fixed= {
       {0.5, 0.5, 0.5, -0.5, -1.5, 0.4},
},
}
})

minetest.register_node("ma_pops_furniture:blinds", {
   description = "Blinds",
   tiles = {"mp_blinds.png"},
   drawtype = "nodebox",
   paramtype = "light",
   paramtype2 = "facedir",
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, furniture = 1},
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

local songs = { "static"
}

minetest.register_node("ma_pops_furniture:stereo", {
	description = "Stereo",
	tiles = {
		"mp_radio_top.png",
		"mp_radio_bottom.png",
		"mp_radio_right.png",
		"mp_radio_left.png",
		"mp_radio_back.png",
		"mp_radio_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.1875, 0.5, -0.125, 0.5}, -- NodeBox1
			{-0.25, -0.5, 0.125, 0.25, -0.0625, 0.5}, -- NodeBox2
		}
	},
	on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then
        minetest.sound_stop(meta:get_string("hwnd"))
        meta:set_string("hwnd",nil)
    else
        meta:set_string("hwnd",minetest.sound_play("radio_" .. songs[math.random(1,#songs)], {gain = 0.5, max_hear_distance = 25}))
    end
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
    end,
})

minetest.register_node('ma_pops_furniture:tv_rainbow', {
	description = 'TV',
	drawtype = 'mesh',
	mesh = 'FM_tv.obj',
	drop = 'ma_pops_furniture:tv_off',
	tiles = {{name='default_tree.png'},{name='mp_channel_rainbow.png', animation={type='vertical_frames', aspect_w=64, aspect_h=48, length=3}}},
	groups = {cracky=2, oddly_breakable_by_hand=3, not_in_creative_inventory=1, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	light_source = 14,
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},  -- Right, Bottom, Back, Left, Top, Front
		},
	collision_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},
		},
	 on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
	node.name = "ma_pops_furniture:tv_blast"
		minetest.set_node(pos, node)
    if string.len(meta:get_string("hwnd")) > 0 then
        minetest.sound_stop(meta:get_string("hwnd"))
        meta:set_string("hwnd",nil)
    else
        meta:set_string("hwnd",minetest.sound_play("mp_blast", {gain = 0.5, max_hear_distance = 25}))
    end
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
    end,
})

minetest.register_node('ma_pops_furniture:tv_blast', {
	description = 'TV',
	drawtype = 'mesh',
	mesh = 'FM_tv.obj',
	drop = 'ma_pops_furniture:tv_off',
	tiles = {{name='default_tree.png'},{name='mp_channel_blast.png', animation={type='vertical_frames', aspect_w=64, aspect_h=64, length=22}}},
	groups = {cracky=2, oddly_breakable_by_hand=3, not_in_creative_inventory=1, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	light_source = 14,
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},  -- Right, Bottom, Back, Left, Top, Front
		},
	collision_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},
		},
	 on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
	node.name = "ma_pops_furniture:tv_static"
		minetest.set_node(pos, node)
    if string.len(meta:get_string("hwnd")) > 0 then
        minetest.sound_stop(meta:get_string("hwnd"))
        meta:set_string("hwnd",nil)
    else
        meta:set_string("hwnd",minetest.sound_play("mp_static", {gain = 0.5, max_hear_distance = 25}))
    end
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
    end,
})

minetest.register_node('ma_pops_furniture:tv_static', {
	description = 'TV',
	drawtype = 'mesh',
	mesh = 'FM_tv.obj',
	drop = 'ma_pops_furniture:tv_off',
	tiles = {{name='default_tree.png'},{name='mp_channel_static.png', animation={type='vertical_frames', aspect_w=40, aspect_h=30, length=1}}},
	groups = {cracky=2, oddly_breakable_by_hand=3, not_in_creative_inventory=1, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	light_source = 14,
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},  -- Right, Bottom, Back, Left, Top, Front
		},
	collision_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},
		},
	 on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
	node.name = "ma_pops_furniture:tv_cube"
		minetest.set_node(pos, node)
    if string.len(meta:get_string("hwnd")) > 0 then
        minetest.sound_stop(meta:get_string("hwnd"))
        meta:set_string("hwnd",nil)
    else
        meta:set_string("hwnd",minetest.sound_play("mp_glass", {gain = 0.5, max_hear_distance = 25}))
    end
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
    end,
})

minetest.register_node('ma_pops_furniture:tv_cube', {
	description = 'TV',
	drawtype = 'mesh',
	mesh = 'FM_tv.obj',
	drop = 'ma_pops_furniture:tv_off',
	tiles = {{name='default_tree.png'},{name='mp_channel_cube.png', animation={type='vertical_frames', aspect_w=40, aspect_h=40, length=2}}},
	groups = {cracky=2, oddly_breakable_by_hand=3, not_in_creative_inventory=1, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	light_source = 14,
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},  -- Right, Bottom, Back, Left, Top, Front
		},
	collision_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},
		},
	  on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
	node.name = "ma_pops_furniture:tv_off"
		minetest.set_node(pos, node)
    if string.len(meta:get_string("hwnd")) > 0 then
        minetest.sound_stop(meta:get_string("hwnd"))
        meta:set_string("hwnd",nil)
    end
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
    end,
})

minetest.register_node('ma_pops_furniture:tv_off', {
	description = 'TV',
	drawtype = 'mesh',
	mesh = 'FM_tv.obj',
	tiles = {{name='default_tree.png'},{name='wool_black.png^default_glass_detail.png^[colorize:black:225',}},
	groups = {cracky=2, oddly_breakable_by_hand=3, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	light_source = 1,
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},  -- Right, Bottom, Back, Left, Top, Front
		},
	collision_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},
		},
	on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
	node.name = "ma_pops_furniture:tv_rainbow"
		minetest.set_node(pos, node)
    if string.len(meta:get_string("hwnd")) > 0 then
        minetest.sound_stop(meta:get_string("hwnd"))
        meta:set_string("hwnd",nil)
    else
        meta:set_string("hwnd",minetest.sound_play("mp_rainbow", {gain = 0.5, max_hear_distance = 25}))
    end
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
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
	sounds = default.node_sound_wood_defaults(),
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

--Office--
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
	sounds = default.node_sound_wood_defaults(),
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

--Outside--
local hedge_table = { --name, material, invimg
{'Hedge', 'leaves'},
{'Pine Hedge', 'pine_needles'},
{'Jungle Hedge', 'jungleleaves'},
{'Acacia Hedge', 'acacia_leaves'},
{'Aspen Hedge', 'aspen_leaves'}
}

for i in ipairs (hedge_table) do
	local name = hedge_table[i][1]
	local material = hedge_table[i][2]
	local invimg = hedge_table[i][3]

minetest.register_node('ma_pops_furniture:hedge_'..material, {
	description = name,
	drawtype = 'nodebox',
	tiles = {'default_'..material..'.png'},
	groups = {snappy=2, oddly_breakable_by_hand=2, furniture=1, flammable=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.1875, 0.5, 0.1875, 0.1875},
		}
	}
})

minetest.register_node('ma_pops_furniture:hedge_c_'..material, {
	description = name,
	drawtype = 'nodebox',
	tiles = {'default_'..material..'.png'},
	groups = {snappy=2, oddly_breakable_by_hand=2, not_in_creative_inventory=1, flammable=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_leaves_defaults(),
	drop = 'ma_pops_furniture:hedge_'..material,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.5, 0.1875, 0.1875}, 
			{-0.1875, -0.5, 0.1875, 0.1875, 0.1875, 0.5}, 
		}
	}
})

minetest.register_node('ma_pops_furniture:hedge_t_'..material, {
	description = name,
	drawtype = 'nodebox',
	tiles = {'default_'..material..'.png'},
	groups = {snappy=2, oddly_breakable_by_hand=2, not_in_creative_inventory=1, flammable=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_leaves_defaults(),
	drop = 'ma_pops_furniture:hedge_'..material,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.1875, 0.5, 0.1875, 0.1875}, 
			{-0.1875, -0.5, 0.1875, 0.1875, 0.1875, 0.5}, 
		}
	}
})
end

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

minetest.register_node("ma_pops_furniture:grill", {
   description = "Grill",
   tiles = {
		"default_coal_block.png^mp_grillt.png",
		"default_stone.png",
		"default_stone.png^mp_grills.png",
		"default_stone.png^mp_grills.png",
		"default_stone.png^mp_grills.png",
		"default_stone.png^mp_grills.png"
},
   drawtype = "nodebox",
   paramtype = "light",
   on_rightclick = function (pos, node, player, itemstack, pointed_thing)
node.name = "ma_pops_furniture:grill_on"
minetest.set_node(pos, node)
end,
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
   node_box = {
       type = "fixed",
       fixed = {
           {-0.450, -0.5, -0.450, -0.350, -0.3, -0.350},
           {0.450, -0.5, -0.450, 0.350, -0.3, -0.350},
           {-0.450, -0.5, 0.450, -0.350, -0.3, 0.350},
           {0.450, -0.5, 0.450, 0.350, -0.3, 0.350},
  
           {-0.4, -0.3, -0.4, -0.3, 0.0, -0.3},
           {0.4, -0.3, -0.4, 0.3, 0.0, -0.3},
           {-0.4, -0.3, 0.4, -0.3, 0.0, 0.3},
           {0.4, -0.3, 0.4, 0.3, 0.0, 0.3},

           {-0.4, -0.0, -0.4, 0.4, 0.2, 0.4},
           {-0.5, 0.190, -0.5, 0.5, 0.4, 0.5},

          {-0.4375, 0.4, 0.5, -0.5, 0.5, -0.5},
          {0.4375, 0.4, 0.5, 0.5, 0.5, -0.5},
          {-0.5, 0.4, 0.4375, 0.5, 0.5, 0.5},
          {-0.5, 0.4, -0.4375, 0.5, 0.5, -0.5},
       },  
   }
})

minetest.register_node("ma_pops_furniture:grill_on", {
   description = "grill on",
   tiles = {
		"default_coal_block.png^mp_grillton.png",
		"default_stone.png",
		"default_stone.png^mp_grills.png",
		"default_stone.png^mp_grills.png",
		"default_stone.png^mp_grills.png",
		"default_stone.png^mp_grills.png"
},
   drawtype = "nodebox",
   paramtype = "light",
   light_source = 14,
   on_rightclick = function (pos, node, player, itemstack, pointed_thing)
node.name = "ma_pops_furniture:grill"
minetest.set_node(pos, node)
end,
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1},
   node_box = {
       type = "fixed",
       fixed = {
           {-0.450, -0.5, -0.450, -0.350, -0.3, -0.350},
           {0.450, -0.5, -0.450, 0.350, -0.3, -0.350},
           {-0.450, -0.5, 0.450, -0.350, -0.3, 0.350},
           {0.450, -0.5, 0.450, 0.350, -0.3, 0.350},
  
           {-0.4, -0.3, -0.4, -0.3, 0.0, -0.3},
           {0.4, -0.3, -0.4, 0.3, 0.0, -0.3},
           {-0.4, -0.3, 0.4, -0.3, 0.0, 0.3},
           {0.4, -0.3, 0.4, 0.3, 0.0, 0.3},

           {-0.4, -0.0, -0.4, 0.4, 0.2, 0.4},
           {-0.5, 0.190, -0.5, 0.5, 0.4, 0.5},

          {-0.4375, 0.4, 0.5, -0.5, 0.5, -0.5},
          {0.4375, 0.4, 0.5, 0.5, 0.5, -0.5},
          {-0.5, 0.4, 0.4375, 0.5, 0.5, 0.5},
          {-0.5, 0.4, -0.4375, 0.5, 0.5, -0.5},
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
