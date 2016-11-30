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

local step = 1.1

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
		local vec = self.object:getvelocity()
		minetest.add_particlespawner({
		amount = 1,
		time = 0.5,
		minpos = {x=pos.x-0.2, y=pos.y, z=pos.z-0.2},
		maxpos = {x=pos.x+0.2, y=pos.y, z=pos.z+0.2},
		minvel = {x=-vec.x/2, y=-vec.y/2, z=-vec.z/2},
		maxvel = {x=-vec.x, y=-vec.y, z=-vec.z},
		minacc = {x=0, y=-1, z=0},
		maxacc = {x=0, y=-1, z=0},
		minexptime = 0.2,
		maxexptime = 0.6,
		minsize = 3,
		maxsize = 4,
		collisiondetection = false,
		texture = "vehicles_smoke.png",
	})
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


minetest.register_craftitem("vehicles:missile_2_item", {
	description = "Missile",
	inventory_image = "vehicles_missile_inv.png"
})

minetest.register_craftitem("vehicles:bullet_item", {
	description = "Bullet",
	inventory_image = "vehicles_bullet_inv.png"
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
		if velo.y <= 1.2 and velo.y >= -1.2 then
			self.object:set_animation({x=1, y=1}, 5, 0)
		elseif velo.y <= -1.2 then
			self.object:set_animation({x=4, y=4}, 5, 0)
		elseif velo.y >= 1.2 then
			self.object:set_animation({x=2, y=2}, 5, 0)
		end
		local pos = self.object:getpos()
		minetest.add_particlespawner({
		amount = 2,
		time = 0.5,
		minpos = {x=pos.x-0.2, y=pos.y, z=pos.z-0.2},
		maxpos = {x=pos.x+0.2, y=pos.y, z=pos.z+0.2},
		minvel = {x=-velo.x/2, y=-velo.y/2, z=-velo.z/2},
		maxvel = {x=-velo.x, y=-velo.y, z=-velo.z},
		minacc = {x=0, y=-1, z=0},
		maxacc = {x=0, y=-1, z=0},
		minexptime = 0.2,
		maxexptime = 0.6,
		minsize = 3,
		maxsize = 4,
		collisiondetection = false,
		texture = "vehicles_smoke.png",
	})
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "vehicles:missile_2" and n ~= "vehicles:tank" and n ~= "vehicles:jet" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.launcher, 1.0, {
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
									minetest.add_particlespawner({
			amount = 30,
			time = 0.5,
			minpos = {x=pos.x-0.5, y=pos.y-0.5, z=pos.z-0.5},
			maxpos = {x=pos.x+0.5, y=pos.y+0.5, z=pos.z+0.5},
			minvel = {x=-1, y=-1, z=-1},
			maxvel = {x=1, y=1, z=1},
			minacc = {x=0, y=0.2, z=0},
			maxacc = {x=0, y=0.6, z=0},
			minexptime = 0.5,
			maxexptime = 1,
			minsize = 10,
			maxsize = 20,
			collisiondetection = false,
			texture = "vehicles_explosion.png"
		})
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
	visual = "mesh",
	mesh = "bullet.b3d",
	textures = {"vehicles_bullet.png"},
	velocity = 15,
	acceleration = -5,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_activate = function(self)
		local pos = self.object:getpos()
		minetest.sound_play("shot", 
		{gain = 0.4, max_hear_distance = 3, loop = false})
	end,
	on_step = function(self, obj, pos)
		minetest.after(10, function()
			self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "vehicles:bullet" and n ~= "vehicles:turret" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.launcher, 1.0, {
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
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive(self, dtime, 6, 0.5, true, "vehicles:missile_2", 1, {x=1, y=1}, {x=1, y=1}, false, nil, {x=1, y=1})
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
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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

minetest.register_entity("vehicles:assaultsuit", {
	visual = "mesh",
	mesh = "assaultsuit.b3d",
	textures = {"vehicles_assaultsuit.png"},
	velocity = 15,
	acceleration = -5,
	owner = "",
	stepheight = 1.5,
	hp_max = 200,
	physical = true,
	collisionbox = {-0.8, 0, -0.8, 0.8, 3, 0.8},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=20, z=8})
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive(self, dtime, 6, 0.5, true, "vehicles:bullet", 0.2, {x=120, y=140}, {x=1, y=1}, "hover", {x=60, y=70}, {x=40, y=51}, 3.5)
		self.standing = false
		return false
	else
	if not standing then
		self.object:set_animation({x=1, y=1}, 20, 0)
		self.standing = true
	end
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:assaultsuit", "Assault Suit", "vehicles_assaultsuit_inv.png")

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
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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

minetest.register_entity("vehicles:geep", {
	visual = "mesh",
	mesh = "geep.b3d",
	textures = {"vehicles_geep.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1.5,
	hp_max = 200,
	physical = true,
	collisionbox = {-1.1, 0, -1.1, 1.1, 1, 1.1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif self.driver and clicker ~= self.driver and not self.rider then
		clicker:set_attach(self.object, "", {x=0, y=5, z=-5}, false, {x=0, y=0, z=-2})
		self.rider = true
		elseif self.driver and clicker ~=self.driver and self.rider then
		clicker:set_detach()
		self.rider = false
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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

register_vehicle_spawner("vehicles:geep", "Geep", "vehicles_geep_inv.png")

minetest.register_entity("vehicles:ambulance", {
	visual = "mesh",
	mesh = "ambulance.b3d",
	textures = {"vehicles_ambulance.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1.5,
	hp_max = 200,
	physical = true,
	collisionbox = {-1.4, 0, -1.4, 1.4, 2, 1.4},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif self.driver and clicker ~= self.driver and not self.rider then
		clicker:set_attach(self.object, clicker, {x=0, y=5, z=4}, false, {x=0, y=7, z=10})
		self.rider = true
		clicker:set_hp(20)
		elseif self.driver and clicker ~= self.driver and self.rider then
		clicker:set_detach()
		self.rider = false
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=7, z=14})
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 13, 0.6, 0, {x=1, y=3}, {x=1, y=1})
		if not self.siren_ready then
		minetest.sound_play("ambulance", 
		{gain = 0.1, max_hear_distance = 3, loop = false})
		self.siren_ready = true
		minetest.after(4, function()
		self.siren_ready = false
		end)
		end
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:ambulance", "Ambulance", "vehicles_ambulance_inv.png")

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
		clicker:set_attach(self.object, clicker, {x=0, y=5, z=-5}, false, {x=0, y=0, z=-2})
		self.rider = true
		elseif self.driver and clicker ~=self.driver and self.rider then
		clicker:set_detach()
		self.rider = false
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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
		clicker:set_attach(self.object, clicker, {x=0, y=5, z=-5}, {x=0, y=0, z=0})
		self.rider = true
		elseif self.driver and clicker ~=self.driver and self.rider then
		clicker:set_detach()
		self.rider = false
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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

minetest.register_entity("vehicles:lambogoni2", {
	visual = "mesh",
	mesh = "lambogoni.b3d",
	textures = {"vehicles_lambogoni2.png"},
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
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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

register_vehicle_spawner("vehicles:lambogoni2", "Lambogoni (yellow)", "vehicles_lambogoni2_inv.png")

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
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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

minetest.register_entity("vehicles:policecar", {
	visual = "mesh",
	mesh = "policecar.b3d",
	textures = {"vehicles_policecar.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = step,
	hp_max = 190,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=2, z=4})
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive_car(self, dtime, 16, 0.95, 8)
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:policecar", "Police Car (US)", "vehicles_policecar_inv.png")

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
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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
		minetest.sound_play("engine_start", 
		{gain = 4, max_hear_distance = 3, loop = false})
		self.sound_ready = false
		minetest.after(14, function()
		self.sound_ready = true
		end)
		end
	end,
	on_activate = function(self)
	self.nitro = true
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
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
		object_attach(self, clicker, {x=0, y=3, z=3}, false, {x=0, y=3, z=3})
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 14, 0.2, 0.95, true, "vehicles:missile_2", 1, {x=10, y=10}, {x=1, y=1}, "rise")
		return false
		end
		self.object:setvelocity({x=0, y=-1, z=0})
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
	collisionbox = {-1.1, 0, -1, 1, 1.9, 1.1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=8, z=3}, false, {x=0, y=9, z=0})
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
	end,
	on_step = function(self, dtime)
	if self.anim and not self.driver then 
	self.object:set_animation({x=1, y=1}, 5, 0)
	end
	if self.driver then
		object_fly(self, dtime, 10, 0.1, 0.95, false, nil, nil, nil, nil)
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
		object_attach(self, clicker, {x=0, y=0, z=-1.5}, false, {x=0, y=-4, z=0})
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
			object_attach(entity, placer, {x=0, y=0, z=0}, false, {x=0, y=2, z=0})
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
			if inv:contains_item("main", "vehicles:missile_2_item") then
			local remov = inv:remove_item("main", "vehicles:missile_2_item")
			local obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+1+dir.y,z=playerpos.z+0+dir.z}, "vehicles:missile")
			local vec = {x=dir.x*6,y=dir.y*6,z=dir.z*6}
			obj:setvelocity(vec)
			return item
		end
	end,
})

--crafting recipes and materials

minetest.register_craftitem("vehicles:wheel", {
	description = "Wheel",
	inventory_image = "vehicles_wheel.png",
})

minetest.register_craftitem("vehicles:engine", {
	description = "Engine",
	inventory_image = "vehicles_engine.png",
})

minetest.register_craftitem("vehicles:body", {
	description = "Car Body",
	inventory_image = "vehicles_car_body.png",
})

minetest.register_craftitem("vehicles:armor", {
	description = "Armor plating",
	inventory_image = "vehicles_armor.png",
})

minetest.register_craftitem("vehicles:gun", {
	description = "Vehicle Gun",
	inventory_image = "vehicles_gun.png",
})

minetest.register_craftitem("vehicles:propeller", {
	description = "Propeller",
	inventory_image = "vehicles_propeller.png",
})

minetest.register_craftitem("vehicles:jet_engine", {
	description = "Jet Engine",
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





--decorative nodes

if minetest.setting_get("vehicles_nodes") == nil then
minetest.setting_set("vehicles_nodes", "true")
end

if minetest.setting_get("vehicles_nodes") then
function vehicles.register_simplenode(name, desc, texture, light)
minetest.register_node("vehicles:"..name, {
	description = desc,
	tiles = {texture},
	groups = {cracky=1},
	paramtype2 = "facedir",
	light_source = light,
	sound = default.node_sound_stone_defaults(),
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

minetest.register_node("vehicles:lights", {
	description = "Tunnel Lights",
	tiles = {"vehicles_lights_top.png", "vehicles_lights_top.png", "vehicles_lights.png", "vehicles_lights.png", "vehicles_lights.png", "vehicles_lights.png"},
	groups = {cracky=1},
	paramtype2 = "facedir",
	light_source = 20,
})

if minetest.get_modpath("stairs") then
stairs.register_stair_and_slab("road_surface", "vehicles:road",
		{cracky = 1},
		{"vehicles_road.png"},
		"Road Surface Stair",
		"Road Surface Slab",
		default.node_sound_stone_defaults())
end

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
	groups = {cracky=1, falling_node=1},
})
end


