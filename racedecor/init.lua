local snd_stone, snd_glass
if minetest.get_modpath("default") then
	snd_stone = default.node_sound_stone_defaults()
	snd_glass = default.node_sound_glass_defaults()
	snd_default = default.node_sound_defaults()
	snd_paper = default.node_sound_leaves_defaults()
	snd_tyre = default.node_sound_defaults({
		footstep = {name = "default_dirt_footstep", gain = 0.5},
	})
end

--decorative nodes
minetest.register_node("racedecor:road", {
	description = "Road surface",
	tiles = {"racedecor_road.png"},
	groups = {cracky=3},
	sounds = snd_stone,
	is_ground_content = false,
})
minetest.register_node("racedecor:concrete", {
	description = "Concrete",
	tiles = {"racedecor_concrete.png"},
	groups = {cracky=3},
	sounds = snd_stone,
	is_ground_content = false,
})
minetest.register_node("racedecor:arrows", {
	description = "Turning arrows block (left)",
	tiles = {"racedecor_arrows_top.png", "racedecor_arrows_top.png", "racedecor_arrows.png", "racedecor_arrows.png", "racedecor_arrows.png", "racedecor_arrows.png"},
	groups = {cracky=3},
	sounds = snd_stone,
	light_source = 10,
	is_ground_content = false,
})
minetest.register_node("racedecor:arrows_flp", {
	description = "Turning arrows block (right)",
	tiles = {"racedecor_arrows_top.png", "racedecor_arrows_top.png", "racedecor_arrows_flp.png", "racedecor_arrows_flp.png", "racedecor_arrows_flp.png", "racedecor_arrows_flp.png"},
	groups = {cracky=3},
	sounds = snd_stone,
	light_source = 10,
	is_ground_content = false,
})
minetest.register_node("racedecor:checker", {
	description = "Checkered surface",
	tiles = {"racedecor_checker.png", "racedecor_road.png"},
	groups = {cracky=3},
	sounds = snd_stone,
	is_ground_content = false,
})
minetest.register_node("racedecor:stripe", {
	description = "Road surface (white stripe)",
	tiles = {"racedecor_road_stripe.png", "racedecor_road.png"},
	groups = {cracky=3},
	sounds = snd_stone,
	paramtype2 = "facedir",
	is_ground_content = false,
})
minetest.register_node("racedecor:stripe2", {
	description = "Road surface (double yellow stripe)",
	tiles = {"racedecor_road_stripe2.png", "racedecor_road.png"},
	groups = {cracky=3},
	sounds = snd_stone,
	paramtype2 = "facedir",
	is_ground_content = false,
})
minetest.register_node("racedecor:stripe3", {
	description = "Road surface (white safety stripes)",
	tiles = {"racedecor_road_stripes3.png", "racedecor_road.png"},
	groups = {cracky=3},
	sounds = snd_stone,
	paramtype2 = "facedir",
	is_ground_content = false,
})
minetest.register_node("racedecor:stripe4", {
	description = "Road surface (yellow safety stripes)",
	tiles = {"racedecor_road_stripe4.png", "racedecor_road.png"},
	groups = {cracky=3},
	sounds = snd_stone,
	paramtype2 = "facedir",
	is_ground_content = false,
})
minetest.register_node("racedecor:window", {
	description = "Building glass",
	tiles = {"racedecor_window.png"},
	groups = {cracky=3},
	sounds = snd_glass,
	is_ground_content = false,
})
minetest.register_node("racedecor:stripes", {
	description = "Hazard stripes",
	tiles = {"racedecor_stripes.png", "racedecor_road.png"},
	groups = {cracky=3},
	sounds = snd_stone,
	paramtype2 = "facedir",
	is_ground_content = false,
})
minetest.register_node("racedecor:lights", {
	description = "Tunnel lights",
	tiles = {"racedecor_lights.png"},
	groups = {cracky=3},
	sounds = snd_glass,
	is_ground_content = false,
})

if minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab("road_surface", "racedecor:road",
		{cracky = 3},
		{"racedecor_road.png"},
		"Road Surface Stair",
		"Road Surface Slab",
		snd_stone)
end

minetest.register_node("racedecor:neon_arrow", {
	description = "Neon arrows (left)",
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {{
		name = "racedecor_neon_arrow.png",
		animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.00},
	}},
	inventory_image = "racedecor_neon_arrow_inv.png",
	wield_image = "racedecor_neon_arrow_inv.png",
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,	
	light_source = 50,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
	sounds = snd_default,
})

minetest.register_node("racedecor:neon_arrow_flp", {
	description = "Neon arrows (right)",
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {{
		name = "racedecor_neon_arrow.png^[transformFX",
		animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.00},
	}},
	inventory_image = "racedecor_neon_arrow_inv.png^[transformFX",
	wield_image = "racedecor_neon_arrow_inv.png^[transformFX",
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,	
	light_source = 50,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
	sounds = snd_default,
})

minetest.register_node("racedecor:add_arrow", {
	description = "Turning arrows sign (left)",
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {"racedecor_arrows.png"},
	inventory_image = "racedecor_arrows.png",
	wield_image = "racedecor_arrows.png",
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,	
	light_source = 50,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
	sounds = snd_default,
})

minetest.register_node("racedecor:add_arrow_flp", {
	description = "Turning arrows sign (right)",
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {"racedecor_arrows_flp.png"},
	inventory_image = "racedecor_arrows_flp.png",
	wield_image = "racedecor_arrows_flp.png",
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,	
	light_source = 50,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
	sounds = snd_default,
})

minetest.register_node("racedecor:scifi_ad", {
	description = "Neon sign “SCIFI_NODES”",
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {{
		name = "racedecor_scifinodes.png",
		animation = {type = "vertical_frames", aspect_w = 58, aspect_h = 58, length = 1.00},
	}},
	inventory_image = "racedecor_scifinodes_inv.png",
	wield_image = "racedecor_scifinodes_inv.png",
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,	
	light_source = 50,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
	sounds = snd_default,
})

minetest.register_node("racedecor:mt_sign", {
	description = "Neon sign “MT”",
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {"racedecor_neonmt.png",},
	inventory_image = "racedecor_neonmt.png",
	wield_image = "racedecor_neonmt.png",
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,	
	light_source = 50,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
	sounds = snd_default,
})

minetest.register_node("racedecor:pacman_sign", {
	description = "Neon pacman sign",
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {"racedecor_pacman.png",},
	inventory_image = "racedecor_pacman.png",
	wield_image = "racedecor_pacman.png",
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,	
	light_source = 50,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
	sounds = snd_default,
})

minetest.register_node("racedecor:whee_sign", {
	description = "Neon sign “WHEEE”",
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {"racedecor_whee.png",},
	inventory_image = "racedecor_whee.png",
	wield_image = "racedecor_whee.png",
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,	
	light_source = 50,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	groups = {cracky=3,dig_immediate=3},
	sounds = snd_default,
})

minetest.register_node("racedecor:checker_sign", {
	description = "Checkered sign",
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {"racedecor_checker2.png",},
	inventory_image = "racedecor_checker2.png",
	wield_image = "racedecor_checker2.png",
	use_texture_alpha = true,
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
	groups = {snappy=3,dig_immediate=3},
	sounds = snd_default,
})

minetest.register_node("racedecor:car_sign", {
	description = "Car racing poster",
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {"racedecor_sign1.png",},
	inventory_image = "racedecor_sign1.png",
	wield_image = "racedecor_sign1.png",
	use_texture_alpha = true,
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
	groups = {snappy=3,dig_immediate=3},
	sounds = snd_default,
})

minetest.register_node("racedecor:nyan_sign", {
	description = "Nyan Cat poster",
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {"racedecor_sign2.png",},
	inventory_image = "racedecor_sign2.png",
	wield_image = "racedecor_sign2.png",
	use_texture_alpha = true,
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
	groups = {snappy=3,dig_immediate=3},
	sounds = snd_paper,
})

minetest.register_node("racedecor:flag", {
	description = "Checkered flag",
	drawtype = "torchlike",
	visual_scale = 3.0,
	tiles = {"racedecor_flag.png",},
	inventory_image = "racedecor_flag.png",
	wield_image = "racedecor_flag.png",
	use_texture_alpha = true,
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
	groups = {snappy=3,dig_immediate=3},
	sounds = snd_default,
})

minetest.register_node("racedecor:tyres", {
	description = "Tyre stack",
	tiles = {
		"racedecor_tyre.png",
		"racedecor_tyre.png",
		"racedecor_tyre_side.png",
		"racedecor_tyre_side.png",
		"racedecor_tyre_side.png",
		"racedecor_tyre_side.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, 0.5, 0.4375},
			{-0.5, -0.4375, -0.4375, 0.5, -0.0625, 0.4375},
			{-0.5, 0, -0.4375, 0.5, 0.4375, 0.4375},
			{-0.4375, 0, -0.5, 0.4375, 0.4375, 0.5},
			{-0.4375, -0.4375, -0.5, 0.4375, -0.0625, 0.5},
		}
	},
	groups = {choppy=2, snappy=1, dig_immediate=2, falling_node=1},
	sounds = snd_tyre,
})

-- Legacy aliases
minetest.register_alias("vehicles:road", "racedecor:road")
minetest.register_alias("vehicles:concrete", "racedecor:concrete")
minetest.register_alias("vehicles:arrows", "racedecor:arrows")
minetest.register_alias("vehicles:arrows_flp", "racedecor:arrows_flp")
minetest.register_alias("vehicles:checker", "racedecor:checker")
minetest.register_alias("vehicles:stripe", "racedecor:stripe")
minetest.register_alias("vehicles:stripe2", "racedecor:stripe2")
minetest.register_alias("vehicles:stripe3", "racedecor:stripe3")
minetest.register_alias("vehicles:stripe4", "racedecor:stripe4")
minetest.register_alias("vehicles:window", "racedecor:window")
minetest.register_alias("vehicles:stripes", "racedecor:stripes")
minetest.register_alias("vehicles:neon_arrow", "racedecor:neon_arrow")
minetest.register_alias("vehicles:neon_arrow_flp", "racedecor:neon_arrow_flp")
minetest.register_alias("vehicles:add_arrow", "racedecor:add_arrow")
minetest.register_alias("vehicles:add_arrow_flp", "racedecor:add_arrow_flp")
minetest.register_alias("vehicles:scifi_ad", "racedecor:scifi_ad")
minetest.register_alias("vehicles:mt_sign", "racedecor:mt_sign")
minetest.register_alias("vehicles:pacman_sign", "racedecor:pacman_sign")
minetest.register_alias("vehicles:whee_sign", "racedecor:whee_sign")
minetest.register_alias("vehicles:checker_sign", "racedecor:checker_sign")
minetest.register_alias("vehicles:car_sign", "racedecor:car_sign")
minetest.register_alias("vehicles:nyan_sign", "racedecor:nyan_sign")
minetest.register_alias("vehicles:tyres", "racedecor:tyres")
