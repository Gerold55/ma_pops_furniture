minetest.register_node("ma_pops_furniture:grill2", {
   description = "Grill",
   tiles = {
		"default_stone.png^mp_grillt.png",
		"default_stone.png",
		"default_stone.png^mp_grill_s.png",
		"default_stone.png^mp_grill_s.png",
		"default_stone.png^mp_grill_s.png",
		"default_stone.png^mp_grill_s.png",
},
   drawtype = "nodebox",
   drop = 'ma_pops_furniture:grill2',
   paramtype = "light",
   on_rightclick = function (pos, node, player, itemstack, pointed_thing)
if minetest.get_node(vector.add(pos, vector.new(0, 1, 0))).name == "ma_pops_furniture:grill2_top_off" then 
 minetest.set_node({x = pos.x, y = pos.y, z = pos.z}, {name = "ma_pops_furniture:grill2_on"}) 
 end
if minetest.get_node(vector.add(pos, vector.new(0, 1, 0))).name == "ma_pops_furniture:grill_top" then 
 minetest.set_node({x = pos.x, y = pos.y, z = pos.z}, {name = "ma_pops_furniture:grill2_on_nolight"}) 
 end
end,
on_dig = function(pos, node, player)
minetest.set_node({x = pos.x , y = pos.y + 1, z = pos.z}, {name = "air"}) 
minetest.set_node({x = pos.x, y = pos.y, z = pos.z}, {name = "air"}) 
end,
   groups = {choppy = 2, oddly_breakable_by_hand = 2},
   on_construct = function(pos)
    if minetest.get_node(vector.add(pos, vector.new(0, 1, 0))).name ~= "air" then 
return false end minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z}, {name = "ma_pops_furniture:grill2_top"}) 
	if minetest.get_node(vector.add(pos, vector.new(0, 1, 0))).name ~= "air" then 
	if minetest.get_node(vector.add(pos, vector.new(0, 1, 0))).name ~= "ma_pops_furniture:grill2_top" then 
 minetest.set_node({x = pos.x, y = pos.y, z = pos.z}, {name = "air"}) 
 end
 end
 end,
   node_box = {
       type = "fixed",
       fixed = {
          --body
          {0.5, 0.4, 0.5, -0.5, -0.0, -0.5},
          {0.5, 0.3, -0.45, -0.5, 0.5, -0.5},
          {0.5, 0.3, 0.45, -0.5, 0.5, 0.5},
          {-0.5, 0.3, 0.5, -0.45, 0.5, -0.5},
          {0.5, 0.3, 0.5, 0.45, 0.5, -0.5},
          --leg1
           {0.45, 0.0, 0.45, 0.35, -0.35, 0.35},
            {0.5, -0.35, 0.5, 0.4, -0.5, 0.4},
            --leg2
           {0.45, 0.0, -0.45, 0.35, -0.35, -0.35},
            {0.5, -0.35, -0.5, 0.4, -0.5, -0.4},
            --leg3
            {-0.45, 0.0, -0.45, -0.35, -0.35, -0.35},
             {-0.5, -0.35, -0.5, -0.4, -0.5, -0.4},
            --leg4
             {-0.45, 0.0, 0.45, -0.35, -0.35, 0.35},
            {-0.5, -0.35, 0.5, -0.4, -0.5, 0.4},
       },  
   }
})

minetest.register_node("ma_pops_furniture:grill2_on", {
   description = "grill",
   tiles = {
		"default_stone.png^mp_grillton.png",
		"default_stone.png",
		"default_stone.png^mp_grill_s.png",
		"default_stone.png^mp_grill_s.png",
		"default_stone.png^mp_grill_s.png",
		"default_stone.png^mp_grill_s.png",
},
   drawtype = "nodebox",
   drop = 'ma_pops_furniture:grill2',
   paramtype = "light",
   light_source = 10,
   paramtype2 = "facedir",
   on_rightclick = function (pos, node, player, itemstack, pointed_thing)
node.name = "ma_pops_furniture:grill2"
minetest.set_node(pos, node)
end,
on_dig = function(pos, node, player)
minetest.set_node({x = pos.x , y = pos.y + 1, z = pos.z}, {name = "air"}) 
minetest.set_node({x = pos.x, y = pos.y, z = pos.z}, {name = "air"}) 
end,
   groups = {choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
   node_box = {
       type = "fixed",
       fixed = {
          --body
          {0.5, 0.4, 0.5, -0.5, -0.0, -0.5},
          {0.5, 0.3, -0.45, -0.5, 0.5, -0.5},
          {0.5, 0.3, 0.45, -0.5, 0.5, 0.5},
          {-0.5, 0.3, 0.5, -0.45, 0.5, -0.5},
          {0.5, 0.3, 0.5, 0.45, 0.5, -0.5},
          --leg1
           {0.45, 0.0, 0.45, 0.35, -0.35, 0.35},
            {0.5, -0.35, 0.5, 0.4, -0.5, 0.4},
            --leg2
           {0.45, 0.0, -0.45, 0.35, -0.35, -0.35},
            {0.5, -0.35, -0.5, 0.4, -0.5, -0.4},
            --leg3
            {-0.45, 0.0, -0.45, -0.35, -0.35, -0.35},
             {-0.5, -0.35, -0.5, -0.4, -0.5, -0.4},
            --leg4
             {-0.45, 0.0, 0.45, -0.35, -0.35, 0.35},
            {-0.5, -0.35, 0.5, -0.4, -0.5, 0.4},
       },  
   }
})

minetest.register_node("ma_pops_furniture:grill2_on_nolight", {
   description = "grill",
   tiles = {
		"default_stone.png^mp_grillton.png",
		"default_stone.png",
		"default_stone.png^mp_grillton.png",
		"default_stone.png^mp_grillton.png",
		"default_stone.png^mp_grillton.png",
},
   drawtype = "nodebox",
   drop = 'ma_pops_furniture:grill2',
   paramtype = "light",
   paramtype2 = "facedir",
   on_rightclick = function (pos, node, player, itemstack, pointed_thing)
node.name = "ma_pops_furniture:grill2"
minetest.set_node(pos, node)
end,
on_dig = function(pos, node, player)
minetest.set_node({x = pos.x , y = pos.y + 1, z = pos.z}, {name = "air"}) 
minetest.set_node({x = pos.x, y = pos.y, z = pos.z}, {name = "air"}) 
end,
   groups = {choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
   node_box = {
       type = "fixed",
       fixed = {
          --body
          {0.5, 0.4, 0.5, -0.5, -0.0, -0.5},
          {0.5, 0.3, -0.45, -0.5, 0.5, -0.5},
          {0.5, 0.3, 0.45, -0.5, 0.5, 0.5},
          {-0.5, 0.3, 0.5, -0.45, 0.5, -0.5},
          {0.5, 0.3, 0.5, 0.45, 0.5, -0.5},
          --leg1
           {0.45, 0.0, 0.45, 0.35, -0.35, 0.35},
            {0.5, -0.35, 0.5, 0.4, -0.5, 0.4},
            --leg2
           {0.45, 0.0, -0.45, 0.35, -0.35, -0.35},
            {0.5, -0.35, -0.5, 0.4, -0.5, -0.4},
            --leg3
            {-0.45, 0.0, -0.45, -0.35, -0.35, -0.35},
             {-0.5, -0.35, -0.5, -0.4, -0.5, -0.4},
            --leg4
             {-0.45, 0.0, 0.45, -0.35, -0.35, 0.35},
            {-0.5, -0.35, 0.5, -0.4, -0.5, 0.4},
       },  
   }
})

minetest.register_node("ma_pops_furniture:grill2_top", {
   description = "grill top",
   tiles = {
		"mp_grill_t2.png",
		"mp_grill_t2.png",
		"mp_grill_t2.png",
		"mp_grill_t2.png",
		"mp_grill_t2.png",
		"mp_grill_t2.png",
},
   drawtype = "nodebox",
   drop = 'ma_pops_furniture:grill2_top_off',
   paramtype = "light",
   paramtype2 = "facedir",
   on_rightclick = function (pos, node, player, itemstack, pointed_thing)
   if minetest.get_node(vector.add(pos, vector.new(0, - 1, 0))).name == "ma_pops_furniture:grill2_on_nolight" then 
 minetest.set_node({x = pos.x, y = pos.y - 1,z = pos.z}, {name = "ma_pops_furniture:grill2_on"}) 
 end
node.name = "ma_pops_furniture:grill2_top_off"
minetest.set_node(pos, node)
end,
   groups = {not_in_creative_inventory = 1},
   node_box = {
       type = "fixed",
       fixed = {
          --body
          {0.5, -0.5, 0.5, -0.5, -0.4, -0.5},
          {0.4, -0.4, 0.4, -0.4, -0.3, -0.4},
       },  
   }
})

minetest.register_node("ma_pops_furniture:grill2_top_off", {
   description = "grill top",
   tiles = {
		"mp_grill_t3.png",
		"mp_grill_t3.png",
		"mp_grill_t3.png",
		"mp_grill_t3.png",
		"mp_grill_t3.png",
		"mp_grill_t3.png",
},
   drawtype = "nodebox",
   drop = 'ma_pops_furniture:grill2_top_off',
   paramtype = "light",
   paramtype2 = "facedir",
   on_rightclick = function (pos, node, player, itemstack, pointed_thing)
   if minetest.get_node(vector.add(pos, vector.new(0, - 1, 0))).name == "ma_pops_furniture:grill2_on" then 
 minetest.set_node({x = pos.x, y = pos.y - 1,z = pos.z}, {name = "ma_pops_furniture:grill2_on_nolight"}) 
 end
node.name = "ma_pops_furniture:grill2_top"
minetest.set_node(pos, node)
end,
   groups = {not_in_creative_inventory = 1},
   node_box = {
       type = "fixed",
       fixed = {
          --body
          {0.5, -0.5, 0.5, -0.5, -0.4, -0.5},
          {0.4, -0.4, 0.4, -0.4, -0.3, -0.4},
       },  
   }
})
