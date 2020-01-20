local minetest = minetest

local grill_nodebox = {
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
  }
}

local top_closed_nodebox = {
  type = "fixed",
  fixed = {
    {-0.4375, -0.375, -0.4375, 0.4375, -0.3125, 0.4375},
    {-0.5, -0.5, -0.4375, -0.4375, -0.375, 0.5},
    {0.4375, -0.5, -0.5, 0.5, -0.375, 0.4375},
    {-0.5, -0.5, -0.5, 0.4375, -0.375, -0.4375},
    {-0.4375, -0.5, 0.4375, 0.5, -0.375, 0.5},
  }
}

local top_open_nodebox = {
  type = "fixed",
  fixed = {
    {-0.5, -0.4375, 0.3125, -0.4375, 0.5, 0.4375},
    {0.4375, -0.5, 0.3125, 0.5, 0.4375, 0.4375},
    {-0.4375, 0.4375, 0.3125, 0.5, 0.5, 0.4375},
    {-0.5, -0.5, 0.3125, 0.4375, -0.4375, 0.4375},
    {-0.4375, -0.4375, 0.4375, 0.4375, 0.4375, 0.5},
  }
}


local grill_texture = 'default_stone.png'
local grill_name = 'ma_pops_furniture:grill'
local grill_on_name = 'ma_pops_furniture:grill_on'
local grill2_off_name = 'ma_pops_furniture:grill2'
local grill2_on_name = 'ma_pops_furniture:grill2_on'
local grill2_on_no_light_name = 'ma_pops_furniture:grill2_on_nolight'
local grill_top_name = 'ma_pops_furniture:grill2_top'
local grill_top_open_name = 'ma_pops_furniture:grill2_top_open'

local function above(pos)
    return {x=pos.x, y=pos.y+1, z=pos.z}
end

local function below(pos)
    return {x=pos.x, y=pos.y-1, z=pos.z}
end

local function after_dig(pos, oldnode, oldmetadata, digger)
  local node_above = minetest.get_node(above(pos))
  
  if node_above.name == grill_top_open_name or
    node_above.name == grill_top_name then 
    minetest.dig_node(above(pos)) 
  end
end


minetest.register_node(grill_name, {
   description = "Grill",
   tiles = {
		"default_coal_block.png^mp_grillt.png",
		grill_texture,
		grill_texture .. "^mp_grills.png",
		grill_texture .. "^mp_grills.png",
		grill_texture .. "^mp_grills.png",
		grill_texture .. "^mp_grills.png"
},
   drawtype = "nodebox",
   drop = grill_name,
   paramtype = "light",
   sounds = moditems.WOOD_SOUNDS,
   on_rightclick = function (pos, node, player, itemstack, pointed_thing)
      minetest.swap_node(pos, {name = grill_on_name})
   end,
   groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
   node_box = grill_nodebox
})

minetest.register_node("ma_pops_furniture:grill_on", {
  description = "Grill (on)",
  tiles = {
    "default_coal_block.png^mp_grillton.png",
    grill_texture,
    grill_texture .. "^mp_grills.png",
    grill_texture .. "^mp_grills.png",
    grill_texture .. "^mp_grills.png",
    grill_texture .. "^mp_grills.png"
  },
  drawtype = "nodebox",
  drop = grill_name,
  paramtype = "light",
  light_source = 10,
  sounds = moditems.WOOD_SOUNDS,
  on_rightclick = function (pos, node, player, itemstack, pointed_thing)
    minetest.swap_node(pos, {name = grill_name})
  end,
  groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1},
  node_box = grill_nodebox
})

minetest.register_node(grill2_off_name, {
	description = "Lidded Grill",
	tiles = {
		grill_texture .. "^mp_grillt.png",
		grill_texture,
		grill_texture .. "^mp_grills.png",
		grill_texture .. "^mp_grills.png",
		grill_texture .. "^mp_grills.png",
		grill_texture .. "^mp_grills.png",
	},
	drawtype = "nodebox",
	drop = grill2_off_name,
	paramtype = "light",
	sounds = moditems.WOOD_SOUNDS,
  
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
    local node_above = minetest.get_node(above(pos))
    
		if node_above.name == grill_top_open_name then 
			minetest.swap_node(pos, {name = grill2_on_name}) 
		end
    
		if node_above.name == grill_top_name then 
			minetest.swap_node(pos, {name = grill2_on_no_light_name}) 
		end
	end,
  
	after_dig_node = after_dig,
  
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	on_construct = function(pos)
		local pos_above = above(pos)
		local node_above = minetest.get_node(pos_above)
		
    minetest.place_node(pos_above, {name = grill_top_name}) 
		if node_above.name == "air" then 
		  --
		end
	end,
	node_box = grill_nodebox
})

minetest.register_node(grill2_on_name, {
	description = "Lidded Grill (on)",
	tiles = {
		grill_texture .. "^mp_grillton.png",
		grill_texture,
		grill_texture .. "^mp_grills.png",
		grill_texture .. "^mp_grills.png",
		grill_texture .. "^mp_grills.png",
		grill_texture .. "^mp_grills.png",
	},
	drawtype = "nodebox",
	drop = grill2_off_name,
	paramtype = "light",
	light_source = 10,
	paramtype2 = "facedir",
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
		minetest.swap_node(pos, {name = grill2_off_name})
	end,
	after_dig_node = after_dig,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1},
	node_box = grill_nodebox
})

minetest.register_node(grill2_on_no_light_name, {
	description = "Lidded Grill (on)",
	tiles = {
		grill_texture .. "^mp_grillton.png",
		grill_texture,
		grill_texture .. "^mp_grills.png",
		grill_texture .. "^mp_grills.png",
		grill_texture .. "^mp_grills.png",
		grill_texture .. "^mp_grills.png",
	},
	drawtype = "nodebox",
	drop = grill2_off_name,
	paramtype = "light",
	paramtype2 = "facedir",
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
		minetest.swap_node(pos, {name=grill2_off_name})
	end,
	after_dig_node = after_dig,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1},
	node_box = grill_nodebox
})

minetest.register_node(grill_top_name, {
   description = "Grill lid",
   tiles = {
		grill_texture
	},
	drawtype = "nodebox",
	drop = '',
	paramtype = "light",
	paramtype2 = "facedir",
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
    -- open lid
		if minetest.get_node(below(pos)).name == grill2_on_no_light_name then 
			minetest.swap_node(below(pos), {name = grill2_on_name}) 
		end
    
    minetest.swap_node(pos, {name = grill_top_open_name})
	end,
	groups = {not_in_creative_inventory = 1},
	node_box = top_closed_nodebox
})

minetest.register_node(grill_top_open_name, {
	description = "Grill lid",
	tiles = {
		grill_texture
	},
	drawtype = "nodebox",
	drop = '',
	paramtype = "light",
	paramtype2 = "facedir",
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
    -- close lid
		if minetest.get_node(below(pos)).name == grill2_on_name then 
			minetest.swap_node(below(pos), {name = grill2_on_no_light_name}) 
		end
    
    minetest.swap_node(pos, {name = grill_top_name})
	end,
	groups = {not_in_creative_inventory = 1},
	node_box = top_open_nodebox
})
