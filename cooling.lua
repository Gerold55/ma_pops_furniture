minetest.register_node("ma_pops_furniture:fan_on", {
   description = "fan (on)",
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
   description = "fan",
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
   light_source = 14,
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