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
	tiles = {{name='default_coral_skeleton.png'},{name='default_wood.png'}},
	groups = {choppy=2, oddly_breakably_by_hand=2, furniture=1, not_in_creative_inventory=1},
	--inventory_image = 'fm_chair_stone.png',
	paramtype = 'light',
	paramtype2 = 'facedir',
	drop = 'ma_pops_furniture:toilet_close',
	sounds = moditems.WOOD_SOUNDS,
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
	tiles = {{name='default_coral_skeleton.png'},{name='default_wood.png'}},
	groups = {choppy=2, oddly_breakably_by_hand=2, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = moditems.WOOD_SOUNDS,
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

minetest.register_node('ma_pops_furniture:br_tile', {
	description = 'Bathroom Tile',
	drawtype = 'nodebox',
	tiles = {
		"mp_bathroom_tile.png"
	},
	groups = {cracky=2, oddly_breakable_by_hand=5, furniture=1},
	paramtype = 'light',
	sounds = moditems.WOOD_SOUNDS,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	}
})