vehicles = {}

dofile(minetest.get_modpath("vehicles").."/api.lua")

--very laggy and buggy flight
-- minetest.register_globalstep(function(dtime)
	-- for _, player in ipairs(minetest.get_connected_players()) do
		-- local dir = player:get_look_dir();
		-- local pos = player:getpos();
		-- local ctrl = player:get_player_control();
		-- local pos1 = {x=pos.x+dir.x*1,y=pos.y+dir.y*1,z=pos.z+dir.z*1}
		-- if ctrl.up == true then
		-- player:moveto(pos1, false)
		-- else
		-- end
	-- end
-- end)

local step = 1.2

minetest.register_entity("vehicles:missile", {
	visual = "mesh",
	mesh = "missile.b3d",
	textures = {"vehicles_missile.png"},
	velocity = 15,
	acceleration = -5,
	damage = 2,
	collisionbox = {-1, -0.5, -1, 1, 0.5, 1},
	on_rightclick = function(self, clicker)
		clicker:set_attach(self.object, "", {x=0,y=0,z=0}, {x=0,y=1,z=0}) 
	end,
	on_step = function(self, obj, pos)
		minetest.after(10, function()
			self.object:remove()
		end)
		for _, player in ipairs(minetest.get_connected_players()) do
		--never tested with multiple players
		local dir = player:get_look_dir();
		local vec = {x=dir.x*16,y=dir.y*16,z=dir.z*16}
		local yaw = player:get_look_yaw();
		self.object:setyaw(yaw+math.pi/2)
		self.object:setvelocity(vec)
		end
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "vehicles:missile" and n ~= "vehicles:jet" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=1},
						}, nil)
						local pos = self.object:getpos()
						tnt.boom(pos, {damage_radius=5,radius=5,ignore_protection=false})
						self.object:remove()
					end
				end
			end
			
					for dx=-1,1 do
						for dy=-1,1 do
							for dz=-1,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "vehicles:missile" and n ~= "vehicles:jet" and n ~= "air" then
									local pos = self.object:getpos()
									tnt.boom(pos, {damage_radius=5,radius=5,ignore_protection=false})
									self.object:remove()
									return
								end
							end
						end
					end
	end,
})


minetest.register_craftitem("vehicles:miss", {
	description = "Missile",
	inventory_image = "vehicles_missile_inv.png"
})


minetest.register_entity("vehicles:missile_2", {
	visual = "mesh",
	mesh = "missile.b3d",
	textures = {"vehicles_missile.png"},
	velocity = 15,
	acceleration = -5,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)
		minetest.after(10, function()
			self.object:remove()
		end)
		local velo = self.object:getvelocity()
		if velo.y <= 1 and velo.y >= -1 then
			self.object:set_animation({x=1, y=1}, 5, 0)
		elseif velo.y <= -1 then
			self.object:set_animation({x=4, y=4}, 5, 0)
		elseif velo.y >= 1 then
			self.object:set_animation({x=2, y=2}, 5, 0)
		end
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "vehicles:missile_2" and n ~= "vehicles:tank" and n ~= "vehicles:jet" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=1},
						}, nil)
						self.object:remove()
					end
				end
			end
			
					for dx=-1,1 do
						for dy=-1,1 do
							for dz=-1,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "vehicles:missile_2" and n ~= "vehicles:tank" and n ~= "vehicles:jet" and n ~= "air" then
									local pos = self.object:getpos()
									tnt.boom(pos, {damage_radius=5,radius=5,ignore_protection=false})
									self.object:remove()
									return
								end
							end
						end
					end
	end,
})

minetest.register_entity("vehicles:water", {
	visual = "sprite",
	textures = {"vehicles_trans.png"},
	velocity = 15,
	acceleration = -5,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_activate = function(self)
		self.object:setacceleration({x=0, y=-1, z=0})
	end,
	on_step = function(self, obj, pos)
		minetest.after(5, function()
			self.object:remove()
		end)
		local pos = self.object:getpos()
	minetest.add_particlespawner({
		amount = 1,
		time = 1,
		minpos = {x=pos.x, y=pos.y, z=pos.z},
		maxpos = {x=pos.x, y=pos.y, z=pos.z},
		minvel = {x=0, y=0, z=0},
		maxvel = {x=0, y=-0.2, z=0},
		minacc = {x=0, y=-1, z=0},
		maxacc = {x=0, y=-1, z=0},
		minexptime = 1,
		maxexptime = 1,
		minsize = 4,
		maxsize = 5,
		collisiondetection = false,
		vertical = false,
		texture = "vehicles_water.png",
	})
	local node = minetest.env:get_node(pos).name
	if node == "fire:basic_flame" then
	minetest.remove_node(pos)
	end
	end
})

minetest.register_entity("vehicles:bullet", {
	visual = "sprite",
	textures = {"vehicles_bullet.png"},
	velocity = 15,
	acceleration = -5,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)
		minetest.after(10, function()
			self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "vehicles:bullet" and n ~= "vehicles:turret" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=0.5},
						}, nil)
						self.object:remove()
					end
				end
			end
			
					for dx=-1,1 do
						for dy=-1,1 do
							for dz=-1,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "vehicles:bullet" and n ~= "air" then
									self.object:remove()
									return
								end
							end
						end
					end
	end,
})

minetest.register_entity("vehicles:tank", {
	visual = "mesh",
	mesh = "tank.b3d",
	textures = {"vehicles_tank.png"},
	velocity = 15,
	acceleration = -5,
	owner = "",
	stepheight = 1.5,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, -0.6, -0.9, 1, 0.9, 0.9},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_punch = function(self, puncher)
		destroy(self, puncher, "vehicles:tank")
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive(self, dtime, 6, 0.5, true, "vehicles:missile_2", 1, nil, nil, false)
		return false
		end
		return true
	end,
})

minetest.register_entity("vehicles:turret", {
	visual = "mesh",
	mesh = "turret_gun.b3d",
	textures = {"vehicles_turret.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1.5,
	hp_max = 50,
	groups = {fleshy=3, level=5},
	physical = true,
	collisionbox = {-0.6, 0, -0.6, 0.6, 0.9, 0.6},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, true, {x=0, y=2, z=4})
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:turret")
	end,
	on_step = function(self, dtime)
	self.object:setvelocity({x=0, y=-1, z=0})
	if self.driver then
		object_turret(self, dtime, 1.5, "vehicles:bullet", 0.2)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:tank", "Tank", "vehicles_tank_inv.png")
register_vehicle_spawner("vehicles:turret", "Gun turret", "vehicles_turret_inv.png")

minetest.register_entity("vehicles:firetruck", {
	visual = "mesh",
	mesh = "firetruck.b3d",
	textures = {"vehicles_firetruck.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1.5,
	hp_max = 200,
	physical = true,
	collisionbox = {-1.1, 0, -1.1, 1.1, 1.9, 1.1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:firetruck")
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive(self, dtime, 7, 0.5, true, "vehicles:water", 0.2, nil, nil, false)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:firetruck", "Fire truck", "vehicles_firetruck_inv.png")

minetest.register_entity("vehicles:ute", {
	visual = "mesh",
	mesh = "ute.b3d",
	textures = {"vehicles_ute.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1.5,
	hp_max = 200,
	physical = true,
	collisionbox = {-1.4, 0, -1.4, 1.4, 1, 1.4},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif self.driver and clicker ~= self.driver and not self.rider then
		clicker:set_attach(self.object, "", {x=0, y=5, z=-5}, {x=0, y=0, z=0})
		self.rider = true
		elseif self.driver and clicker ~=self.driver and self.rider then
		clicker:set_detach()
		self.rider = false
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:ute")
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 14, 0.6, 6)
		local pos = self.object:getpos()
			minetest.add_particlespawner(
			15, --amount
			1, --time
			{x=pos.x, y=pos.y, z=pos.z}, --minpos
			{x=pos.x, y=pos.y, z=pos.z}, --maxpos
			{x=0, y=0, z=0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0,y=-0,z=-0}, --minacc
			{x=0,y=0,z=0}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			10, --minsize
			15, --maxsize
			false, --collisiondetection
			"vehicles_dust.png" --texture
		)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:ute", "Ute (dirty)", "vehicles_ute_inv.png")

minetest.register_entity("vehicles:ute2", {
	visual = "mesh",
	mesh = "ute.b3d",
	textures = {"vehicles_ute2.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1.5,
	hp_max = 200,
	physical = true,
	collisionbox = {-1.4, 0, -1.4, 1.4, 1, 1.4},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif self.driver and clicker ~= self.driver and not self.rider then
		clicker:set_attach(self.object, "", {x=0, y=5, z=-5}, {x=0, y=0, z=0})
		self.rider = true
		elseif self.driver and clicker ~=self.driver and self.rider then
		clicker:set_detach()
		self.rider = false
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:ute2")
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 14, 0.6, 6)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:ute2", "Ute (clean)", "vehicles_ute_inv.png")

minetest.register_entity("vehicles:astonmaaton", {
	visual = "mesh",
	mesh = "astonmaaton.b3d",
	textures = {"vehicles_astonmaaton.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = step,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:astonmaaton")
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 14, 0.8, 5)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:astonmaaton", "Aston Maaton (white)", "vehicles_astonmaaton_inv.png")

minetest.register_entity("vehicles:nizzan", {
	visual = "mesh",
	mesh = "nizzan.b3d",
	textures = {"vehicles_nizzan.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = step,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:nizzan")
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 14, 0.8, 5)
		local pos = self.object:getpos()
			minetest.add_particlespawner(
			15, --amount
			1, --time
			{x=pos.x, y=pos.y, z=pos.z}, --minpos
			{x=pos.x, y=pos.y, z=pos.z}, --maxpos
			{x=0, y=0, z=0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0,y=-0,z=-0}, --minacc
			{x=0,y=0,z=0}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			10, --minsize
			15, --maxsize
			false, --collisiondetection
			"vehicles_dust.png" --texture
		)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:nizzan", "Nizzan (brown)", "vehicles_nizzan_inv.png")

minetest.register_entity("vehicles:nizzan2", {
	visual = "mesh",
	mesh = "nizzan.b3d",
	textures = {"vehicles_nizzan2.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = step,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:nizzan2")
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 14, 0.8, 5)
		local pos = self.object:getpos()
			minetest.add_particlespawner(
			15, --amount
			1, --time
			{x=pos.x, y=pos.y, z=pos.z}, --minpos
			{x=pos.x, y=pos.y, z=pos.z}, --maxpos
			{x=0, y=0, z=0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0,y=-0,z=-0}, --minacc
			{x=0,y=0,z=0}, --maxacc
			0.2, --minexptime
			0.5, --maxexptime
			20, --minsize
			25, --maxsize
			false, --collisiondetection
			"vehicles_dust.png" --texture
		)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:nizzan2", "Nizzan (green)", "vehicles_nizzan_inv2.png")

minetest.register_entity("vehicles:lambogoni", {
	visual = "mesh",
	mesh = "lambogoni.b3d",
	textures = {"vehicles_lambogoni.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = step,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:lambogoni")
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 15, 0.8, 4)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:lambogoni", "Lambogoni (grey)", "vehicles_lambogoni_inv.png")

minetest.register_entity("vehicles:masda", {
	visual = "mesh",
	mesh = "masda.b3d",
	textures = {"vehicles_masda.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = step,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:masda")
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 15, 0.95, 4)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:masda", "Masda (pink)", "vehicles_masda_inv.png")

minetest.register_entity("vehicles:musting", {
	visual = "mesh",
	mesh = "musting.b3d",
	textures = {"vehicles_musting.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = step,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:musting")
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 15, 0.95, 4)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:musting", "Musting (purple)", "vehicles_musting_inv2.png")

minetest.register_entity("vehicles:musting2", {
	visual = "mesh",
	mesh = "musting.b3d",
	textures = {"vehicles_musting2.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = step,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:musting2")
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 15, 0.85, 4)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:musting2", "Musting (white)", "vehicles_musting_inv.png")

minetest.register_entity("vehicles:fewawi", {
	visual = "mesh",
	mesh = "fewawi.b3d",
	textures = {"vehicles_fewawi.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = step,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		local ctrl = clicker:get_player_control()
		if ctrl.sneak then
		if not self.lights then
		self.object:set_properties({textures = {"vehicles_fewawi_lights.png"},})
		self.lights = true
		else
		self.object:set_properties({textures = {"vehicles_fewawi.png"},})
		self.lights = false		
		end
		else
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:fewawi")
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 15, 0.95, 4)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:fewawi", "Fewawi (red)", "vehicles_fewawi_inv.png")

minetest.register_entity("vehicles:fewawi2", {
	visual = "mesh",
	mesh = "fewawi.b3d",
	textures = {"vehicles_fewawi2.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = step,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		local ctrl = clicker:get_player_control()
		if ctrl.sneak then
		if not self.lights then
		self.object:set_properties({textures = {"vehicles_fewawi_lights2.png"},})
		self.lights = true
		else
		self.object:set_properties({textures = {"vehicles_fewawi2.png"},})
		self.lights = false
		end
		else
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:fewawi2")
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 15, 0.95, 4)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:fewawi2", "Fewawi (blue)", "vehicles_fewawi_inv2.png")

minetest.register_entity("vehicles:pooshe", {
	visual = "mesh",
	mesh = "pooshe.b3d",
	textures = {"vehicles_pooshe.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = step,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:pooshe")
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 15, 0.95, 4)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:pooshe", "Pooshe (red)", "vehicles_pooshe_inv.png")

minetest.register_entity("vehicles:pooshe2", {
	visual = "mesh",
	mesh = "pooshe.b3d",
	textures = {"vehicles_pooshe2.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = step,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:pooshe2")
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 15, 0.95, 4)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:pooshe2", "Pooshe (yellow)", "vehicles_pooshe_inv2.png")

minetest.register_entity("vehicles:masda2", {
	visual = "mesh",
	mesh = "masda.b3d",
	textures = {"vehicles_masda2.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = step,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:masda2")
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 15, 0.85, 4)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:masda2", "Masda (orange)", "vehicles_masda_inv2.png")

minetest.register_entity("vehicles:boat", {
	visual = "mesh",
	mesh = "boat.b3d",
	textures = {"vehicles_boat.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0.2, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:boat")
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_float(self, dtime, 10, 0.85)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:boat", "Speedboat", "vehicles_boat_inv.png", true)


minetest.register_entity("vehicles:jet", {
	visual = "mesh",
	mesh = "jet.b3d",
	textures = {"vehicles_jet.png"},
	velocity = 15,
	acceleration = -5,
	hp_max = 200,
	animation_speed = 5,
	physical = true,
	animations = {
      gear = {x=1, y=1},
      nogear = {x=10, y=10},
	},
	collisionbox = {-1, -0.9, -0.9, 1, 0.9, 0.9},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=5}, false, {x=0, y=3, z=4})
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:jet")
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 14, 0.2, 0.95, true, "vehicles:missile_2", 1, {x=1, y=1}, {x=10, y=10})
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:jet", "Jet", "vehicles_jet_inv.png")

minetest.register_entity("vehicles:plane", {
	visual = "mesh",
	mesh = "plane.b3d",
	textures = {"vehicles_plane.png"},
	velocity = 15,
	acceleration = -5,
	hp_max = 200,
	animation_speed = 5,
	physical = true,
	animations = {
      fly = { x=1, y=9},
      nofly = { x=1, y=1},
	},
	collisionbox = {-1.1, 0, -1, 1, 1.9, 1.1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=8, z=3}, false, {x=0, y=9, z=0})
		end
	end,
	on_punch = function(self, puncher)
		vehicle_drop(self, puncher, "vehicles:plane")
	end,
	on_step = function(self, dtime)
	if self.anim and not self.driver then 
	self.object:set_animation({x=1, y=1}, 5, 0)
	end
	if self.driver then
		object_fly(self, dtime, 10, 0.1, 0.95, false, nil, "nofly", "fly")
		if not self.anim then
		self.object:set_animation({x=1, y=9}, 20, 0)
		self.anim = true
		end
		return false
		else
		self.anim = false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:plane", "Plane", "vehicles_plane_inv.png")

minetest.register_entity("vehicles:parachute", {
	visual = "mesh",
	mesh = "parachute.b3d",
	textures = {"vehicles_parachute.png"},
	velocity = 15,
	acceleration = -5,
	hp_max = 2,
	physical = true,
	collisionbox = {-0.5, -1, -0.5, 0.5, 1, 0.5},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=0, z=-1.5}, {x=0, y=-4, z=0})
		end
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_glide(self, dtime, 8, 0.92, -0.2, "", "")
		return false
		end
		return true
	end,
})

minetest.register_tool("vehicles:backpack", {
	description = "Parachute",
	inventory_image = "vehicles_backpack.png",
	wield_scale = {x = 1.5, y = 1.5, z = 1},
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=1},
	},
	on_use = function(item, placer, pointed_thing)
			local dir = placer:get_look_dir();
			local playerpos = placer:getpos();
			local pname = placer:get_player_name();
			local obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+1+dir.y,z=playerpos.z+0+dir.z}, "vehicles:parachute")
			local entity = obj:get_luaentity()
			if obj.driver and placer == obj.driver then
			object_detach(entity, placer, {x=1, y=0, z=1})
			elseif not obj.driver then
			object_attach(entity, placer, {x=0, y=0, z=0}, {x=0, y=2, z=0})
			end
			item:take_item()
			return item
	end,
})


--wings
--currently doesn't work very well
minetest.register_entity("vehicles:wing_glider", {
	visual = "mesh",
	mesh = "wings.b3d",
	textures = {"vehicles_wings.png"},
	velocity = 15,
	acceleration = -5,
	hp_max = 2,
	physical = true,
	collisionbox = {-0.5, -0.1, -0.5, 0.5, 0.1, 0.5},
	on_step = function(self, dtime)
	if self.driver then
		local dir = self.driver:get_look_dir();
		local velo = self.object:getvelocity();
		local vec = {x=dir.x*5,y=(-dir.y*2*velo.y/4-2.5)+dir.y*3,z=dir.z*5}
		local yaw = self.driver:get_look_yaw();
		self.object:setyaw(yaw+math.pi/2)
		self.object:setvelocity(vec)
		self.driver:set_animation({x=162, y=167}, 0, 0)
		return false
		end
		return true
	end,
})

minetest.register_tool("vehicles:wings", {
	description = "Wings",
	inventory_image = "vehicles_backpack.png",
	wield_scale = {x = 1.5, y = 1.5, z = 1},
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=1},
	},
	on_use = function(item, placer, pointed_thing)
			local dir = placer:get_look_dir();
			local playerpos = placer:getpos();
			local objs = minetest.get_objects_inside_radius({x=playerpos.x,y=playerpos.y,z=playerpos.z}, 2)	
			for k, obj2 in pairs(objs) do
				if obj2:get_luaentity() ~= nil then
					if obj2:get_luaentity().name == "vehicles:wings" then
					local wings = false
					end
					end
					end
			if wings then
			object_detach(obj2:get_luaentity(), placer, {x=1, y=0, z=1})
			placer:set_properties({
			visual_size = {x=1, y=1},
			})
			else
			local obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+1+dir.y,z=playerpos.z+0+dir.z}, "vehicles:wing_glider")
			local entity = obj:get_luaentity()
			placer:set_attach(entity.object, "", {x=0,y=-5,z=0}, {x=0,y=0,z=0})
			entity.driver = placer
			placer:set_properties({
			visual_size = {x=1, y=-1},
			})
			end
			item:add_wear(500)
			return item
	end,
})

minetest.register_tool("vehicles:rc", {
	description = "Rc",
	inventory_image = "vehicles_rc.png",
	wield_scale = {x = 1.5, y = 1.5, z = 1},
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=1},
	},
	on_use = function(item, placer, pointed_thing)
			local dir = placer:get_look_dir();
			local playerpos = placer:getpos();
			local pname = placer:get_player_name();
			local inv = minetest.get_inventory({type="player", name=pname});
			if inv:contains_item("main", "vehicles:miss") then
			local remov = inv:remove_item("main", "vehicles:miss")
			local obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+1+dir.y,z=playerpos.z+0+dir.z}, "vehicles:missile")
			local vec = {x=dir.x*6,y=dir.y*6,z=dir.z*6}
			obj:setvelocity(vec)
			return item
		end
	end,
})

--decorative nodes

function vehicles.register_simplenode(name, desc, texture, light)
minetest.register_node("vehicles:"..name, {
	description = desc,
	tiles = {texture},
	groups = {cracky=1},
	paramtype2 = "facedir",
	light_source = light,
})
end

vehicles.register_simplenode("road", "Road surface", "vehicles_road.png", 0)
vehicles.register_simplenode("concrete", "Concrete", "vehicles_concrete.png", 0)
vehicles.register_simplenode("arrows", "Turning Arrows(left)", "vehicles_arrows.png", 10)
vehicles.register_simplenode("arrows_flp", "Turning Arrows(right)", "vehicles_arrows_flp.png", 10)
vehicles.register_simplenode("checker", "Checkered surface", "vehicles_checker.png", 0)
vehicles.register_simplenode("stripe", "Road surface (stripe)", "vehicles_road_stripe.png", 0)
vehicles.register_simplenode("stripe2", "Road surface (double stripe)", "vehicles_road_stripe2.png", 0)
vehicles.register_simplenode("stripe3", "Road surface (white stripes)", "vehicles_road_stripes3.png", 0)
vehicles.register_simplenode("stripe4", "Road surface (yellow stripes)", "vehicles_road_stripe4.png", 0)
vehicles.register_simplenode("window", "Building glass", "vehicles_window.png", 0)
vehicles.register_simplenode("stripes", "Hazard stipes", "vehicles_stripes.png", 10)
vehicles.register_simplenode("lights", "Tunnel lights", "vehicles_lights.png", 20)

stairs.register_stair_and_slab("road_surface", "vehicles:road",
		{cracky = 1},
		{"vehicles_road.png"},
		"Road Surface Stair",
		"Road Surface Slab",
		default.node_sound_stone_defaults())

minetest.register_node("vehicles:neon_arrow", {
	description = "neon arrows (left)",
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {{
		name = "vehicles_neon_arrow.png",
		animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.00},
	}},
	inventory_image = "vehicles_neon_arrow_inv.png",
	weild_image = "vehicles_neon_arrow_inv.png",
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
})

minetest.register_node("vehicles:neon_arrow_flp", {
	description = "neon arrows (right)",
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {{
		name = "vehicles_neon_arrow.png^[transformFX",
		animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.00},
	}},
	inventory_image = "vehicles_neon_arrow_inv.png^[transformFX",
	weild_image = "vehicles_neon_arrow_inv.png^[transformFX",
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
})

minetest.register_node("vehicles:add_arrow", {
	description = "arrows(left)",
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {"vehicles_arrows.png"},
	inventory_image = "vehicles_arrows.png",
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
})

minetest.register_node("vehicles:add_arrow_flp", {
	description = "arrows(right)",
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {"vehicles_arrows_flp.png"},
	inventory_image = "vehicles_arrows_flp.png",
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
})

minetest.register_node("vehicles:scifi_ad", {
	description = "scifi_nodes sign",
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {{
		name = "vehicles_scifinodes.png",
		animation = {type = "vertical_frames", aspect_w = 58, aspect_h = 58, length = 1.00},
	}},
	inventory_image = "vehicles_scifinodes_inv.png",
	weild_image = "vehicles_scifinodes_inv.png",
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
})

minetest.register_node("vehicles:mt_sign", {
	description = "mt sign",
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {"vehicles_neonmt.png",},
	inventory_image = "vehicles_neonmt.png",
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
})

minetest.register_node("vehicles:pacman_sign", {
	description = "pacman sign",
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {"vehicles_pacman.png",},
	inventory_image = "vehicles_pacman.png",
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
})

minetest.register_node("vehicles:whee_sign", {
	description = "whee sign",
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {"vehicles_whee.png",},
	inventory_image = "vehicles_whee.png",
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
})

minetest.register_node("vehicles:checker_sign", {
	description = "Checkered sign",
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {"vehicles_checker2.png",},
	inventory_image = "vehicles_checker2.png",
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
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("vehicles:car_sign", {
	description = "Car sign",
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {"vehicles_sign1.png",},
	inventory_image = "vehicles_sign1.png",
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
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("vehicles:nyan_sign", {
	description = "Nyancat sign",
	drawtype = "signlike",
	visual_scale = 2.0,
	tiles = {"vehicles_sign2.png",},
	inventory_image = "vehicles_sign2.png",
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
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("vehicles:flag", {
	description = "Flag",
	drawtype = "torchlike",
	visual_scale = 3.0,
	tiles = {"vehicles_flag.png",},
	inventory_image = "vehicles_flag.png",
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
	groups = {cracky=3,dig_immediate=3},
})


minetest.register_node("vehicles:tyres", {
	description = "tyre stack",
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
	groups = {cracky=1},
})



