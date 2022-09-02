
--decorative nodes

local S = minetest.get_translator("vehicles")

local stone_sound = {}
if minetest.global_exists("default") then
	stone_sound = default.node_sound_stone_defaults()
elseif minetest.global_exists("sounds") then
	stone_sound = sounds.node_stone()
end

function vehicles.register_simplenode(name, desc, texture, light)
	minetest.register_node("vehicles:"..name, {
		description = desc,
		tiles = {texture},
		groups = {cracky=1},
		paramtype2 = "facedir",
		light_source = light,
		sound = stone_sound,
	})
end--function vehicles.register_simplenode(name, desc, texture, light)

vehicles.register_simplenode("road", S("Road surface"), "vehicles_road.png", 0)
vehicles.register_simplenode("concrete", S("Concrete"), "vehicles_concrete.png", 0)
vehicles.register_simplenode("arrows", S("Turning Arrows(left)"), "vehicles_arrows.png", 10)
vehicles.register_simplenode("arrows_flp", S("Turning Arrows(right)"), "vehicles_arrows.png^[transformFX", 10)
vehicles.register_simplenode("checker", S("Checkered surface"), "vehicles_checker.png", 0)
vehicles.register_simplenode("stripe", S("Road surface (stripe)"), "vehicles_road_stripe.png", 0)
vehicles.register_simplenode("stripe2", S("Road surface (double stripe)"), "vehicles_road_stripe2.png", 0)
vehicles.register_simplenode("stripe3", S("Road surface (white stripes)"), "vehicles_road_stripes3.png", 0)
vehicles.register_simplenode("stripe4", S("Road surface (yellow stripes)"), "vehicles_road_stripe4.png", 0)
vehicles.register_simplenode("window", S("Building glass"), "vehicles_window.png", 0)
vehicles.register_simplenode("stripes", S("Hazard stipes"), "vehicles_stripes.png", 10)

minetest.register_node("vehicles:lights", {
	description = S("Tunnel Lights"),
	tiles = {"vehicles_lights_top.png", "vehicles_lights_top.png", "vehicles_lights.png", "vehicles_lights.png", "vehicles_lights.png", "vehicles_lights.png"},
	groups = {cracky=1},
	paramtype2 = "facedir",
	light_source = 14,
})

if minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab("road_surface", "vehicles:road",
		{cracky = 1},
		{"vehicles_road.png"},
		S("Road Surface Stair"),
		S("Road Surface Slab"),
		stone_sound)
end

minetest.register_node("vehicles:neon_arrow", {
	description = S("neon arrows (left)"),
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {{
		name = "vehicles_neon_arrow.png",
		animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.00},
	}},
	inventory_image = "vehicles_neon_arrow_inv.png",
	weild_image = "vehicles_neon_arrow_inv.png",
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("vehicles:neon_arrow_flp", {
	description = S("neon arrows (right)"),
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {{
		name = "vehicles_neon_arrow.png^[transformFX",
		animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.00},
	}},
	inventory_image = "vehicles_neon_arrow_inv.png^[transformFX",
	weild_image = "vehicles_neon_arrow_inv.png^[transformFX",
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("vehicles:add_arrow", {
	description = S("arrows(left)"),
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {"vehicles_arrows.png"},
	inventory_image = "vehicles_arrows.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("vehicles:add_arrow_flp", {
	description = S("arrows(right)"),
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {"vehicles_arrows.png^[transformFX"},
	inventory_image = "vehicles_arrows.png^[transformFX",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("vehicles:scifi_ad", {
	description = S("scifi_nodes sign"),
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {{
		name = "vehicles_scifinodes.png",
		animation = {type = "vertical_frames", aspect_w = 58, aspect_h = 58, length = 1.00},
	}},
	inventory_image = "vehicles_scifinodes_inv.png",
	weild_image = "vehicles_scifinodes_inv.png",
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("vehicles:mt_sign", {
	description = S("mt sign"),
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {"vehicles_neonmt.png",},
	inventory_image = "vehicles_neonmt.png",
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("vehicles:pacman_sign", {
	description = S("pacman sign"),
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {"vehicles_pacman.png",},
	inventory_image = "vehicles_pacman.png",
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("vehicles:whee_sign", {
	description = S("whee sign"),
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {"vehicles_whee.png",},
	inventory_image = "vehicles_whee.png",
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("vehicles:checker_sign", {
	description = S("Checkered sign"),
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {"vehicles_checker2.png",},
	inventory_image = "vehicles_checker2.png",
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 5,
	is_ground_content = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("vehicles:car_sign", {
	description = S("Car sign"),
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {"vehicles_sign1.png",},
	inventory_image = "vehicles_sign1.png",
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 5,
	is_ground_content = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("vehicles:nyan_sign", {
	description = S("Nyancat sign"),
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {"vehicles_sign2.png",},
	inventory_image = "vehicles_sign2.png",
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 5,
	is_ground_content = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("vehicles:flag", {
	description = S("Flag"),
	drawtype = "torchlike",
	visual_scale = 3.0,
	tiles = {"vehicles_flag.png",},
	inventory_image = "vehicles_flag.png",
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 5,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
})


minetest.register_node("vehicles:tyres", {
	description = S("tyre stack"),
	tiles = {
		"vehicles_tyre.png",
		"vehicles_tyre.png",
		"vehicles_tyre_side.png",
		"vehicles_tyre_side.png",
		"vehicles_tyre_side.png",
		"vehicles_tyre_side.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, 0.5, 0.4375}, -- NodeBox1
			{-0.5, -0.4375, -0.4375, 0.5, -0.0625, 0.4375}, -- NodeBox2
			{-0.5, 0, -0.4375, 0.5, 0.4375, 0.4375}, -- NodeBox3
			{-0.4375, 0, -0.5, 0.4375, 0.4375, 0.5}, -- NodeBox4
			{-0.4375, -0.4375, -0.5, 0.4375, -0.0625, 0.5}, -- NodeBox5
		}
	},
	groups = {cracky=1, falling_node=1},
})

--nodeboxes from xpanes
--[[
(MIT)
Copyright (C) 2014-2016 xyz
Copyright (C) 2014-2016 BlockMen
Copyright (C) 2016 Auke Kok <sofar@foo-projects.org>
Copyright (C) 2014-2016 Various Minetest developers
]]

minetest.register_node("vehicles:light_barrier", {
	description = S("Light Barrier"),
	tiles = {
		"vehicles_lightblock.png^[transformR90",
		"vehicles_lightblock.png^[transformR90",
		"vehicles_lightblock.png",
	},
	use_texture_alpha = "blend",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "connected",
		fixed = {{-1/32, -1/2, -1/32, 1/32, 1/2, 1/32}},
		connect_front = {{-1/32, -1/2, -1/2, 1/32, 1/2, -1/32}},
		connect_left = {{-1/2, -1/2, -1/32, -1/32, 1/2, 1/32}},
		connect_back = {{-1/32, -1/2, 1/32, 1/32, 1/2, 1/2}},
		connect_right = {{1/32, -1/2, -1/32, 1/2, 1/2, 1/32}},
	},
	connects_to = {"vehicles:light_barrier",},
	sunlight_propagates = true,
	walkable = false,
	light_source = 9,
	groups = {cracky=3,dig_immediate=3,not_in_creative_inventory=1},
	on_construct = function(pos, node)
		minetest.get_node_timer(pos):start(4)
		return
	end,
	on_timer = function(pos, elapsed)
		minetest.remove_node(pos)
	end,
})

minetest.register_node("vehicles:light_barrier2", {
	description = S("Light Barrier 2"),
	tiles = {
		"vehicles_lightblock2.png^[transformR90",
		"vehicles_lightblock2.png^[transformR90",
		"vehicles_lightblock2.png",
	},
	use_texture_alpha = "blend",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "connected",
		fixed = {{-1/32, -1/2, -1/32, 1/32, 1/2, 1/32}},
		connect_front = {{-1/32, -1/2, -1/2, 1/32, 1/2, -1/32}},
		connect_left = {{-1/2, -1/2, -1/32, -1/32, 1/2, 1/32}},
		connect_back = {{-1/32, -1/2, 1/32, 1/32, 1/2, 1/2}},
		connect_right = {{1/32, -1/2, -1/32, 1/2, 1/2, 1/32}},
	},
	connects_to = {"vehicles:light_barrier2",},
	sunlight_propagates = true,
	walkable = false,
	light_source = 9,
	groups = {cracky=3,dig_immediate=3,not_in_creative_inventory=1},
	on_construct = function(pos, node)
		minetest.get_node_timer(pos):start(4)
		return
	end,
	on_timer = function(pos, elapsed)
		minetest.remove_node(pos)
	end,
})