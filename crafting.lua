
-- craftitem materials and crafting recipes
-- (only if default and dye mods exist)

local S = minetest.get_translator("vehicles")

minetest.register_craftitem("vehicles:wheel", {
	description = S("Wheel"),
	inventory_image = "vehicles_wheel.png",
})

minetest.register_craftitem("vehicles:engine", {
	description = S("Engine"),
	inventory_image = "vehicles_engine.png",
})

minetest.register_craftitem("vehicles:body", {
	description = S("Car Body"),
	inventory_image = "vehicles_car_body.png",
})

minetest.register_craftitem("vehicles:armor", {
	description = S("Armor plating"),
	inventory_image = "vehicles_armor.png",
})

minetest.register_craftitem("vehicles:gun", {
	description = S("Vehicle Gun"),
	inventory_image = "vehicles_gun.png",
})

minetest.register_craftitem("vehicles:propeller", {
	description = S("Propeller"),
	inventory_image = "vehicles_propeller.png",
})

minetest.register_craftitem("vehicles:jet_engine", {
	description = S("Jet Engine"),
	inventory_image = "vehicles_jet_engine.png",
})

minetest.register_craft({
	output = "vehicles:propeller",
	recipe = {
		{"default:steel_ingot", "", ""},
		{"", "group:stick", ""},
		{"", "", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "vehicles:jet_engine",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "vehicles:propeller", "default:steel_ingot"},
		{"", "default:steel_ingot", ""}
	}
})

minetest.register_craft({
	output = "vehicles:armor",
	recipe = {
		{"", "default:gold_lump", ""},
		{"", "default:iron_lump", ""},
		{"", "default:copper_lump", ""}
	}
})

minetest.register_craft({
	output = "vehicles:gun",
	recipe = {
		{"", "vehicles:armor", ""},
		{"vehicles:armor", "default:coal_lump", "vehicles:armor"},
		{"", "default:steel_ingot", ""}
	}
})

minetest.register_craft({
	output = "vehicles:wheel",
	recipe = {
		{"", "default:coal_lump", ""},
		{"default:coal_lump", "default:steel_ingot", "default:coal_lump"},
		{"", "default:coal_lump", ""}
	}
})

minetest.register_craft({
	output = "vehicles:engine",
	recipe = {
		{"default:copper_ingot", "", "default:copper_ingot"},
		{"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"},
		{"", "default:steel_ingot", ""}
	}
})

minetest.register_craft({
	output = "vehicles:body",
	recipe = {
		{"", "default:glass", ""},
		{"default:glass", "default:steel_ingot", "default:glass"},
		{"", "", ""}
	}
})

minetest.register_craft({
	output = "vehicles:bullet_item 5",
	recipe = {
		{"default:coal_lump", "default:iron_lump",},
	}
})

minetest.register_craft({
	output = "vehicles:missile_2_item",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"", "default:torch", ""},
		{"default:stick", "default:coal_lump", "default:stick"}
	}
})

minetest.register_craft({
	output = "vehicles:masda_spawner",
	recipe = {
		{"", "dye:magenta", ""},
		{"", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:masda2_spawner",
	recipe = {
		{"", "dye:orange", ""},
		{"", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:ute_spawner",
	recipe = {
		{"", "dye:brown", ""},
		{"default:steel_ingot", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:ute2_spawner",
	recipe = {
		{"", "dye:white", ""},
		{"default:steel_ingot", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:nizzan2_spawner",
	recipe = {
		{"", "dye:green", ""},
		{"", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:nizzan_spawner",
	recipe = {
		{"", "dye:brown", ""},
		{"", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:astonmaaton_spawner",
	recipe = {
		{"", "dye:white", ""},
		{"", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:pooshe_spawner",
	recipe = {
		{"", "dye:red", ""},
		{"", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:pooshe2_spawner",
	recipe = {
		{"", "dye:yellow", ""},
		{"", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:lambogoni_spawner",
	recipe = {
		{"", "dye:grey", ""},
		{"", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:lambogoni2_spawner",
	recipe = {
		{"", "dye:yellow", ""},
		{"", "vehicles:body", "dye:grey"},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:fewawi_spawner",
	recipe = {
		{"", "dye:red", ""},
		{"", "vehicles:body", "default:glass"},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:fewawi2_spawner",
	recipe = {
		{"", "dye:blue", ""},
		{"", "vehicles:body", "default:glass"},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:tractor_spawner",
	recipe = {
		{"", "", ""},
		{"vehicles:engine", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:wheel", "farming:hoe_steel"}
	}
})

minetest.register_craft({
	output = "vehicles:musting_spawner",
	recipe = {
		{"", "dye:violet", ""},
		{"", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:musting2_spawner",
	recipe = {
		{"", "dye:blue", ""},
		{"", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:policecar_spawner",
	recipe = {
		{"", "dye:blue", "dye:red"},
		{"", "vehicles:body", ""},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:tank_spawner",
	recipe = {
		{"", "vehicles:gun", ""},
		{"vehicles:armor", "vehicles:engine", "vehicles:armor"},
		{"vehicles:wheel", "vehicles:wheel", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:tank2_spawner",
	recipe = {
		{"default:desert_sand", "vehicles:gun", ""},
		{"vehicles:armor", "vehicles:engine", "vehicles:armor"},
		{"vehicles:wheel", "vehicles:wheel", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:turret_spawner",
	recipe = {
		{"", "vehicles:gun", ""},
		{"vehicles:armor", "vehicles:engine", "vehicles:armor"},
	}
})

minetest.register_craft({
	output = "vehicles:jet_spawner",
	recipe = {
		{"", "vehicles:gun", ""},
		{"vehicles:jet_engine", "default:steel_ingot", "vehicles:jet_engine"},
		{"", "default:steel_ingot", ""}
	}
})

minetest.register_craft({
	output = "vehicles:plane_spawner",
	recipe = {
		{"", "vehicles:propeller", ""},
		{"default:steel_ingot", "vehicles:engine", "default:steel_ingot"},
		{"", "default:steel_ingot", ""}
	}
})

minetest.register_craft({
	output = "vehicles:helicopter_spawner",
	recipe = {
		{"", "vehicles:propeller", ""},
		{"vehicles:propeller", "vehicles:engine", "default:glass"},
		{"", "default:steel_ingot", ""}
	}
})

minetest.register_craft({
	output = "vehicles:apache_spawner",
	recipe = {
		{"", "vehicles:propeller", ""},
		{"vehicles:propeller", "vehicles:engine", "default:glass"},
		{"", "vehicles:armor", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "vehicles:lightcycle_spawner",
	recipe = {
		{"default:steel_ingot", "vehicles:engine", "dye:cyan"},
		{"vehicles:wheel", "default:steel_ingot", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:lightcycle2_spawner",
	recipe = {
		{"default:steel_ingot", "vehicles:engine", "dye:orange"},
		{"vehicles:wheel", "default:steel_ingot", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:boat_spawner",
	recipe = {
		{"", "", ""},
		{"default:steel_ingot", "vehicles:engine", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "vehicles:firetruck_spawner",
	recipe = {
		{"", "dye:red", ""},
		{"vehicles:body", "vehicles:engine", "vehicles:body"},
		{"vehicles:wheel", "default:steel_ingot", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:geep_spawner",
	recipe = {
		{"", "", ""},
		{"", "vehicles:engine", ""},
		{"vehicles:wheel", "vehicles:armor", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:ambulance_spawner",
	recipe = {
		{"", "", ""},
		{"vehicles:body", "vehicles:body", "dye:white"},
		{"vehicles:wheel", "vehicles:engine", "vehicles:wheel"}
	}
})

minetest.register_craft({
	output = "vehicles:assaultsuit_spawner",
	recipe = {
		{"vehicles:gun", "default:glass", "vehicles:armor"},
		{"", "vehicles:engine", ""},
		{"vehicles:armor", "", "vehicles:armor"}
	}
})


minetest.register_craft({
	output = "vehicles:backpack",
	recipe = {
		{"group:grass", "group:grass", "group:grass"},
		{"group:stick", "", "group:stick"},
		{"", "group:wood", ""}
	}
})