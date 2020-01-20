minetest.register_node('ma_pops_furniture:tv_rainbow', {
	description = 'TV',
	drawtype = 'mesh',
	mesh = 'FM_tv.obj',
	drop = 'ma_pops_furniture:tv_off',
	tiles = {{name='default_tree.png'},{name='mp_channel_rainbow.png', animation={type='vertical_frames', aspect_w=64, aspect_h=48, length=3}}},
	groups = {cracky=2, oddly_breakable_by_hand=3, not_in_creative_inventory=1, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	light_source = 14,
	sounds = moditems.WOOD_SOUNDS,
	selection_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},  -- Right, Bottom, Back, Left, Top, Front
		},
	collision_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},
		},
	 on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
	node.name = "ma_pops_furniture:tv_blast"
		minetest.set_node(pos, node)
    if string.len(meta:get_string("hwnd")) > 0 then
        minetest.sound_stop(meta:get_string("hwnd"))
        meta:set_string("hwnd",nil)
    else
        meta:set_string("hwnd",minetest.sound_play("mp_blast", {gain = 0.5, max_hear_distance = 25}))
    end
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
    end,
})

minetest.register_node('ma_pops_furniture:tv_blast', {
	description = 'TV',
	drawtype = 'mesh',
	mesh = 'FM_tv.obj',
	drop = 'ma_pops_furniture:tv_off',
	tiles = {{name='default_tree.png'},{name='mp_channel_blast.png', animation={type='vertical_frames', aspect_w=64, aspect_h=64, length=22}}},
	groups = {cracky=2, oddly_breakable_by_hand=3, not_in_creative_inventory=1, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	light_source = 14,
	sounds = moditems.WOOD_SOUNDS,
	selection_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},  -- Right, Bottom, Back, Left, Top, Front
		},
	collision_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},
		},
	 on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
	node.name = "ma_pops_furniture:tv_static"
		minetest.set_node(pos, node)
    if string.len(meta:get_string("hwnd")) > 0 then
        minetest.sound_stop(meta:get_string("hwnd"))
        meta:set_string("hwnd",nil)
    else
        meta:set_string("hwnd",minetest.sound_play("mp_static", {gain = 0.5, max_hear_distance = 25}))
    end
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
    end,
})

minetest.register_node('ma_pops_furniture:tv_static', {
	description = 'TV',
	drawtype = 'mesh',
	mesh = 'FM_tv.obj',
	drop = 'ma_pops_furniture:tv_off',
	tiles = {{name='default_tree.png'},{name='mp_channel_static.png', animation={type='vertical_frames', aspect_w=40, aspect_h=30, length=1}}},
	groups = {cracky=2, oddly_breakable_by_hand=3, not_in_creative_inventory=1, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	light_source = 14,
	sounds = moditems.WOOD_SOUNDS,
	selection_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},  -- Right, Bottom, Back, Left, Top, Front
		},
	collision_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},
		},
	 on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
	node.name = "ma_pops_furniture:tv_cube"
		minetest.set_node(pos, node)
    if string.len(meta:get_string("hwnd")) > 0 then
        minetest.sound_stop(meta:get_string("hwnd"))
        meta:set_string("hwnd",nil)
    else
        meta:set_string("hwnd",minetest.sound_play("mp_glass", {gain = 0.5, max_hear_distance = 25}))
    end
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
    end,
})

minetest.register_node('ma_pops_furniture:tv_cube', {
	description = 'TV',
	drawtype = 'mesh',
	mesh = 'FM_tv.obj',
	drop = 'ma_pops_furniture:tv_off',
	tiles = {{name='default_tree.png'},{name='mp_channel_cube.png', animation={type='vertical_frames', aspect_w=40, aspect_h=40, length=2}}},
	groups = {cracky=2, oddly_breakable_by_hand=3, not_in_creative_inventory=1, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	light_source = 14,
	sounds = moditems.WOOD_SOUNDS,
	selection_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},  -- Right, Bottom, Back, Left, Top, Front
		},
	collision_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},
		},
	  on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
	node.name = "ma_pops_furniture:tv_off"
		minetest.set_node(pos, node)
    if string.len(meta:get_string("hwnd")) > 0 then
        minetest.sound_stop(meta:get_string("hwnd"))
        meta:set_string("hwnd",nil)
    end
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
    end,
})

minetest.register_node('ma_pops_furniture:tv_off', {
	description = 'TV',
	drawtype = 'mesh',
	mesh = 'FM_tv.obj',
	tiles = {{name='default_tree.png'},{name='wool_black.png^default_glass_detail.png^[colorize:black:225',}},
	groups = {cracky=2, oddly_breakable_by_hand=3, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	light_source = 1,
	sounds = moditems.WOOD_SOUNDS,
	selection_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},  -- Right, Bottom, Back, Left, Top, Front
		},
	collision_box = {
		type = 'fixed',
		fixed = {-.45, -.5, -.5, .45, .4, .45},
		},
	on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
	node.name = "ma_pops_furniture:tv_rainbow"
		minetest.set_node(pos, node)
    if string.len(meta:get_string("hwnd")) > 0 then
        minetest.sound_stop(meta:get_string("hwnd"))
        meta:set_string("hwnd",nil)
    else
        meta:set_string("hwnd",minetest.sound_play("mp_rainbow", {gain = 0.5, max_hear_distance = 25}))
    end
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
    end,
})

minetest.register_node('ma_pops_furniture:lcd_tv_off', {
	description = 'TV',
	drawtype = 'mesh',
	mesh = 'FM_lcd_tv.obj',
	tiles = {{name='mp_flat_tv.png'},{name='wool_black.png^default_glass_detail.png^[colorize:black:225',}},
	groups = {cracky=2, oddly_breakable_by_hand=3, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	light_source = 1,
	sounds = moditems.STONE_SOUNDS,
	selection_box = {
		type = 'fixed',
		fixed = {-0.98, -.5, -.10, 0.98, .8, .10},  -- Right, Bottom, Back, Left, Top, Front
		},
	collision_box = {
		type = 'fixed',
		fixed = {-0.98, -.5, -.10, 0.98, .8, .10},
		},
		on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
	node.name = "ma_pops_furniture:lcd_tv_rainbow"
		minetest.set_node(pos, node)
    if string.len(meta:get_string("hwnd")) > 0 then
        minetest.sound_stop(meta:get_string("hwnd"))
        meta:set_string("hwnd",nil)
    else
        meta:set_string("hwnd",minetest.sound_play("mp_rainbow", {gain = 0.5, max_hear_distance = 25}))
    end
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
    end,
})

minetest.register_node('ma_pops_furniture:lcd_tv_rainbow', {
	description = 'TV',
	drawtype = 'mesh',
	mesh = 'FM_lcd_tv.obj',
	tiles = {{name='mp_flat_tv.png'},{name='mp_channel_screen.png', animation={type='vertical_frames', aspect_w=40, aspect_h=40, length=2}}},
	groups = {cracky=2, oddly_breakable_by_hand=3, furniture=1, not_in_creative_inventory=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	light_source = 1,
	sounds = moditems.STONE_SOUNDS,
	drop = "ma_pops_furniture:lcd_tv_off",
	selection_box = {
		type = 'fixed',
		fixed = {-0.98, -.5, -.10, 0.98, .8, .10},  -- Right, Bottom, Back, Left, Top, Front
		},
	collision_box = {
		type = 'fixed',
		fixed = {-0.98, -.5, -.10, 0.98, .8, .10},
		},
		on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
	node.name = "ma_pops_furniture:lcd_tv_blast"
		minetest.set_node(pos, node)
    if string.len(meta:get_string("hwnd")) > 0 then
        minetest.sound_stop(meta:get_string("hwnd"))
        meta:set_string("hwnd",nil)
    else
        meta:set_string("hwnd",minetest.sound_play("mp_blast", {gain = 0.5, max_hear_distance = 25}))
    end
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
    end,
})

minetest.register_node('ma_pops_furniture:lcd_tv_blast', {
	description = 'HD TV',
	drawtype = 'mesh',
	mesh = 'FM_lcd_tv.obj',
	drop = 'ma_pops_furniture:lcd_tv_off',
	tiles = {{name='mp_flat_tv.png'},{name='mp_channel_blast.png', animation={type='vertical_frames', aspect_w=64, aspect_h=64, length=22}}},
	groups = {cracky=2, oddly_breakable_by_hand=3, not_in_creative_inventory=1, furniture=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	light_source = 14,
	sounds = moditems.STONE_SOUNDS,
	selection_box = {
		type = 'fixed',
		fixed = {-0.98, -.5, -.10, 0.98, .8, .10},  -- Right, Bottom, Back, Left, Top, Front
		},
	collision_box = {
		type = 'fixed',
		fixed = {-0.98, -.5, -.10, 0.98, .8, .10},
		},
	 on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
	node.name = "ma_pops_furniture:lcd_tv_off"
		minetest.set_node(pos, node)
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
    end,
})