minetest.register_abm({  -- Controls the contained fires.
	nodenames = {'ma_pops_furniture:fireplace', 'ma_pops_furniture:fireplace_on'},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.env:get_meta(pos)
		for i, name in ipairs({
		'fuel_totaltime',
		'fuel_time',
		}) do
		if meta:get_string(name) == '' then
			meta:set_float(name, 0.0)
			end
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local was_active = false
		if meta:get_float('fuel_time') < meta:get_float('fuel_totaltime') then
			was_active = true
			meta:set_float('fuel_time', meta:get_float('fuel_time') + 0.25)
			end
		if meta:get_float('fuel_time') < meta:get_float('fuel_totaltime') then
			minetest.sound_play({name='fire_small'},{gain=0.07},
			{loop=true})
			local percent = math.floor(meta:get_float('fuel_time') /
			meta:get_float('fuel_totaltime') * 100)
			meta:set_string('infotext','Fireplace active: '..percent..'%')
			minetest.swap_node(pos, {name = 'ma_pops_furniture:fireplace_on', param2 = node.param2})
			meta:set_string('formspec', ma_pops_furniture.fireplace_formspec)
			return
			end
			local fuel = nil
			local fuellist = inv:get_list('fuel')
			if fuellist then
				fuel = minetest.get_craft_result({method = 'fuel', width = 1, items = fuellist})
			end
			if fuel.time <= 0 then
				local node = minetest.get_node(pos)
				if node.name == 'ma_pops_furniture:fireplace_on' then
					meta:set_string('infotext','Put more wood in the fireplace!')
					minetest.swap_node(pos, {name = 'ma_pops_furniture:fireplace', param2 = node.param2})
					meta:set_string('formspec', ma_pops_furniture.fireplace_formspec)
					local timer = minetest.get_node_timer(pos)
					timer:start(190)
				end
			return
		end
		meta:set_string('fuel_totaltime', fuel.time)
		meta:set_string('fuel_time', 0)
		local stack = inv:get_stack('fuel', 1)
		stack:take_item()
		inv:set_stack('fuel', 1, stack)
end,
})
