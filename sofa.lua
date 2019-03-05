ma_pops_furniture.default_hues = {
	"white",
	"grey",
	"dark_grey",
	"black",
	"violet",
	"blue",
	"cyan",
	"dark_green",
	"green",
	"yellow",
	"orange",
	"red",
	"magenta"
}

local sofa_table = { --name, color, colorize(hex or color name:intensity(1-255))
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

local function sofa_punch(sofa_type, pos, node, clicker)
        local item = clicker:get_wielded_item():get_name()
	
	-- Extract mod name and color
	split = string.split(item, ":")
	mod, color = split[1], split[2]
	
	-- If dye, recolor sofa
	if mod == 'dye' then
		node.name = sofa_type..color
		minetest.set_node(pos, node)
	end

        ma_pops_furniture.sit(pos, node, clicker)
end

for i in ipairs (sofa_table) do
	local name = sofa_table[i][1]
	local color = sofa_table[i][2]
	local hex = sofa_table[i][3]
	
minetest.register_node('ma_pops_furniture:sofa_'..color, {
	description = name..' Sofa',
	drawtype = 'mesh',
	mesh = 'FM_sofa.obj',
	tiles = {'wool_'..color..'.png'},
	groups = {cracky=3, oddly_breakable_by_hand=2, flammable=1, furniture=1, fall_damage_add_percent=-80, bouncy=80},
	--inventory_image = 'mp_sofa.png^[colorize:'..hex,
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = {wood = {name="furn_bouncy", gain=0.8}},
	can_dig = ma_pops_furniture.sit_dig,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		pos.y = pos.y + 0  -- Sitting position
		ma_pops_furniture.sit(pos, node, clicker, pointed_thing)
		return itemstack
	end,
	selection_box = {
		type = 'fixed',
		fixed = {

					{-.5, -.5, -.5, .5, 0, .5}, --Right, Bottom, Back, Left, Top, Front
			{-.5, 0, .5, .5, .5, .2},
			{-.65, -.15, -.45, -.45, .3, .25}, --left
			{.65, -.15, -.45, .45, .3, .25}, --right
			},
		},
	collision_box = {
		type = 'fixed',
		fixed = {
			{-.5, -.5, -.5, .5, 0, .5}, --base
			{-.5, 0, .5, .5, .5, .2}, --back
			{-.65, -.15, -.45, -.45, .3, .25}, --left
			{.65, -.15, -.45, .45, .3, .25}, --right
			},
		},
	on_punch = function(pos, node, clicker)
		sofa_punch("ma_pops_furniture:sofa_", pos, node, clicker)
	end
})

minetest.register_node('ma_pops_furniture:sofa_l_'..color, {
    description = name..' Sofa',
    drawtype = 'mesh',
    mesh = 'FM_sofa_l.obj',
    tiles = {'wool_'..color..'.png'},
    groups = {cracky=3, oddly_breakable_by_hand=2, flammable=1, not_in_creative_inventory=1, fall_damage_add_percent=-80, bouncy=80},
    drop = 'ma_pops_furniture:sofa_'..color,
    paramtype = "light",
    paramtype2 = "facedir",
	can_dig = ma_pops_furniture.sit_dig,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		pos.y = pos.y + 0  -- Sitting position
		ma_pops_furniture.sit(pos, node, clicker, pointed_thing)
		return itemstack
	end,
    sounds = {
        wood = {name="furn_bouncy", gain=0.8}
    },
    selection_box = {
        type = 'fixed',
        fixed = {
            {-.5, -.5, -.5, .5, 0, .5},
            {-.5, 0, .5, .5, .5, .2},
            {.65, -.15, -.45, .45, .3, .25},
        }
    },
    collision_box = {
        type = 'fixed',
        fixed = {
            {-.5, -.5, -.5, .5, 0, .5},
            {-.5, 0, .5, .5, .5, .2},
            {.65, -.15, -.45, .45, .3, .25},
        }
    },
    on_punch = function(pos, node, clicker)
        sofa_punch("ma_pops_furniture:sofa_l_", pos, node, clicker)
    end
})

minetest.register_node('ma_pops_furniture:sofa_m_'..color, {
	description = name..' Sofa',
	drawtype = 'mesh',
	mesh = 'FM_sofa_m.obj',
	tiles = {'wool_'..color..'.png'},
	groups = {cracky=3, oddly_breakable_by_hand=2, flammable=1, not_in_creative_inventory=1, fall_damage_add_percent=-80, bouncy=80},
	drop = 'ma_pops_furniture:sofa_'..color,
	paramtype = "light",
	paramtype2 = "facedir",
	can_dig = ma_pops_furniture.sit_dig,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		pos.y = pos.y + 0  -- Sitting position
		ma_pops_furniture.sit(pos, node, clicker, pointed_thing)
		return itemstack
	end,
	sounds = {wood = {name="furn_bouncy", gain=0.8}},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-.5, -.5, -.5, .5, 0, .5},
			{-.5, 0, .5, .5, .5, .2},
			}
		},
	collision_box = {
		type = 'fixed',
		fixed = {
			{-.5, -.5, -.5, .5, 0, .5},
			{-.5, 0, .5, .5, .5, .2},
			}
		},
	on_punch = function(pos, node, clicker)
		sofa_punch("ma_pops_furniture:sofa_m_", pos, node, clicker)
	end
})

minetest.register_node('ma_pops_furniture:sofa_r_'..color, {
	description = name..' Sofa',
	drawtype = 'mesh',
	mesh = 'FM_sofa_r.obj',
	tiles = {'wool_'..color..'.png'},
	groups = {cracky=3, oddly_breakable_by_hand=2, flammable=1, not_in_creative_inventory=1, fall_damage_add_percent=-80, bouncy=80},
	drop = 'ma_pops_furniture:sofa_'..color,
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = {wood = {name="furn_bouncy", gain=0.8}},
	can_dig = ma_pops_furniture.sit_dig,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		pos.y = pos.y + 0  -- Sitting position
		ma_pops_furniture.sit(pos, node, clicker, pointed_thing)
		return itemstack
	end,
	selection_box = {
		type = 'fixed',
		fixed = {
			{-.5, -.5, -.5, .5, 0, .5},
			{-.5, 0, .5, .5, .5, .2},
			{-.65, -.15, -.45, -.45, .3, .25},
			}
		},
	collision_box = {
		type = 'fixed',
		fixed = {
			{-.5, -.5, -.5, .5, 0, .5},
			{-.5, 0, .5, .5, .5, .2},
			{-.65, -.15, -.45, -.45, .3, .25},
			}
		},
	on_punch = function(pos, node, clicker)
		sofa_punch("ma_pops_furniture:sofa_r_", pos, node, clicker)
	end
})

minetest.register_node('ma_pops_furniture:sofa_c_'..color, {
	description = name..' Sofa',
	drawtype = 'mesh',
	mesh = 'FM_sofa_c.obj',
	tiles = {'wool_'..color..'.png'},
	groups = {cracky=3, oddly_breakable_by_hand=2, flammable=1, not_in_creative_inventory=1, furniture=1, fall_damage_add_percent=-80, bouncy=80},
	drop = 'ma_pops_furniture:sofa_'..color,
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = {wood = {name="furn_bouncy", gain=0.8}},
	can_dig = ma_pops_furniture.sit_dig,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		pos.y = pos.y + 0  -- Sitting position
		ma_pops_furniture.sit(pos, node, clicker, pointed_thing)
		return itemstack
	end,
	selection_box = {
		type = 'fixed',
		fixed = {
			{-.5, -.5, -.5, .5, 0, .5}, --bottom
			{-.5, 0, .5, .5, .5, .2}, --back
			{.2, 0, -.5, .5, .5, .2}, --side
			}
		},
	collision_box = {
		type = 'fixed',
		fixed = {
			{-.5, -.5, -.5, .5, 0, .5},
			{-.5, 0, .5, .5, .5, .2},
			}
		},
	on_punch = function(pos, node, clicker)
		sofa_punch("ma_pops_furniture:sofa_c_", pos, node, clicker)
	end
})
end
