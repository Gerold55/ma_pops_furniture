local songs = { "static"
}

minetest.register_node("ma_pops_furniture:stereo", {
	description = "Stereo",
	tiles = {
		"mp_radio_top.png",
		"mp_radio_bottom.png",
		"mp_radio_right.png",
		"mp_radio_left.png",
		"mp_radio_back.png",
		"mp_radio_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, furniture = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.1875, 0.5, -0.125, 0.5}, -- NodeBox1
			{-0.25, -0.5, 0.125, 0.25, -0.0625, 0.5}, -- NodeBox2
		}
	},
	on_rightclick = function(pos, node, clicker, itemstack)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then
        minetest.sound_stop(meta:get_string("hwnd"))
        meta:set_string("hwnd",nil)
    else
        meta:set_string("hwnd",minetest.sound_play("radio_" .. songs[math.random(1,#songs)], {gain = 0.5, max_hear_distance = 25}))
    end
    end,
    on_destruct = function(pos)
    local meta = minetest.env:get_meta(pos)
    if string.len(meta:get_string("hwnd")) > 0 then minetest.sound_stop(meta:get_string("hwnd")) end
    end,
})