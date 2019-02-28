function ma_pops_furniture.sit(pos, node, clicker)
	local meta = minetest.get_meta(pos)
	local param2 = node.param2
	local name = clicker:get_player_name()

	if name == meta:get_string("is_sit") then
		print 'player should be standing.'
		meta:set_string("is_sit", "")
		pos.y = pos.y-0.5
		clicker:setpos(pos)
		clicker:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
		clicker:set_physics_override(1, 1, 1)
		default.player_attached[name] = false
		default.player_set_animation(clicker, "stand", 30)
	else
		meta:set_string("is_sit", clicker:get_player_name())
		print 'player should be sitting.'
		clicker:set_eye_offset({x=0,y=-7,z=2}, {x=0,y=0,z=0})
		clicker:set_physics_override(0, 0, 0)
		clicker:setpos(pos)
		default.player_attached[name] = true
		default.player_set_animation(clicker, "sit", 30)
		if param2 == 0 then
			clicker:set_look_yaw(3.15)
		elseif param2 == 1 then
			clicker:set_look_yaw(7.9)
		elseif param2 == 2 then
			clicker:set_look_yaw(6.28)
		elseif param2 == 3 then
			clicker:set_look_yaw(4.75)
		else return end
	end
end

function ma_pops_furniture.dig_chair(pos, node, meta, digger)
	local sitting = meta.fields.is_sit or nil

	if sitting and sitting ~= "" then
		local player = minetest.get_player_by_name(sitting)
		pos.y = pos.y-0.5
		player:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
		player:set_physics_override(1, 1, 1)
		default.player_attached[sitting] = false
		default.player_set_animation(player, "stand", 30)
	end
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
