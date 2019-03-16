local USES = 200 --how many times you can use the tool before it breaks.

minetest.register_tool('ma_pops_furniture:hammer', {
	description = 'Hammer',
	inventory_image = 'mp_hammer.png',
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= 'node' then
			return
		end
		local pos = pointed_thing.under
		local node = minetest.get_node(pos)
		local sofa_table = {
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
	
			if node.name == 'ma_pops_furniture:sofa_'..color then
				minetest.set_node(pos,{name = 'ma_pops_furniture:sofa_r_'..color, param2=node.param2})
			end
			if node.name == 'ma_pops_furniture:sofa_r_'..color then
				minetest.set_node(pos,{name = 'ma_pops_furniture:sofa_m_'..color, param2=node.param2})
			end
			if node.name == 'ma_pops_furniture:sofa_m_'..color then
				minetest.set_node(pos,{name = 'ma_pops_furniture:sofa_l_'..color, param2=node.param2})
			end
			if node.name == 'ma_pops_furniture:sofa_l_'..color then
				minetest.set_node(pos,{name = 'ma_pops_furniture:sofa_c_'..color, param2=node.param2})
			end
			if node.name == 'ma_pops_furniture:sofa_c_'..color then
				minetest.set_node(pos,{name = 'ma_pops_furniture:sofa_'..color, param2=node.param2})
			end
		end
		if not minetest.setting_getbool("creative_mode") then
			itemstack:add_wear(65535 / (USES - 1))
		end
		return itemstack
	end,
	
	on_place = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= 'node' then
			return
		end
		local pos = pointed_thing.under
		local node = minetest.get_node(pos).name
		local para = minetest.get_node(pos).param2
		local newpara = para + 1
			if newpara > 3 then
			newpara = 0
			end
		minetest.set_node(pos,{name = ""..node, param2 = newpara})

		if not minetest.setting_getbool("creative_mode") then
			itemstack:add_wear(65535 / (USES - 1))
		end
		return itemstack
	end,
})

minetest.register_tool('ma_pops_furniture:shears', {
	description = 'Shears',
	inventory_image = 'mp_shears.png',
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= 'node' then
			return
		end
		local pos = pointed_thing.under
		local node = minetest.get_node(pos)
		local hedge_table = { --material
		{'leaves'},
		{'pine_needles'},
		{'jungleleaves'},
		{'aspen_leaves'},
		{'acacia_leaves'}
		}
	
		for i in ipairs (hedge_table) do
		local mat = hedge_table[i][1]
	
			if node.name == 'ma_pops_furniture:hedge_'..mat then
				minetest.set_node(pos,{name = 'ma_pops_furniture:hedge_t_'..mat, param2=node.param2})
			end
			if node.name == 'ma_pops_furniture:hedge_t_'..mat then
				minetest.set_node(pos,{name = 'ma_pops_furniture:hedge_c_'..mat, param2=node.param2})
			end
			if node.name == 'ma_pops_furniture:hedge_c_'..mat then
				minetest.set_node(pos,{name = 'ma_pops_furniture:hedge_'..mat, param2=node.param2})
			end
		end
		if not minetest.setting_getbool("creative_mode") then
			itemstack:add_wear(65535 / (USES - 1))
		end
		return itemstack
	end,
	
	on_place = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= 'node' then
			return
		end
		local pos = pointed_thing.under
		local node = minetest.get_node(pos).name
		local para = minetest.get_node(pos).param2
		local newpara = para + 1
			if newpara > 3 then
			newpara = 0
			end
		minetest.set_node(pos,{name = ""..node, param2 = newpara})

		if not minetest.setting_getbool("creative_mode") then
			itemstack:add_wear(65535 / (USES - 1))
		end
		return itemstack
	end,
})
