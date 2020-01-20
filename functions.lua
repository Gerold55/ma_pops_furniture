local function top_face(pointed_thing)
	if not pointed_thing then return end
	return pointed_thing.above.y > pointed_thing.under.y
end

function ma_pops_furniture.sit(pos, node, clicker, pointed_thing)
	if not top_face(pointed_thing) then return end
	local player_name = clicker:get_player_name()
	local objs = minetest.get_objects_inside_radius(pos, 0.1)
	local vel = clicker:get_player_velocity()
	local ctrl = clicker:get_player_control()

	for _, obj in pairs(objs) do
		if obj:is_player() and obj:get_player_name() ~= player_name then
			return
		end
	end

	if default.player_attached[player_name] then
		pos.y = pos.y - 0.5
		clicker:setpos(pos)
		clicker:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
		clicker:set_physics_override(1, 1, 1)
		default.player_attached[player_name] = false
		default.player_set_animation(clicker, "stand", 30)

	elseif not default.player_attached[player_name] and node.param2 <= 3 and
			not ctrl.sneak and vector.equals(vel, {x=0,y=0,z=0}) then

		clicker:set_eye_offset({x=0, y=-7, z=2}, {x=0, y=0, z=0})
		clicker:set_physics_override(0, 0, 0)
		clicker:setpos(pos)
		default.player_attached[player_name] = true
		default.player_set_animation(clicker, "sit", 30)

		if     node.param2 == 0 then clicker:set_look_yaw(3.15)
		elseif node.param2 == 1 then clicker:set_look_yaw(7.9)
		elseif node.param2 == 2 then clicker:set_look_yaw(6.28)
		elseif node.param2 == 3 then clicker:set_look_yaw(4.75) end
	end
end

function ma_pops_furniture.sit_dig(pos, digger)
	for _, player in pairs(minetest.get_objects_inside_radius(pos, 0.1)) do
		if player:is_player() and
			    default.player_attached[player:get_player_name()] then
			return false
		end
	end
	return true
end



ma_pops_furniture.window_operate = function( pos, old_node_state_name, new_node_state_name )
   
   local offsets   = {-1,1,-2,2,-3,3};
   local stop_up   = 0;
   local stop_down = 0;

   for i,v in ipairs(offsets) do

      local node = minetest.get_node_or_nil( {x=pos.x, y=(pos.y+v), z=pos.z } );
      if( node and node.name and node.name==old_node_state_name 
        and ( (v > 0 and stop_up   == 0 ) 
           or (v < 0 and stop_down == 0 ))) then

         minetest.add_node({x=pos.x, y=(pos.y+v), z=pos.z }, {name = new_node_state_name, param2 = node.param2})

      -- found a diffrent node - no need to search further up
      elseif( v > 0 and stop_up   == 0 ) then
         stop_up   = 1; 

      elseif( v < 0 and stop_down == 0 ) then
         stop_down = 1; 
      end
   end
end

--[[
minetest.register_abm({
    nodenames = {"ma_pops_furniture:table_wood"},
    interval = 1, --This will be checked every second

    action = function(pos, node, active_object_count, active_object_count_wider)
        if pos then
            if minetest.get_item_group(minetest.get_node({x = pos.x+1, y = pos.y, z = pos.z}).name, "table") == 1
              and minetest.get_item_group(minetest.get_node({x = pos.x-1, y = pos.y, z = pos.z}).name, "table") == 1 then
                minetest.set_node(pos, {name = "ma_pops_furniture:table_c2_wood"})

            elseif minetest.get_item_group(minetest.get_node({x = pos.x, y = pos.y, z = pos.z+1}).name, "table") == 1
              and minetest.get_item_group(minetest.get_node({x = pos.x, y = pos.y, z = pos.z-1}).name, "table") == 1 then
                minetest.set_node(pos, {name = "ma_pops_furniture:table_c2_wood"})
            end
        end
    end
})
--]]

function ma_pops_furniture.check_table(pos, material, check_this, check_others)
	if pos then
		local north_table = minetest.get_node({x = pos.x, y = pos.y, z = pos.z+1})
		local north_table_exists = minetest.get_item_group(north_table.name, "table") == 1

		local east_table = minetest.get_node({x = pos.x+1, y = pos.y, z = pos.z})
		local east_table_exists = minetest.get_item_group(east_table.name, "table") == 1

		local south_table = minetest.get_node({x = pos.x, y = pos.y, z = pos.z-1})
		local south_table_exists = minetest.get_item_group(south_table.name, "table") == 1

		local west_table = minetest.get_node({x = pos.x-1, y = pos.y, z = pos.z})
		local west_table_exists = minetest.get_item_group(west_table.name, "table") == 1

		if check_this then
			if north_table_exists and east_table_exists and south_table_exists and west_table_exists then
				minetest.set_node(pos, {name = "ma_pops_furniture:table_center_"..material})

		    elseif east_table_exists and west_table_exists then
				if north_table_exists then
					minetest.set_node(pos, {name = "ma_pops_furniture:table_c_"..material, param2 = 3})
				elseif south_table_exists then
					minetest.set_node(pos, {name = "ma_pops_furniture:table_c_"..material, param2 = 1})
				else 
					minetest.set_node(pos, {name = "ma_pops_furniture:table_center_"..material})
				end

		    elseif north_table_exists and south_table_exists then
				if east_table_exists then
					minetest.set_node(pos, {name = "ma_pops_furniture:table_c_"..material, param2 = 0})
				elseif west_table_exists then
					minetest.set_node(pos, {name = "ma_pops_furniture:table_c_"..material, param2 = 2})
				else
					minetest.set_node(pos, {name = "ma_pops_furniture:table_center_"..material})
				end

			elseif north_table_exists ~= east_table_exists ~= south_table_exists ~= west_table_exists then
				local facedir

				if north_table_exists then facedir = 3
				elseif east_table_exists then facedir = 0
				elseif south_table_exists then facedir = 1
				else facedir = 2
				end

				minetest.set_node(pos, {name = "ma_pops_furniture:table_c_"..material, param2 = facedir})

			else
				minetest.set_node(pos, {name = "ma_pops_furniture:table_"..material})
		    end
		end

		if check_others then
			if north_table_exists then
				if north_table.name:sub(24, 31) == "_center_" then
					ma_pops_furniture.check_table({x = pos.x, y = pos.y, z = pos.z+1}, north_table.name:sub(32), true, false)
				elseif north_table.name:sub(24, 26) == "_c_" then
					ma_pops_furniture.check_table({x = pos.x, y = pos.y, z = pos.z+1}, north_table.name:sub(27), true, false)
				else
					ma_pops_furniture.check_table({x = pos.x, y = pos.y, z = pos.z+1}, north_table.name:sub(25), true, false)
				end
			end

			if east_table_exists then
				if east_table.name:sub(24, 31) == "_center_" then
					ma_pops_furniture.check_table({x = pos.x+1, y = pos.y, z = pos.z}, east_table.name:sub(32), true, false)
				elseif east_table.name:sub(24, 26) == "_c_" then
					ma_pops_furniture.check_table({x = pos.x+1, y = pos.y, z = pos.z}, east_table.name:sub(27), true, false)
				else
					ma_pops_furniture.check_table({x = pos.x+1, y = pos.y, z = pos.z}, east_table.name:sub(25), true, false)
				end
			end

			if south_table_exists then
				if south_table.name:sub(24, 31) == "_center_" then
					ma_pops_furniture.check_table({x = pos.x, y = pos.y, z = pos.z-1}, south_table.name:sub(32), true, false)
				elseif south_table.name:sub(24, 26) == "_c_" then
					ma_pops_furniture.check_table({x = pos.x, y = pos.y, z = pos.z-1}, south_table.name:sub(27), true, false)
				else
					ma_pops_furniture.check_table({x = pos.x, y = pos.y, z = pos.z-1}, south_table.name:sub(25), true, false)
				end
			end

			if west_table_exists then
				if west_table.name:sub(24, 31) == "_center_" then
					ma_pops_furniture.check_table({x = pos.x-1, y = pos.y, z = pos.z}, west_table.name:sub(32), true, false)
				elseif west_table.name:sub(24, 26) == "_c_" then
					ma_pops_furniture.check_table({x = pos.x-1, y = pos.y, z = pos.z}, west_table.name:sub(27), true, false)
				else
					ma_pops_furniture.check_table({x = pos.x-1, y = pos.y, z = pos.z}, west_table.name:sub(25), true, false)
				end
			end
		end
    end
end