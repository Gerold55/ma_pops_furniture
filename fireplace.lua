local formspec =
	"size[8,6]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	'background[8,6;0,0;default_brick.png;true]'..
	"list[context;fuel;1,0.25;1,1;]"..
	"list[current_player;main;0,1.75;8,1;]"..
	"list[current_player;main;0,3;8,3;8]"..
	"listring[context;fuel]"..
	"listring[current_player;main]"..
	default.get_hotbar_bg(0, 1.75)

local function swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return false
	end
	node.name = name
	minetest.swap_node(pos, node)
	return true
end

ma_pops_furniture.fireplace_on_timer = function(pos, elapsed)
	-- Inizialize metadata
	local meta = minetest.get_meta(pos)
	local fuel_time = meta:get_float("fuel_time") or 0
	local fuel_totaltime = meta:get_float("fuel_totaltime") or 0

	local inv = meta:get_inventory()
	local fuellist
	local fuel

	local update = true
	while elapsed > 0 and update do
		fuellist = inv:get_list("fuel")

		local el = math.min(elapsed, fuel_totaltime - fuel_time)

		-- Check if we have enough fuel to burn
		if fuel_time < fuel_totaltime then
			-- The furnace is currently active and has enough fuel
			fuel_time = fuel_time + el
		else
			-- We need to get new fuel
			local afterfuel
			fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
			-- Longer burn time
			fuel.time = fuel.time * 6

			if fuel.time == 0 then
				-- No valid fuel in fuel list
				fuel_totaltime = 0
				update = false
			else
				-- Take fuel from fuel list
				inv:set_stack("fuel", 1, afterfuel.items[1])
				fuel_totaltime = fuel.time + (fuel_totaltime - fuel_time)
			end
			fuel_time = 0
		end
		elapsed = elapsed - el
	end

	if fuel and fuel_totaltime > fuel.time then
		fuel_totaltime = fuel.time
	end

	-- Update formspec, infotext and node
	local result = false

	if fuel_totaltime ~= 0 then
		local fuel_percent = math.floor(fuel_time / fuel_totaltime * 100)
		meta:set_string('infotext','Fireplace active: ' .. fuel_percent .. '%')

		if swap_node(pos, "ma_pops_furniture:fireplace_on") then
			local handle = minetest.sound_play('fire_small', {pos = pos, gain = 0.5, loop = true})
			-- Store the handle so we can stop it later
			meta:set_int('sound_handle', handle)
		end
		-- make sure timer restarts automatically
		result = true
	else
		meta:set_string('infotext','Put more fuel in the fireplace!')
		if swap_node(pos, "ma_pops_furniture:fireplace") then
			minetest.sound_stop(meta:get_int('sound_handle'))
		end
		-- stop timer on the inactive furnace
		minetest.get_node_timer(pos):stop()
	end

	-- Set meta values
	meta:set_float("fuel_totaltime", fuel_totaltime)
	meta:set_float("fuel_time", fuel_time)

	return result
end

minetest.register_node('ma_pops_furniture:fireplace', {
	description = 'Fireplace',
	drawtype = 'mesh',
	mesh = 'FM_fireplace_off.obj',
	tiles = {'default_brick.png','xpanes_bar.png'},
	groups = {cracky=2, oddly_breakable_by_hand=6, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_stone_defaults(),
	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('fuel', 1)
		inv:set_size('main', 8*4)
		meta:set_string('formspec', formspec)
		meta:set_string('infotext', 'Put more fuel in the fireplace!')
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('fuel')
	end,
	on_timer = ma_pops_furniture.fireplace_on_timer,
})

minetest.register_node('ma_pops_furniture:fireplace_on', {
	description = 'Fireplace',
	drawtype = 'mesh',
	mesh = 'FM_fireplace_on.obj',
	tiles = {'default_brick.png','xpanes_bar.png','default_tree.png',
		{name='fire_basic_flame_animated.png', animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=1}}},
	drop = 'ma_pops_furniture:fireplace',
	groups = {cracky=2, oddly_breakable_by_hand=3, furniture=1, not_in_creative_inventory=1},
	light_source = 14,
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_stone_defaults(),
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('fuel')
	end,
	on_timer = ma_pops_furniture.fireplace_on_timer,
})
