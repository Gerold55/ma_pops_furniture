minetest.register_node("ma_pops_furniture:venext_console", {
		description = "jOyBoX",
		tiles = {
				"mp_venext_top1.png",
				"mp_venext_bottom.png",
				"mp_venext_side.png",
				"mp_venext_side2.png",
				"mp_venext_back.png",
				"mp_venext_front.png",
			},
		groups = {snappy=1,bendy=2,cracky=1},
		sounds = moditems.WOOD_SOUNDS,
        drawtype = "nodebox",
			paramtype = "light",
			paramtype2 = 'facedir',
			node_box = {
				type = "fixed",
				fixed = {
                    {-0.4375, -0.5, -0.4375, 0.4375, -0.1875, 0.4375},
                    {-0.375, -0.1875, -0.375, 0.375, -0.0625, 0.375},
                    {0.3125, -0.4375, -0.5, 0.375, -0.375, -0.4375}, 
                    {0.1875, -0.4375, -0.5, 0.25, -0.375, -0.4375}, 
                }
			}
})

minetest.register_node("ma_pops_furniture:jOyBoX_cart", {
        description = "jOyBoX (with cartridge)",
 
        tiles = {
                "mp_venext_top.png",
                "mp_venext_bottom.png",
                "mp_venext_side.png",
                "mp_venext_side2.png",
                "mp_venext_back.png",
                "mp_venext_front.png",
            },
        groups = {snappy=1,bendy=2,cracky=1},
        drawtype = "nodebox",
            paramtype = "light",
            paramtype2 = 'facedir',
			sounds = moditems.WOOD_SOUNDS,
            on_rightclick = function(pos, node, player)
        for _, obj in ipairs (minetest.get_connected_players())  do
        local item = obj:get_wielded_item():get_name()
        if item == 'ma_pops_furniture:cartridge' then
            node.name = "ma_pops_furniture:jOyBoXrcartridge"
               minetest.set_node(pos, node)
        end
        end
        end,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.4375, -0.5, -0.4375, 0.4375, -0.1875, 0.4375},
                    {-0.375, -0.1875, -0.375, 0.375, -0.0625, 0.375},
                    {0.3125, -0.4375, -0.5, 0.375, -0.375, -0.4375}, 
                    {0.1875, -0.4375, -0.5, 0.25, -0.375, -0.4375}, 
                    {0.25, 0.1, -0.07, -0.25, -0.4375, 0.14}, 
                }
            }
})

minetest.register_node("ma_pops_furniture:cartridge", {
        description = "cartridge",
 
        tiles = {
                "mp_cartridge.png",
                "mp_cartridge_bottom.png",
                "mp_cartridge.png",
                "mp_cartridge.png",
                "mp_cartridge_back.png",
                "mp_cartridge_front.png",
            },
        groups = {snappy=1,bendy=2,cracky=1},
		sounds = moditems.WOOD_SOUNDS,
        drawtype = "nodebox",
            paramtype = "light",
            paramtype2 = 'facedir',
            node_box = {
                type = "fixed",
                fixed = {
                    {0.25, -0.1900, -0.07, -0.25, -0.5, 0.14}, 
                }
            }
})