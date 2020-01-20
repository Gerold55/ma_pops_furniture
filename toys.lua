-- GENERATED CODE
-- Node Box Editor, version 0.9.0
-- Namespace: test

minetest.register_node("ma_pops_furniture:boy_game", {
	description = "BoyGame",
	tiles = {
		"default_silver_sandstone.png^mp_boygame.png",
		"default_silver_sandstone.png^mp_boygame_back.png^[transformR180]",
		"default_silver_sandstone.png^mp_boygame_right.png",
		"default_silver_sandstone.png^mp_boygame_left.png",
		"default_silver_sandstone.png^mp_boygame_top.png",
		"default_silver_sandstone.png^mp_boygame_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy = 1, oddly_breakable_by_hand = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.4375, 0.3125, -0.3125, 0.4375},
		}
	}
})

