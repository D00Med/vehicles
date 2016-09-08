
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

minetest.register_entity("vehicles:tank", {
	visual = "mesh",
	mesh = "tank.b3d",
	textures = {"vehicles_tank.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1.5,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, -0.6, -0.9, 1, 0.9, 0.9},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, {x=0, y=2, z=4}, {x=0, y=3, z=-72})
		end
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive(self, dtime, 6, 0.5, true, "vehicles:missile_2", nil, nil, false)
		return false
		end
		return true
	end,
})

minetest.register_entity("vehicles:turret", {
	visual = "mesh",
	mesh = "turret.b3d",
	textures = {"vehicles_tank.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1.5,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, -0.6, -0.9, 1, 0.9, 0.9},
})

register_vehicle_spawner("vehicles:tank", "Tank", "vehicles_tank_inv.png")

minetest.register_entity("vehicles:nizzan", {
	visual = "mesh",
	mesh = "nizzan.b3d",
	textures = {"vehicles_nizzan.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, {x=0, y=2, z=4}, {x=0, y=3, z=-72})
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
	stepheight = 1,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, {x=0, y=2, z=4}, {x=0, y=3, z=-72})
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
	stepheight = 1,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, {x=0, y=2, z=4}, {x=0, y=3, z=-72})
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

minetest.register_entity("vehicles:masda", {
	visual = "mesh",
	mesh = "masda.b3d",
	textures = {"vehicles_masda.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, {x=0, y=2, z=4}, {x=0, y=3, z=-72})
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

minetest.register_entity("vehicles:musting", {
	visual = "mesh",
	mesh = "musting.b3d",
	textures = {"vehicles_musting.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, {x=0, y=2, z=4}, {x=0, y=3, z=-72})
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

register_vehicle_spawner("vehicles:musting", "Musting (purple)", "vehicles_musting_inv2.png")

minetest.register_entity("vehicles:musting2", {
	visual = "mesh",
	mesh = "musting.b3d",
	textures = {"vehicles_musting2.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, {x=0, y=2, z=4}, {x=0, y=3, z=-72})
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

minetest.register_entity("vehicles:pooshe", {
	visual = "mesh",
	mesh = "pooshe.b3d",
	textures = {"vehicles_pooshe.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, {x=0, y=2, z=4}, {x=0, y=3, z=-72})
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

register_vehicle_spawner("vehicles:pooshe", "Pooshe (red)", "vehicles_pooshe_inv.png")

minetest.register_entity("vehicles:pooshe2", {
	visual = "mesh",
	mesh = "pooshe.b3d",
	textures = {"vehicles_pooshe2.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, {x=0, y=2, z=4}, {x=0, y=3, z=-72})
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
	stepheight = 1,
	hp_max = 200,
	physical = true,
	collisionbox = {-1, 0, -1, 1.3, 1, 1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=4}, {x=0, y=2, z=4}, {x=0, y=3, z=-72})
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

register_vehicle_spawner("vehicles:masda2", "Masda (orange)", "vehicles_masda_inv2.png")


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
      gear = { x=1, x=1},
      nogear = { x=10, x=10},
	},
	collisionbox = {-1, -0.9, -0.9, 1, 0.9, 0.9},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=5, z=5}, {x=0, y=3, z=4})
		end
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 15, 0.1, 0.95, true, "vehicles:missile_2", { x=1, y=1}, { x=10, y=10})
		return false
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:jet", "Jet", "vehicles_jet_inv.png")

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
-- minetest.register_entity("vehicles:wing_glider", {
	-- visual = "mesh",
	-- mesh = "wings.b3d",
	-- textures = {"vehicles_wings.png"},
	-- velocity = 15,
	-- acceleration = -5,
	-- hp_max = 2,
	-- physical = true,
	-- collisionbox = {-0.5, -0.1, -0.5, 0.5, 0.1, 0.5},
	-- on_step = function(self, dtime)
	-- if self.driver then
		-- local dir = self.driver:get_look_dir();
		-- local velo = self.object:getvelocity();
		-- local vec = {x=dir.x*5,y=(dir.y*5)-0.5,z=dir.z*5}
		-- local yaw = self.driver:get_look_yaw();
		-- self.object:setyaw(yaw+math.pi/2)
		-- self.object:setvelocity(vec)
		-- self.driver:set_animation({x=162, y=167}, 0, 0)
		-- return false
		-- end
		-- return true
	-- end,
-- })

-- minetest.register_tool("vehicles:wings", {
	-- description = "Wings",
	-- inventory_image = "vehicles_backpack.png",
	-- wield_scale = {x = 1.5, y = 1.5, z = 1},
	-- tool_capabilities = {
		-- full_punch_interval = 0.7,
		-- max_drop_level=1,
		-- groupcaps={
			-- snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=30, maxlevel=3},
		-- },
		-- damage_groups = {fleshy=1},
	-- },
	-- on_use = function(item, placer, pointed_thing)
			-- local dir = placer:get_look_dir();
			-- local playerpos = placer:getpos();
			-- local objs = minetest.get_objects_inside_radius({x=playerpos.x,y=playerpos.y,z=playerpos.z}, 2)	
			-- for k, obj2 in pairs(objs) do
				-- if obj2:get_luaentity() ~= nil then
					-- if obj2:get_luaentity().name == "vehicles:wings" then
					-- local wings = false
					-- end
					-- end
					-- end
			-- if wings then
			-- object_detach(obj2:get_luaentity(), placer, {x=1, y=0, z=1})
			-- placer:set_properties({
			-- visual_size = {x=1, y=1},
			-- })
			-- else
			-- local obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+1+dir.y,z=playerpos.z+0+dir.z}, "vehicles:wing_glider")
			-- local entity = obj:get_luaentity()
			-- placer:set_attach(entity.object, "", {x=0,y=-5,z=0}, {x=0,y=0,z=0})
			-- entity.driver = placer
			-- placer:set_properties({
			-- visual_size = {x=1, y=-1},
			-- })
			-- end
			-- item:add_wear(500)
			-- return item
	-- end,
-- })

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




