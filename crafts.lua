minetest.register_craft({
	output = 'ma_pops_furniture:smoke_detector',
	recipe = {
	{'default:stone','dye:white','default:stone',},
	{'default:stone','default:copper_ingot','default:stone',},
	{'default:stone','dye:red','default:stone',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:br_tile',
	recipe = {
	{'dye:black','dye:white','dye:black',},
	{'','default:stone_block','',},
	{'dye:black','','dye:black',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:ceiling_lamp',
	recipe = {
	{'', 'default:stone', ''},
	{'default:stone', 'default:meselamp', 'default:stone'},
	{'default:stone', 'default:meselamp', 'default:stone'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:outdoor_lamp',
	recipe = {
	{'','','',},
	{'default:stone','default:stone','default:stone',},
	{'default:stone','default:meselamp','default:stone',},
	}
})
--changed bathroom_faucet to bath_faucet and added craft
minetest.register_craft({
	output = 'ma_pops_furniture:bath_faucet',
	recipe = {
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	{'default:steel_ingot','','bucket:bucket_water',},
	{'default:steel_ingot','','',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:toilet_paper_roll_dispenser',
	recipe = {
	{'default:stone','default:stone','default:stone',},
	{'default:paper','bucket:water','default:paper',},
	{'','default:paper','',},
	}
})
--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:toilet_close',
	recipe = {
	{'','','default:steel_ingot',},
	{'default:steel_ingot','stairs:slab_wood','default:steel_ingot',},
	{'default:steel_ingot','bucket:bucket_water','default:steel_ingot',},
	}
})
--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:br_sink',
	recipe = {
	{'default:steel_ingot','','default:steel_ingot',},
	{'','default:steel_ingot','',},
	{'','default:steel_ingot','',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:mirror_closed',
	recipe = {
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	{'default:glass','default:glass','default:glass',},
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	}
})
--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:shower_base',
	recipe = {
	{'','','',},
	{'','','',},
	{'default:steel_ingot','bucket:bucket_empty','default:steel_ingot',},
	}
})
--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:shower_top',
	recipe = {
	{'','default:steel_ingot','',},
	{'default:steel_ingot','bucket:bucket_water','default:steel_ingot',},
	{'default:steel_ingot','','default:steel_ingot',},
	}
})

local night_table = { --name, material, invimg
{'wood'},
{'aspen_wood'},
{'junglewood'},
{'acacia_wood'},
{'pine_wood'},
{'cobble'}
}

for i in ipairs (night_table) do
	local material = night_table[i][1]

minetest.register_craft({
	output = 'ma_pops_furniture:nightstand_'..material,
	recipe = {
	{'default:'..material, 'default:'..material, 'default:'..material},
	{'default:'..material, 'default:chest', 'default:'..material},
	{'default:'..material, 'default:'..material, 'default:'..material}
	}
})
end

local chair = { --name, material, invimg
{'wood'},
{'aspen_wood'},
{'junglewood'},
{'acacia_wood'},
{'pine_wood'},
{'cobble'}
}

for i in ipairs (chair) do
	local material = chair[i][1]

minetest.register_craft({
	output = 'ma_pops_furniture:chair_'..material,
	recipe = {
	{'default:'..material, '', ''},
	{'default:'..material, 'default:'..material, 'default:'..material},
	{'default:'..material, '', 'default:'..material}
	}
})
end

minetest.register_craft({
	output = 'ma_pops_furniture:barrel',
	recipe = {
	{'default:wood','default:wood','default:wood',},
	{'default:wood','default:steel_ingot','default:wood',},
	{'default:wood','default:wood','default:wood',},
	}
})

--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:dw',
	recipe = {
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	{'default:steel_ingot','bucket:bucket_water','default:steel_ingot',},
	{'default:steel_ingot','default:mese_crystal','default:steel_ingot',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:oven',
	recipe = {
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	{'default:steel_ingot','default:furnace','default:steel_ingot',},
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	}
})
--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:oven_overhead',
	recipe = {
	{'default:steel_ingot','default:mese_crystal_fragment','default:steel_ingot',},
	{'','','',},
	{'','','',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:microwave',
	recipe = {
	{'','','',},
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	{'default:steel_ingot','default:furnace','default:steel_ingot',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:coffee_maker',
	recipe = {
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	{'default:steel_ingot','default:copper_ingot','default:steel_ingot',},
	{'','default:glass','',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:coffee_cup',
	recipe = {
	{'default:glass','dye:blue','default:glass',},
	{'default:glass','dye:blue','default:glass',},
	{'default:glass','default:glass','default:glass',},
	}
})
--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:toaster',
	recipe = {
	{'','','',},
	{'default:steel_ingot','default:furnace','default:steel_ingot',},
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:trash_can',
	recipe = {
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	{'default:steel_ingot','bucket:bucket_lava','default:steel_ingot',},
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	}
})

--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:kitchen_faucet',
	recipe = {
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	{'default:steel_ingot','','default:steel_ingot',},
	{'default:steel_ingot','','',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:cutting_board',
	recipe = {
	{'','','',},
	{'','','',},
	{'default:wood','default:wood','',},
	}
})
local counter_table = { --name, color, colorize(hex or color name:intensity(1-255))
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

for i in ipairs (counter_table) do
	local name = counter_table[i][1]
	local color = counter_table[i][2]
	local hex = counter_table[i][3]

minetest.register_craft({
	output = 'ma_pops_furniture:counter2_'..color,
	recipe = {
	{'group:wood','group:wood','group:wood',},
	{'group:wood','dye:'..color,'group:wood',},
	{'group:wood','group:wood','group:wood',},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = 'ma_pops_furniture:counter1_'..color,
	recipe =
	{'ma_pops_furniture:counter2_'..color}
})

minetest.register_craft({
	type = "shapeless",
	output = 'ma_pops_furniture:counter3_'..color,
	recipe =
	{'ma_pops_furniture:counter2_'..color, "default:chest"}
})

minetest.register_craft({
	type = "shapeless",
	output = 'ma_pops_furniture:counter_'..color,
	recipe =
	{'ma_pops_furniture:counter3_'..color}
})

minetest.register_craft({
	output = 'ma_pops_furniture:upcabinet_'..color,
	recipe = {
	{'group:wood','dye:'..color,'group:wood',},
	{'group:wood','default:chest','group:wood',},
	{'group:wood','group:wood','group:wood',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:upcabinet_corner',
	recipe = {
	{'group:wood','group:wood','group:wood',},
	{'group:wood','group:wood','default:chest',},
	{'group:wood','dye:'..color,'',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:sink_'..color,
	recipe = {
	{'ma_pops_furniture:br_sink','ma_pops_furniture:counter_'..color,},
	}
})
end

local counter_table = { --name, material
{'Wooden', 'wood'},
{'Acacia', 'acacia_wood'},
{'Aspen', 'aspen_wood'},
{'Jungle', 'junglewood' },
{'Pine', 'pine_wood'},
}

for i in ipairs (counter_table) do
	local name = counter_table[i][1]
	local material = counter_table[i][2]
	local hex = counter_table[i][3]

minetest.register_craft({
	output = 'ma_pops_furniture:counter2_'..material,
	recipe = {
	{'default:'..material,'default:'..material,'default:'..material,},
	{'default:'..material, 'ma_pops_furniture:barrel','default:'..material,},
	{'default:'..material,'default:'..material,'default:'..material,},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = 'ma_pops_furniture:counter3_'..material,
	recipe =
	{'ma_pops_furniture:counter2_'..material, "ma_pops_furniture:barrel"}
})

minetest.register_craft({
	type = "shapeless",
	output = 'ma_pops_furniture:counter_'..material,
	recipe =
	{'ma_pops_furniture:counter3_'..material}
})

minetest.register_craft({
	type = "shapeless",
	output = 'ma_pops_furniture:counter1_'..material,
	recipe =
	{'ma_pops_furniture:counter2_'..material}
})

minetest.register_craft({
	output = 'ma_pops_furniture:upcabinet_'..material,
	recipe = {
	{'default:'..material,'','default:'..material,},
	{'default:'..material,'default:chest','default:'..material,},
	{'default:'..material,'default:'..material,'default:'..material,},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:upcabinet_corner',
	recipe = {
	{'default:'..material,'default:'..material,'default:'..material,},
	{'default:'..material,'default:'..material,'default:chest',},
	{'default:'..material,'','',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:sink_'..material,
	recipe = {
	{'ma_pops_furniture:br_sink','ma_pops_furniture:counter_'..material,},
	}
})

end

--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:fridge',
	recipe = {
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	{'default:steel_ingot','default:snow','default:steel_ingot',},
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	}
})
--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:freezer',
	recipe = {
	{'default:steel_ingot','default:mese_crystal','default:steel_ingot',},
	{'default:steel_ingot','default:ice','default:steel_ingot',},
	{'default:steel_ingot','default:mese_crystal','default:steel_ingot',},
	}
})

local chair2_table = { --color
{'black'},
{'blue'},
{'brown'},
{'cyan'},
{'dark_green'},
{'dark_grey'},
{'green'},
{'grey'},
{'magenta'},
{'orange'},
{'pink'},
{'red'},
{'violet'},
{'yellow'},
}

for i in ipairs (chair2_table) do
	local color = chair2_table[i][1]
	
minetest.register_craft({
	output = 'ma_pops_furniture:chair2_'..color,
	recipe = {
	{'wool:'..color, 'wool:'..color, 'wool:'..color, },
	{'wool:'..color, 'wool:'..color, 'wool:'..color, },
	{'group:wood', '', 'group:wood', },
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_'..color,
	recipe = {
	{'ma_pops_furniture:chair2_white', 'dye:'..color}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_white',
	recipe = {
	{'ma_pops_furniture:chair2_'..color, 'dye:white'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_black',
	recipe = {
	{'ma_pops_furniture:chair2_'..color, 'dye:black'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_blue',
	recipe = {
	{'ma_pops_furniture:chair2_'..color, 'dye:blue'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_brown',
	recipe = {
	{'ma_pops_furniture:chair2_'..color, 'dye:brown'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_cyan',
	recipe = {
	{'ma_pops_furniture:chair2_'..color, 'dye:cyan'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_dark_grey',
	recipe = {
	{'ma_pops_furniture:chair2_'..color, 'dye:dark_grey'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_grey',
	recipe = {
	{'ma_pops_furniture:chair2_'..color, 'dye:grey'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_green',
	recipe = {
	{'ma_pops_furniture:chair2_'..color, 'dye:green'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_magenta',
	recipe = {
	{'ma_pops_furniture:chair2_'..color, 'dye:magenta'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_orange',
	recipe = {
	{'ma_pops_furniture:chair2_'..color, 'dye:orange'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_pink',
	recipe = {
	{'ma_pops_furniture:chair2_'..color, 'dye:pink'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_red',
	recipe = {
	{'ma_pops_furniture:chair2_'..color, 'dye:red'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_violet',
	recipe = {
	{'ma_pops_furniture:chair2_'..color, 'dye:violet'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_yellow',
	recipe = {
	{'ma_pops_furniture:chair2_'..color, 'dye:yellow'}
	}
})
end

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_white',
	recipe = {
	{'wool:white', 'wool:white', 'wool:white', },
	{'wool:white', 'wool:white', 'wool:white', },
	{'group:wood', '', 'group:wood', },
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:chair2_rainbow',
	recipe = {
	{'wool:black', '', '', },
	{'wool:blue', 'wool:yellow', 'wool:pink', },
	{'default: acacia_tree', '', 'default: acacia_tree', },
	}
})

local sofa_table = { --color
{'black'},
{'blue'},
{'brown'},
{'cyan'},
{'dark_green'},
{'dark_grey'},
{'green'},
{'grey'},
{'magenta'},
{'orange'},
{'pink'},
{'red'},
{'violet'},
{'white'},
{'yellow'},
}

for i in ipairs (sofa_table) do
	local color = sofa_table[i][1]
	
minetest.register_craft({
	output = 'ma_pops_furniture:sofa_'..color,
	recipe = {
	{'', '', '', },
	{'wool:'..color, 'wool:'..color, 'wool:'..color, },
	{'wool:'..color, 'wool:'..color, 'wool:'..color, },
	}
})
end

local sofa_table = { --color
{'black'},
{'blue'},
{'brown'},
{'cyan'},
{'dark_green'},
{'dark_grey'},
{'green'},
{'grey'},
{'magenta'},
{'orange'},
{'pink'},
{'red'},
{'violet'},
{'yellow'},
}

for i in ipairs (sofa_table) do
	local color = sofa_table[i][1]

minetest.register_craft({
	output = 'ma_pops_furniture:sofa_'..color,
	recipe = {
	{'ma_pops_furniture:sofa_white', 'dye:'..color}
	}
})
end

local fs_table = { --color
{'black'},
{'blue'},
{'brown'},
{'cyan'},
{'dark_green'},
{'dark_grey'},
{'green'},
{'grey'},
{'magenta'},
{'orange'},
{'pink'},
{'red'},
{'violet'},
{'yellow'},
}

for i in ipairs (fs_table) do
	local color = fs_table[i][1]
	
minetest.register_craft({
	output = 'ma_pops_furniture:fs_'..color,
	recipe = {
	{'wool:'..color, 'wool:'..color, 'wool:'..color, },
	{'group:wood', '', 'group:wood', },
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_'..color,
	recipe = {
	{'ma_pops_furniture:fs_white', 'dye:'..color}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_white',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:white'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:'..color}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_black',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:black'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_blue',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:blue'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_brown',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:brown'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_cyan',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:cyan'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_dark_grey',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:dark_grey'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_grey',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:grey'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_green',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:green'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_magenta',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:magenta'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_orange',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:orange'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_pink',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:pink'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_red',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:red'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_violet',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:violet'}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_yellow',
	recipe = {
	{'ma_pops_furniture:fs_'..color, 'dye:yellow'}
	}
})
end

minetest.register_craft({
	output = 'ma_pops_furniture:fs_white',
	recipe = {
	{'wool:white', 'wool:white', 'wool:white', },
	{'group:wood', '', 'group:wood', },
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fs_rainbow',
	recipe = {
	{'', '', '', },
	{'wool:blue', 'wool:yellow', 'wool:pink', },
	{'default: acacia_tree', '', 'default: acacia_tree', },
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:vcr_off',
	recipe = {
	{'','','',},
	{'default:coalblock','default:coalblock','default:coalblock',},
	{'default:coalblock','default:mese_crystal','default:coalblock',},
	}
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
	
minetest.register_craft({
	output = 'ma_pops_furniture:e_u_'..material,
	recipe = {
	{'default:'..material,'default:'..material,'default:'..material,},
	{'default:'..material,'default:chest','default:'..material,},
	{'default:'..material,'','default:'..material,},
	}
})
end

minetest.register_craft({
	output = "ma_pops_furniture:trampoline",
	recipe = {
		{"farming:string", "farming:string", "farming:string"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fireplace',
	recipe = {
	{'default:brick', 'default:brick', 'default:brick'},
	{'default:brick', 'default:furnace', 'default:brick'},
	{'default:brick', 'default:brick', 'default:brick'}
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
	
minetest.register_craft({
	output = 'ma_pops_furniture:lamp_off_'..color,
	recipe = {
	{'wool:white','wool:white', 'wool:white'},
	{'wool:white', 'default:torch', 'wool:white'},
	{'wool:'..color, 'wool:'..color, 'wool:'..color}
	}
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
	
minetest.register_craft({
	output = 'ma_pops_furniture:curtains_'..color,
	recipe = {
	{'default:acacia_tree','default:acacia_tree', 'default:acacia_tree'},
	{'wool:'..color, '', 'wool:'..color},
	{'wool:'..color, '', 'wool:'..color}
	}
})

minetest.register_craft({
	type = "shapeless",
	output = 'ma_pops_furniture:curtains_2_tall_'..color,
	recipe =
	{'ma_pops_furniture:curtains_'..color, 'ma_pops_furniture:curtains_'..color}
})
end 

minetest.register_craft({
	output = 'ma_pops_furniture:blinds',
	recipe = {
		{'default:stick', 'default:stick', 'default:stick'},
		{'default:stick', 'dye:white', 'default:stick'},
		{'default:stick', 'default:stick', 'default:stick'}
		}
})

minetest.register_craft({
    output = "ma_pops_furniture:stereo",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", },
        {"default:steel_ingot", "default:chest", "default:steel_ingot", },
        {"default:stick", "", "default:stick", }
    }
})

minetest.register_craft({
	output = 'ma_pops_furniture:tv_off',
	recipe = {
		{'default:tree', 'default:tree', 'default:tree'},
		{'default:tree', 'wool:black', 'default:tree'},
		{'default:tree', 'default:tree', 'default:tree'}
		}
})

local c_table = { --name, material, invimg
{'wood'},
{'aspen_wood'},
{'junglewood'},
{'acacia_wood'},
{'pine_wood'},
{'cobble'}
}

for i in ipairs (c_table) do
	local material = c_table[i][1]

minetest.register_craft({
	output = 'ma_pops_furniture:c_'..material,
	recipe = {
	{'', '', ''},
	{'default:'..material, 'default:'..material, 'default:'..material},
	{'default:'..material, '', 'default:'..material}
	}
})
end

minetest.register_craft({
	output = 'ma_pops_furniture:computer',
	recipe = {
	{'default:stone','default:stone','default:stone',},
	{'default:glass','default:mese_crystal','default:stone',},
	{'default:stone','default:copper_lump','default:stone',},
	}
})

local table = { --name, material, invimg
{'wood'},
{'aspen_wood'},
{'junglewood'},
{'acacia_wood'},
{'pine_wood'},
{'cobble'}
}

for i in ipairs (table) do
	local material = table[i][1]

minetest.register_craft({
	output = 'ma_pops_furniture:table_'..material,
	recipe = {
	{'stairs:slab_'..material..'wood', 'stairs:slab_'..material..'wood', 'stairs:slab_'..material..'wood'},
	{'', 'default:stick', ''},
	{'', 'default:stick', ''}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:table_'..material,
	recipe = {
	{'stairs:slab_wood', 'stairs:slab_wood', 'stairs:slab_wood'},
	{'', 'default:stick', ''},
	{'', 'default:stick', ''}
	}
})
end

local hedge_table = { --name, material, invimg
{'leaves'},
{'pine_needles'},
{'jungleleaves'},
{'acacia_leaves'},
{'aspen_leaves'}
}

for i in ipairs (hedge_table) do
	local material = hedge_table[i][1]

minetest.register_craft({
	output = 'ma_pops_furniture:hedge_'..material,
	recipe = {
		{'', '', ''},
		{'default:'..material, 'default:'..material, 'default:'..material},
		{'default:'..material, 'default:'..material, 'default:'..material}
		}
})
end

--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:birdbath',
	recipe = {
	{'default:stone','bucket:bucket_water','default:stone',},
	{'','default:stone','',},
	{'default:stone','default:stone','default:stone',},
	}
})

--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:tile_kitchen',
	recipe = {
	{'default:stone_block','dye:white','default:stone_block',},
	{'dye:black','default:stone_block','dye:black',},
	{'default:stone_block','dye:white','default:stone_block',},
	}
})

--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:tile_floor_kitchen',
	recipe = {
	{'default:stone_block','ma_pops_furniture:hammer',},
	}
})

--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:doorbell 4',
	recipe = {
	{'','default:stone','',},
	{'','default:mese_crystal','',},
	{'','','',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:ac',
	recipe = {
	{'default:coral_skeleton','default:coral_skeleton','default:coral_skeleton',},
	{'default:coral_skeleton','ma_pops_furniture:fan_blade','default:coral_skeleton',},
	{'default:coral_skeleton','default:mese_crystal','default:coral_skeleton',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fan_off',
	recipe = {
	{'default:coral_skeleton','default:coral_skeleton','default:coral_skeleton',},
	{'default:coral_skeleton','ma_pops_furniture:fan_blade','default:coral_skeleton',},
	{'default:coral_skeleton','default:coral_skeleton','default:coral_skeleton',},
	}
})

minetest.register_craftitem("ma_pops_furniture:fan_blade", {
	description = 'Fan Blade',
	inventory_image = "mp_blade.png",
})

minetest.register_craft({
	output = 'ma_pops_furniture:fan_blade',
	recipe = {
	{'default:coral_skeleton','','default:coral_skeleton',},
	{'','default:coral_skeleton','',},
	{'default:coral_skeleton','','default:coral_skeleton',},
	}
})

minetest.register_craftitem("ma_pops_furniture:knife", {
	description = 'Knife',
	inventory_image = "mp_knife.png",
})

minetest.register_craft({
	output = 'ma_pops_furniture:knife',
	recipe = {
	{'default:steel_ingot','','',},
	{'','default:steel_ingot','',},
	{'','','default:stick',},
	}
})

--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:grill',
	recipe = {
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	{'default:steel_ingot','default:steel_ingot','default:steel_ingot',},
	{'default:steel_ingot','','default:steel_ingot',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:fridge_white',
	recipe = {
	{'default:steelblock','default:steelblock','default:steelblock',},
	{'default:steelblock','default:chest','default:steelblock',},
	{'default:steelblock','default:furnace','default:steelblock',}
	}
})

--added craft
local fridges_list = {
	{"black", "Darkened Fridge", color1}, 
	{"blue", "Blue Fridge", color2},
	{"green", "Green Fridge", color3}, 
	{"orange", "Orange Fridge", color5}, 
	{"red", "Red Fridge", color6}, 
	{"yellow", "Yellow Fridge", color7}, 
	{"pink", "Pink Fridge", color8}
}

for i, fridge in ipairs(fridges_list) do
    local colour = fridge[1]
    local fridgedesc = fridge[2]
    local colour2 = fridge[3]
	
minetest.register_craft({
	type = "shapeless",
	output = 'ma_pops_furniture:fridge_'..colour,
	recipe =
	{'ma_pops_furniture:fridge_white', 'dye:'..colour}
})
end

--added craft
minetest.register_craft({
	output = 'ma_pops_furniture:stone_path_1 5',
	recipe = {
	{'default:stone','default:stone',},
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:hammer',
	recipe = {
	{'','default:steel_ingot', ''},
	{'', 'default:stick', 'default:steel_ingot'},
	{'default:stick', '', ''}
	}
})

minetest.register_craft({
	output = 'ma_pops_furniture:shears',
	recipe = {
	{'','default:steel_ingot', ''},
	{'default:stick', '', 'default:steel_ingot'},
	{'', 'default:stick', ''}
	}
})