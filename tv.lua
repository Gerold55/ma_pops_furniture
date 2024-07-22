local function handle_rightclick(pos, node, sound_name, new_node_name)
    local meta = minetest.get_meta(pos)
    node.name = new_node_name
    minetest.set_node(pos, node)
    
    local hwnd = meta:get_string("hwnd")
    if hwnd and string.len(hwnd) > 0 then
        minetest.sound_stop(hwnd)
    end

    meta:set_string("hwnd", minetest.sound_play(sound_name, {
        gain = 0.5,
        max_hear_distance = 25,
        loop = true
    }))
end

local function handle_destruct(pos)
    local meta = minetest.get_meta(pos)
    local hwnd = meta:get_string("hwnd")
    if hwnd and string.len(hwnd) > 0 then
        minetest.sound_stop(hwnd)
    end
end

local function register_tv_node(name, desc, mesh, tiles, sound, new_node_name, light, groups, additional_props)
    local node_def = {
        description = desc,
        drawtype = "mesh",
        mesh = mesh,
        drop = "ma_pops_furniture:tv_off",
        tiles = tiles,
        groups = groups,
        paramtype = "light",
        paramtype2 = "facedir",
        light_source = light,
        sounds = moditems.WOOD_SOUNDS,
        selection_box = {
            type = "fixed",
            fixed = {-.45, -.5, -.5, .45, .4, .45}
        },
        collision_box = {
            type = "fixed",
            fixed = {-.45, -.5, -.5, .45, .4, .45}
        },
        on_rightclick = function(pos, node, clicker, itemstack)
            handle_rightclick(pos, node, sound, new_node_name)
        end,
        on_destruct = handle_destruct
    }
    
    -- Apply additional properties if provided
    if additional_props then
        for k, v in pairs(additional_props) do
            node_def[k] = v
        end
    end

    minetest.register_node(name, node_def)
end

local common_groups = {cracky=2, oddly_breakable_by_hand=3, furniture=1}
local not_in_creative = {cracky=2, oddly_breakable_by_hand=3, not_in_creative_inventory=1, furniture=1}

register_tv_node(
    'ma_pops_furniture:tv_rainbow', 
    'TV', 
    'FM_tv.obj', 
    {
        {name='default_tree.png'},
        {name='mp_channel_rainbow.png', animation={type='vertical_frames', aspect_w=64, aspect_h=48, length=3}}
    }, 
    'mp_rainbow', 
    'ma_pops_furniture:tv_blast', 
    14, 
    not_in_creative
)

register_tv_node(
    'ma_pops_furniture:tv_blast', 
    'TV', 
    'FM_tv.obj', 
    {
        {name='default_tree.png'},
        {name='mp_channel_blast.png', animation={type='vertical_frames', aspect_w=64, aspect_h=64, length=22}}
    }, 
    'mp_blast', 
    'ma_pops_furniture:tv_static', 
    14, 
    not_in_creative
)

register_tv_node(
    'ma_pops_furniture:tv_static', 
    'TV', 
    'FM_tv.obj', 
    {
        {name='default_tree.png'},
        {name='mp_channel_static.png', animation={type='vertical_frames', aspect_w=40, aspect_h=30, length=1}}
    }, 
    'mp_static', 
    'ma_pops_furniture:tv_cube', 
    14, 
    not_in_creative
)

register_tv_node(
    'ma_pops_furniture:tv_cube', 
    'TV', 
    'FM_tv.obj', 
    {
        {name='default_tree.png'},
        {name='mp_channel_cube.png', animation={type='vertical_frames', aspect_w=40, aspect_h=40, length=2}}
    }, 
    'mp_cube', 
    'ma_pops_furniture:tv_off', 
    14, 
    not_in_creative
)

register_tv_node(
    'ma_pops_furniture:tv_off', 
    'TV', 
    'FM_tv.obj', 
    {
        {name='default_tree.png'},
        {name='wool_black.png^default_glass_detail.png^[colorize:black:225'}
    }, 
    'mp_off', 
    'ma_pops_furniture:tv_rainbow', 
    1, 
    common_groups
)

register_tv_node(
    'ma_pops_furniture:lcd_tv_off', 
    'TV', 
    'FM_lcd_tv.obj', 
    {
        {name='mp_flat_tv.png'},
        {name='wool_black.png^default_glass_detail.png^[colorize:black:225'}
    }, 
    'mp_off', 
    'ma_pops_furniture:lcd_tv_rainbow', 
    1, 
    common_groups,
    {
        sounds = moditems.STONE_SOUNDS,
        selection_box = {
            type = "fixed",
            fixed = {-0.98, -.5, -.10, 0.98, .8, .10}
        },
        collision_box = {
            type = "fixed",
            fixed = {-0.98, -.5, -.10, 0.98, .8, .10}
        }
    }
)

register_tv_node(
    'ma_pops_furniture:lcd_tv_rainbow', 
    'TV', 
    'FM_lcd_tv.obj', 
    {
        {name='mp_flat_tv.png'},
        {name='mp_channel_screen.png', animation={type='vertical_frames', aspect_w=40, aspect_h=40, length=2}}
    }, 
    'mp_rainbow', 
    'ma_pops_furniture:lcd_tv_blast', 
    1, 
    not_in_creative,
    {
        sounds = moditems.STONE_SOUNDS,
        drop = "ma_pops_furniture:lcd_tv_off",
        selection_box = {
            type = "fixed",
            fixed = {-0.98, -.5, -.10, 0.98, .8, .10}
        },
        collision_box = {
            type = "fixed",
            fixed = {-0.98, -.5, -.10, 0.98, .8, .10}
        }
    }
)

register_tv_node(
    'ma_pops_furniture:lcd_tv_blast', 
    'HD TV', 
    'FM_lcd_tv.obj', 
    {
        {name='mp_flat_tv.png'},
        {name='mp_channel_blast.png', animation={type='vertical_frames', aspect_w=64, aspect_h=64, length=22}}
    }, 
    'mp_blast', 
    'ma_pops_furniture:lcd_tv_off', 
    14, 
    not_in_creative,
    {
        sounds = moditems.STONE_SOUNDS,
        selection_box = {
            type = "fixed",
            fixed = {-0.98, -.5, -.10, 0.98, .8, .10}
        },
        collision_box = {
            type = "fixed",
            fixed = {-0.98, -.5, -.10, 0.98, .8, .10}
        }
    }
)
