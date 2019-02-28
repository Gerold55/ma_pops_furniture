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
		on_rightclick = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:sofa_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:sofa_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:sofa_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:sofa_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:sofa_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:sofa_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:sofa_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:sofa_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:sofa_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:sofa_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:sofa_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:sofa_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:sofa_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:sofa_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:sofa_brown"
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

minetest.register_node('ma_pops_furniture:sofa_l_'..color, {
    description = name..' Sofa',
    drawtype = 'mesh',
    mesh = 'FM_sofa_l.obj',
    tiles = {'wool_'..color..'.png'},
    groups = {cracky=3, oddly_breakable_by_hand=2, flammable=1, not_in_creative_inventory=1, fall_damage_add_percent=-80, bouncy=80},
    drop = 'ma_pops_furniture:sofa_'..color,
    paramtype = "light",
    paramtype2 = "facedir",
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
    on_rightclick = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:sofa_l_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:sofa_l_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:sofa_l_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:sofa_l_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:sofa_l_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:sofa_l_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:sofa_l_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:sofa_l_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:sofa_l_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:sofa_l_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:sofa_l_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:sofa_l_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:sofa_l_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:sofa_l_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:sofa_l_brown"
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

minetest.register_node('ma_pops_furniture:sofa_m_'..color, {
	description = name..' Sofa',
	drawtype = 'mesh',
	mesh = 'FM_sofa_m.obj',
	tiles = {'wool_'..color..'.png'},
	groups = {cracky=3, oddly_breakable_by_hand=2, flammable=1, not_in_creative_inventory=1, fall_damage_add_percent=-80, bouncy=80},
	drop = 'ma_pops_furniture:sofa_'..color,
	paramtype = "light",
	paramtype2 = "facedir",
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
	on_rightclick = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:sofa_m_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:sofa_m_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:sofa_m_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:sofa_m_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:sofa_m_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:sofa_m_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:sofa_m_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:sofa_m_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:sofa_m_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:sofa_m_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:sofa_m_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:sofa_m_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:sofa_m_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:sofa_m_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:sofa_m_brown"
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
	on_rightclick = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:sofa_r_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:sofa_r_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:sofa_r_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:sofa_r_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:sofa_r_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:sofa_r_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:sofa_r_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:sofa_r_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:sofa_r_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:sofa_r_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:sofa_r_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:sofa_r_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:sofa_r_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:sofa_r_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:sofa_r_brown"
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
	on_rightclick = function(pos, node, clicker)
	for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'dye:black' then
            node.name = "ma_pops_furniture:sofa_c_black"
               minetest.set_node(pos, node)
        else
                if item == 'dye:white' then
            node.name = "ma_pops_furniture:sofa_c_white"
               minetest.set_node(pos, node)
        else
                if item == 'dye:grey' then
            node.name = "ma_pops_furniture:sofa_c_grey"
               minetest.set_node(pos, node)
        else
        if item == 'dye:dark_grey' then
            node.name = "ma_pops_furniture:sofa_c_dark_grey"
               minetest.set_node(pos, node)
        else
                if item == 'dye:violet' then
            node.name = "ma_pops_furniture:sofa_c_violet"
               minetest.set_node(pos, node)
        else
                if item == 'dye:blue' then
            node.name = "ma_pops_furniture:sofa_c_blue"
               minetest.set_node(pos, node)
        else
                if item == 'dye:cyan' then
            node.name = "ma_pops_furniture:sofa_c_cyan"
               minetest.set_node(pos, node)
        else
                if item == 'dye:dark_green' then
            node.name = "ma_pops_furniture:sofa_c_dark_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:green' then
            node.name = "ma_pops_furniture:sofa_c_green"
               minetest.set_node(pos, node)
        else
                if item == 'dye:yellow' then
            node.name = "ma_pops_furniture:sofa_c_yellow"
               minetest.set_node(pos, node)
        else
                if item == 'dye:orange' then
            node.name = "ma_pops_furniture:sofa_c_orange"
               minetest.set_node(pos, node)
        else
                if item == 'dye:red' then
            node.name = "ma_pops_furniture:sofa_c_red"
               minetest.set_node(pos, node)
        else
                if item == 'dye:magenta' then
            node.name = "ma_pops_furniture:sofa_c_magenta"
               minetest.set_node(pos, node)
        else
                if item == 'dye:pink' then
            node.name = "ma_pops_furniture:sofa_c_pink"
               minetest.set_node(pos, node)
        else
                if item == 'dye:brown' then
            node.name = "ma_pops_furniture:sofa_c_brown"
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