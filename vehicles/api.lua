--vehicles/mounts api by D00Med, based on lib_mount(see below)

--License of lib_mount:
-- Minetest mod: lib_mount
-- =======================
-- by blert2112

-- Based on the Boats mod by PilzAdam.


-- -----------------------------------------------------------
-- -----------------------------------------------------------


-- Minetest Game mod: boats
-- ========================
-- by PilzAdam

-- License of source code:
-- -----------------------
-- WTFPL


--from lib_mount (required by new functions)


local mobs_redo = false
if minetest.get_modpath("mobs")then
if mobs.mod and mobs.mod == "redo" then
	mobs_redo = true
end
end

--attach position seems broken, and eye offset will cause problems if the vehicle/mount/player is destroyed whilst driving/riding

local function force_detach(player)
	local attached_to = player:get_attach()
	if attached_to and attached_to:get_luaentity() then
		local entity = attached_to:get_luaentity()
		if entity.driver then
			if entity ~= nil then entity.driver = nil end
		end
		player:set_detach()
	end
	default.player_attached[player:get_player_name()] = false
	player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
end

function object_attach(entity, player, attach_at, visible, eye_offset)
	eye_offset = eye_offset or {x=0, y=0, z=0}
	force_detach(player)
	entity.driver = player
	entity.loaded = true
	player:set_attach(entity.object, "", attach_at, {x=0, y=0, z=0})
	--this is to hide the player when the attaching doesn't work properly
	if not visible then
	player:set_properties({visual_size = {x=0, y=0}})
	else
	player:set_properties({visual_size = {x=1, y=1}})
	end
	player:set_eye_offset(eye_offset, {x=0, y=2, z=-40})
	default.player_attached[player:get_player_name()] = true
	minetest.after(0.2, function()
		default.player_set_animation(player, "sit" , 30)
	end)
	entity.object:setyaw(player:get_look_yaw() - math.pi / 2)
end

function object_detach(entity, player, offset)
	entity.driver = nil
	entity.object:setvelocity({x=0, y=0, z=0})
	player:set_detach()
	default.player_attached[player:get_player_name()] = false
	default.player_set_animation(player, "stand" , 30)
	player:set_properties({
			visual_size = {x = 1, y = 1},
		})
	player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
	local pos = player:getpos()
	pos = {x = pos.x + offset.x, y = pos.y + 0.2 + offset.y, z = pos.z + offset.z}
	minetest.after(0.1, function()
		player:setpos(pos)
	end)
end
-------------------------------------------------------------------------------


minetest.register_on_leaveplayer(function(player)
	force_detach(player)
end)

minetest.register_on_shutdown(function()
    local players = minetest.get_connected_players()
	for i = 1,#players do
		force_detach(players[i])
	end
end)

minetest.register_on_dieplayer(function(player)
	force_detach(player)
	return true
end)

-------------------------------------------------------------------------------

--mixed code(from this mod and lib_mount)

--basic driving, use for basic vehicles/mounts, with optional weapons
function object_drive(entity, dtime, speed, decell, shoots, arrow, reload, moving_anim, stand_anim, jumps)
	local ctrl = entity.driver:get_player_control()
	local velo = entity.object:getvelocity()
	local dir = entity.driver:get_look_dir();
	local vec_forward = {x=dir.x*speed,y=velo.y+1*-2,z=dir.z*speed}
	local vec_backward = {x=-dir.x*speed,y=velo.y+1*-2,z=-dir.z*speed}
	local vec_stop = {x=velo.x*decell,y=velo.y+1*-2,z=velo.z*decell}
	local yaw = entity.driver:get_look_yaw();
	if ctrl.up then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_forward)
	elseif ctrl.down then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_backward)
	elseif not ctrl.down or ctrl.up then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_stop)
	end
	if ctrl.sneak and shoots and entity.loaded then
			entity.loaded = false
			local pos = entity.object:getpos()
			local obj = minetest.env:add_entity({x=pos.x+0+dir.x*2,y=pos.y+1.5+dir.y,z=pos.z+0+dir.z*2}, arrow)
			local vec = {x=dir.x*9,y=dir.y*9,z=dir.z*9}
			local yaw = entity.driver:get_look_yaw();
			obj:setyaw(yaw+math.pi/2)
			obj:setvelocity(vec)
			local object = obj:get_luaentity()
			object.launcher = entity.driver
			minetest.after(reload, function()
			entity.loaded = true
			end)
	end
	--lib_mount animation
	if velo.x == 0 and velo.y == 0 and velo.z == 0 then
		if stand_anim and stand_anim ~= nil and mobs_redo == true then
			self.object:set_animation(entity, stand_anim)
		end
		return
	end
	if moving_anim and moving_anim ~= nil then
		self.object:set_animation(entity, moving_anim)
	end
	--jumping not working
	-- local jumps = jumps or false
	-- if jumps == true and ctrl.jump then
		-- local xvel = entity.object:getvelocity().x
		-- local zvel = entity.object:getvelocity().z
		-- local yvel = entity.object:getvelocity().y
		-- local vel = {x=xvel,y=10,z=zvel}
		-- entity.object:setvelocity(vel)
		-- minetest.after(1.5, function()
		-- local xvel = entity.object:getvelocity().x
		-- local zvel = entity.object:getvelocity().z
		-- local yvel = entity.object:getvelocity().y
		-- local vel = {x=xvel,y=-10,z=zvel}
		-- entity.object:setvelocity(vel)
		-- end)
	-- end
end



--simplified in an attempt to reduce lag
function object_drive_simple(entity, dtime, speed, decell)
	local ctrl = entity.driver:get_player_control()
	local velo = entity.object:getvelocity()
	local dir = entity.driver:get_look_dir();
	local vec_forward = {x=dir.x*speed,y=velo.y+1*-2,z=dir.z*speed}
	local vec_backward = {x=-dir.x*speed,y=velo.y+1*-2,z=-dir.z*speed}
	local vec_stop = {x=velo.x*decell,y=velo.y+1*-2,z=velo.z*decell}
	local yaw = entity.driver:get_look_yaw();
		entity.object:setyaw(yaw+math.pi+math.pi/2)
	if ctrl.up then
		entity.object:setvelocity(vec_forward)
	elseif ctrl.down then
		entity.object:setvelocity(vec_backward)
	elseif not ctrl.down or ctrl.up then
		entity.object:setvelocity(vec_stop)
	end
end

--same as above but with improvements for cars and nitro/boost
function object_drive_car(entity, dtime, speed, decell, nitro_duration)
	local ctrl = entity.driver:get_player_control()
	local velo = entity.object:getvelocity()
	local dir = entity.driver:get_look_dir();
	local vec_forward = {x=dir.x*speed,y=velo.y-0.5,z=dir.z*speed}
	local vec_nitro = {x=dir.x*(speed*1.5),y=velo.y-0.5,z=dir.z*(speed*1.5)}
	local vec_backward = {x=-dir.x*speed,y=velo.y-0.5,z=-dir.z*speed}
	local vec_stop = {x=velo.x*decell,y=velo.y-1,z=velo.z*decell}
	local yaw = entity.driver:get_look_yaw();
		entity.object:setyaw(yaw+math.pi+math.pi/2)
	if not entity.nitro then
		minetest.after(4, function()
		entity.nitro = true
		end)
	end
	if ctrl.up and ctrl.sneak and entity.nitro then
		entity.object:setvelocity(vec_nitro)
		local pos = entity.object:getpos()
			minetest.add_particlespawner(
			10, --amount
			1, --time
			{x=pos.x-0.5, y=pos.y, z=pos.z-0.5}, --minpos
			{x=pos.x+0.5, y=pos.y, z=pos.z+0.5}, --maxpos
			{x=0, y=0, z=0}, --minvel
			{x=-velo.x, y=-velo.y, z=-velo.z}, --maxvel
			{x=-0,y=-0,z=-0}, --minacc
			{x=0,y=0,z=0}, --maxacc
			0.1, --minexptime
			0.2, --maxexptime
			10, --minsize
			15, --maxsize
			false, --collisiondetection
			"vehicles_nitro.png" --texture
			)
			minetest.after(nitro_duration, function()
			entity.nitro = false
			end)
	elseif ctrl.up then
		entity.object:setvelocity(vec_forward)
	elseif ctrl.down then
		entity.object:setvelocity(vec_backward)
	elseif not ctrl.down or ctrl.up then
		entity.object:setvelocity(vec_stop)
	end
end

--for boats and watercraft
function object_float(entity, dtime, speed, decell)
	local ctrl = entity.driver:get_player_control()
	local velo = entity.object:getvelocity()
	local dir = entity.driver:get_look_dir()
	local pos = entity.object:getpos()
	local vec_forward = {x=dir.x*speed,y=velo.y,z=dir.z*speed}
	local vec_backward = {x=-dir.x*speed,y=velo.y,z=-dir.z*speed}
	local vec_stop = {x=velo.x*decell,y=velo.y,z=velo.z*decell}
	local yaw = entity.driver:get_look_yaw();
	entity.object:setyaw(yaw+math.pi+math.pi/2)
	if minetest.get_node(pos).name == "default:river_water_source" or minetest.get_node(pos).name == "default:water_source" then
	entity.floating = true
	else entity.floating = false
	end
	if ctrl.up and entity.floating then
		entity.object:setvelocity(vec_forward)
	elseif ctrl.down and entity.floating then
		entity.object:setvelocity(vec_backward)
	elseif not ctrl.down or ctrl.up then
		entity.object:setvelocity(vec_stop)
	end
end

--attempts to improve object_drive_car
-- function object_drive_experimental(entity, dtime, power, traction, nitro_duration)
	-- local ctrl = entity.driver:get_player_control()
	-- local velo = entity.object:getvelocity()
	-- local speed = math.abs(velo.x)+math.abs(velo.z)
	-- local nitro_remaining = entity.nitro
	-- local dir = entity.driver:get_look_dir()
	-- local yaw1 = entity.object:getyaw()
	-- local dir_x = -math.sin(yaw1)
	-- local dir_z = math.cos(yaw1)
	-- local vec_forward = {x=dir_x*power,y=velo.y-0.5,z=dir_z*power}
	-- local vec_nitro = {x=dir.x*(power*1.5),y=velo.y-0.5,z=dir.z*(power*1.5)}
	-- local vec_backward = {x=-dir.x*power,y=velo.y-0.5,z=-dir.z*power}
	-- local vec_stop = {x=velo.x*traction,y=velo.y-1,z=velo.z*traction}
	-- local yaw = entity.driver:get_look_yaw();
	-- if ctrl.left then
	-- entity.object:setyaw(yaw1+math.pi/180+speed/360)
	-- elseif ctrl.right then
	-- entity.object:setyaw(yaw1-math.pi/180-speed/360)
	-- else
	-- entity.object:setyaw(yaw1)
	-- end
	-- if not entity.nitro then
		-- minetest.after(4, function()
		-- entity.nitro = true
		-- end)
	-- end
	-- if ctrl.up and ctrl.sneak and entity.nitro then
		-- entity.object:setvelocity(vec_nitro)
		-- local pos = entity.object:getpos()
			-- minetest.add_particlespawner(
			-- 15, --amount
			-- 1, --time
			-- {x=pos.x-0.5, y=pos.y, z=pos.z-0.5}, --minpos
			-- {x=pos.x+0.5, y=pos.y, z=pos.z+0.5}, --maxpos
			-- {x=0, y=0, z=0}, --minvel
			-- {x=-velo.x, y=-velo.y, z=-velo.z}, --maxvel
			-- {x=-0,y=-0,z=-0}, --minacc
			-- {x=0,y=0,z=0}, --maxacc
			-- 0.1, --minexptime
			-- 0.2, --maxexptime
			-- 10, --minsize
			-- 15, --maxsize
			-- false, --collisiondetection
			-- "vehicles_nitro.png" --texture
			-- )
			-- minetest.after(nitro_duration, function()
			-- entity.nitro = false
			-- end)
	-- elseif ctrl.up then
		-- entity.object:setvelocity(vec_forward)
	-- elseif ctrl.down then
		-- entity.object:setvelocity(vec_backward)
	-- elseif not ctrl.down or ctrl.up then
		-- entity.object:setvelocity(vec_stop)
	-- end
-- end

--stationary object, useful for gun turrets etc.
function object_turret(entity, dtime, height, arrow, shoot_interval)
	local ctrl = entity.driver:get_player_control()
	local yaw = entity.driver:get_look_yaw();
	entity.object:setyaw(yaw+math.pi+math.pi/2)
	if ctrl.sneak and entity.loaded then
			entity.loaded = false
			local pos = entity.object:getpos()
			local dir = entity.driver:get_look_dir();
			local obj = minetest.env:add_entity({x=pos.x+dir.x*1.2,y=pos.y+height,z=pos.z+dir.z*1.2}, arrow)
			local yaw = entity.driver:get_look_yaw();
			local vec = {x=dir.x*9, y=dir.y*9, z=dir.z*9}
			obj:setyaw(yaw+math.pi/2)
			obj:setvelocity(vec)
			local object = obj:get_luaentity()
			object.launcher = entity.driver
			minetest.after(shoot_interval, function()
			entity.loaded = true
			end)
	end
end

--basic flying, with optional weapons
function object_fly(entity, dtime, speed, accel, decell, shoots, arrow, moving_anim, stand_anim)
	local ctrl = entity.driver:get_player_control()
	local dir = entity.driver:get_look_dir();
	local velo = entity.object:getvelocity()
	local vec_forward = {x=dir.x*speed,y=(dir.y*speed)/4+math.abs(velo.z+velo.x)/10,z=dir.z*speed}
	local acc_forward = {x=dir.x*accel/2,y=dir.y*accel/2+3,z=dir.z*accel/2}
	local vec_backward = {x=-dir.x*speed,y=dir.y*speed+3,z=-dir.z*speed}
	local acc_backward = {x=dir.x*accel/2,y=dir.y*accel/2+3,z=dir.z*accel/2}
	local vec_stop = {x=velo.x*decell, y=velo.y, z=velo.z*decell}
	local yaw = entity.driver:get_look_yaw();
	--pitch doesn't work
	--local pitch = entity.driver:get_look_pitch();
	if ctrl.up then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		--entity.object:setpitch(pitch+math.pi+math.pi/2)
		entity.object:setvelocity(vec_forward)
		entity.object:setacceleration(acc_forward)
	elseif ctrl.down then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		--entity.object:setpitch(pitch+math.pi+math.pi/2)
		entity.object:setvelocity(vec_backward)
		entity.object:setacceleration(acc_backward)
	elseif not ctrl.down or ctrl.up then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_stop)
		entity.object:setacceleration({x=0, y=-4.5, z=0})
	end
	if ctrl.jump and ctrl.up then
	entity.object:setvelocity({x=dir.x*speed, y=0, z=dir.z*speed})
	elseif ctrl.jump and not ctrl.up then
	entity.object:setvelocity({x=velo.x*decell, y=0, z=velo.z*decell})
	end
	if ctrl.sneak and shoots and entity.loaded then
			entity.loaded = false
			local pos = entity.object:getpos()
			local obj = minetest.env:add_entity({x=pos.x+0+dir.x*2,y=pos.y+1.5+dir.y,z=pos.z+0+dir.z*2}, arrow)
			local vec = {x=dir.x*9,y=dir.y*9,z=dir.z*9}
			obj:setyaw(yaw+math.pi/2)
			obj:setvelocity(vec)
			local object = obj:get_luaentity()
			object.launcher = entity.driver
			minetest.after(1, function()
			entity.loaded = true
			end)
	end
	--lib_mount animation
	if minetest.get_modpath("mobs")then
	if velo.x == 0 and velo.y == 0 and velo.z == 0 then
		if stand_anim and stand_anim ~= nil then
			entity.object:set_animation(entity, stand_anim)
		end
		return
	end
	if moving_anim and moving_anim ~= nil then
		entity.object:set_animation(entity, moving_anim)
	end
	end
end

--flying with jump to increase height in addition to looking up/down
function object_fly_2(entity, dtime, speed, accel, decell, shoots, arrow, moving_anim, stand_anim)
	local ctrl = entity.driver:get_player_control()
	local dir = entity.driver:get_look_dir();
	local yvel = entity.object:getvelocity().y
	local vec_forward = {x=dir.x*speed,y=yvel,z=dir.z*speed}
	local acc_forward = {x=dir.x*accel/2,y=yvel,z=dir.z*accel/2}
	local vec_backward = {x=-dir.x*speed,y=yvel,z=-dir.z*speed}
	local acc_backward = {x=dir.x*accel/2,y=yvel,z=dir.z*accel/2}
	local vec_stop = {x=entity.object:getvelocity().x*decell, y=entity.object:getvelocity().y, z=entity.object:getvelocity().z*decell}
	local vec_rise = {x=entity.object:getvelocity().x, y=speed*accel, z=entity.object:getvelocity().z}
	local yaw = entity.driver:get_look_yaw();
	if ctrl.up then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_forward)
		entity.object:setacceleration(acc_forward)
	elseif ctrl.down then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_backward)
		entity.object:setacceleration(acc_backward)
	elseif ctrl.jump then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_rise)
	elseif not ctrl.down or ctrl.up or ctrl.jump then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_stop)
		entity.object:setacceleration({x=0, y=-4.5, z=0})
	end
	if ctrl.sneak and shoots and entity.loaded then
			entity.loaded = false
			local pos = entity.object:getpos()
			local obj = minetest.env:add_entity({x=pos.x+0+dir.x*2,y=pos.y+1.5+dir.y,z=pos.z+0+dir.z*2}, arrow)
			local vec = {x=dir.x*9,y=dir.y*9,z=dir.z*9}
			local yaw = entity.driver:get_look_yaw();
			obj:setyaw(yaw+math.pi/2)
			obj:setvelocity(vec)
			minetest.after(1, function()
			entity.loaded = true
			end)
	end
	--lib_mount animation
	local velo = entity.object:getvelocity()
	if velo.x == 0 and velo.y == 0 and velo.z == 0 then
		if stand_anim and stand_anim ~= nil then
			self.object:set_animation(entity, stand_anim)
		end
		entity.object:setpos(entity.object:getpos())
		return
	end
	if moving_anim and moving_anim ~= nil then
		self.object:set_animation(entity, moving_anim)
	end
end

--gliding
function object_glide(entity, dtime, speed, decell, gravity, moving_anim, stand_anim)
	local ctrl = entity.driver:get_player_control()
	local dir = entity.driver:get_look_dir();
	local velo = entity.object:getvelocity();
	local vec_glide = {x=dir.x*speed*decell, y=velo.y, z=dir.z*speed*decell}
	local yaw = entity.driver:get_look_yaw();
	if not ctrl.sneak then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_glide)
		entity.object:setacceleration({x=0, y=gravity, z=0})
	end
	if ctrl.sneak then
			local vec = {x=0,y=gravity*15,z=0}
			local yaw = entity.driver:get_look_yaw();
			entity.object:setyaw(yaw+math.pi+math.pi/2)
			entity.object:setvelocity(vec)
	end
	if velo.y == 0 then
		local pos = entity.object:getpos()
		for dx=-1,1 do
						for dy=-1,1 do
							for dz=-1,1 do
								local p = {x=pos.x+dx, y=pos.y-1, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "massdestruct:parachute" and n ~= "air" then
									local pos = entity.object:getpos()
									entity.object:remove()
									return
								end
							end
						end
					end
	end
	--lib_mount animation
	if velo.x == 0 and velo.y == 0 and velo.z == 0 then
		if stand_anim and stand_anim ~= nilthen then
			set_animation(entity, stand_anim)
		end
		return
	end
	if moving_anim and moving_anim ~= nil then
		set_animation(entity, moving_anim)
	end
end

--lib_mount (not required by new functions)


-- local function is_group(pos, group)
	-- local nn = minetest.get_node(pos).name
	-- return minetest.get_item_group(nn, group) ~= 0
-- end

-- local function get_sign(i)
	-- i = i or 0
	-- if i == 0 then
		-- return 0
	-- else
		-- return i / math.abs(i)
	-- end
-- end

-- local function get_velocity(v, yaw, y)
	-- local x = -math.sin(yaw) * v
	-- local z =  math.cos(yaw) * v
	-- return {x = x, y = y, z = z}
-- end

-- local function get_v(v)
	-- return math.sqrt(v.x ^ 2 + v.z ^ 2)
-- end

-- lib_mount = {}

-- function lib_mount.attach(entity, player, attach_at, eye_offset)
	-- eye_offset = eye_offset or {x=0, y=0, z=0}
	-- force_detach(player)
	-- entity.driver = player
	-- player:set_attach(entity.object, "", attach_at, {x=0, y=0, z=0})
	
	-- player:set_properties({visual_size = {x=1, y=1}})
	
	-- player:set_eye_offset(eye_offset, {x=0, y=0, z=0})
	-- default.player_attached[player:get_player_name()] = true
	-- minetest.after(0.2, function()
		-- default.player_set_animation(player, "sit" , 30)
	-- end)
	-- entity.object:setyaw(player:get_look_yaw() - math.pi / 2)
-- end

-- function lib_mount.detach(entity, player, offset)
	-- entity.driver = nil
	-- player:set_detach()
	-- default.player_attached[player:get_player_name()] = false
	-- default.player_set_animation(player, "stand" , 30)
	-- player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
	-- local pos = player:getpos()
	-- pos = {x = pos.x + offset.x, y = pos.y + 0.2 + offset.y, z = pos.z + offset.z}
	-- minetest.after(0.1, function()
		-- player:setpos(pos)
	-- end)
-- end

-- function lib_mount.drive(entity, dtime, moving_anim, stand_anim, can_fly)
	-- entity.v = get_v(entity.object:getvelocity()) * get_sign(entity.v)
	
	-- local ctrl = entity.driver:get_player_control()
	-- local yaw = entity.object:getyaw()
	-- if ctrl.up then
		-- entity.v = entity.v + 0.1
	-- elseif ctrl.down then
		-- entity.v = entity.v - 0.1
	-- end
	-- if ctrl.left then
		-- if entity.v < 0 then
			-- entity.object:setyaw(yaw - (1 + dtime) * 0.03)
		-- else
			-- entity.object:setyaw(yaw + (1 + dtime) * 0.03)
		-- end
	-- elseif ctrl.right then
		-- if entity.v < 0 then
			-- entity.object:setyaw(yaw + (1 + dtime) * 0.03)
		-- else
			-- entity.object:setyaw(yaw - (1 + dtime) * 0.03)
		-- end
	-- end
	
	-- local velo = entity.object:getvelocity()
	-- if entity.v == 0 and velo.x == 0 and velo.y == 0 and velo.z == 0 then
		-- if stand_anim and stand_anim ~= nil and mobs_redo == true then
			-- set_animation(entity, stand_anim)
		-- end
		-- entity.object:setpos(entity.object:getpos())
		-- return
	-- end
	-- if moving_anim and moving_anim ~= nil and mobs_redo == true then
		-- set_animation(entity, moving_anim)
	-- end
	-- local s = get_sign(entity.v)
	-- entity.v = entity.v - 0.02 * s
	-- if s ~= get_sign(entity.v) then
		-- entity.object:setvelocity({x = 0, y = 0, z = 0})
		-- entity.v = 0
		-- return
	-- end
	-- if math.abs(entity.v) > 5 then
		-- entity.v = 5 * get_sign(entity.v)
	-- end

	-- local p = entity.object:getpos()
	-- p.y = p.y - 0.5
	-- local new_velo = {x = 0, y = 0, z = 0}
	-- local new_acce = {x = 0, y = 0, z = 0}
	-- if not is_group(p, "crumbly") then
		-- local nodedef = minetest.registered_nodes[minetest.get_node(p).name]
		-- if (not nodedef) or nodedef.walkable then
			-- entity.v = 0
			-- new_acce = {x = 0, y = 1, z = 0}
		-- else
			-- new_acce = {x = 0, y = -9.8, z = 0}
		-- end
		-- new_velo = get_velocity(entity.v, entity.object:getyaw(),
			-- entity.object:getvelocity().y)
		-- entity.object:setpos(entity.object:getpos())
	-- else
		-- p.y = p.y + 1
		-- if is_group(p, "crumbly") then
			-- local y = entity.object:getvelocity().y
			-- if y >= 5 then
				-- y = 5
			-- elseif y < 0 then
				-- new_acce = {x = 0, y = 20, z = 0}
			-- else
				-- new_acce = {x = 0, y = 5, z = 0}
			-- end
			-- new_velo = get_velocity(entity.v, entity.object:getyaw(), y)
			-- entity.object:setpos(entity.object:getpos())
		-- else
			-- new_acce = {x = 0, y = 0, z = 0}
			-- if math.abs(entity.object:getvelocity().y) < 1 then
				-- local pos = entity.object:getpos()
				-- pos.y = math.floor(pos.y) + 0.5
				-- entity.object:setpos(pos)
				-- new_velo = get_velocity(entity.v, entity.object:getyaw(), 0)
			-- else
				-- new_velo = get_velocity(entity.v, entity.object:getyaw(),
					-- entity.object:getvelocity().y)
				-- entity.object:setpos(entity.object:getpos())
			-- end
		-- end
	-- end
	-- if can_fly and can_fly == true and ctrl.jump then 
		-- new_velo.y = new_velo.y + 0.75
	-- end
	-- entity.object:setvelocity(new_velo)
	-- entity.object:setacceleration(new_acce)
-- end

--other stuff



function register_vehicle_spawner(vehicle, desc, texture, is_boat)
minetest.register_tool(vehicle.."_spawner", {
	description = desc,
	inventory_image = texture,
	liquids_pointable = is_boat,
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
			if pointed_thing.type == "node" and not is_boat then
			local obj = minetest.env:add_entity(pointed_thing.above, vehicle)
			local object = obj:get_luaentity()
			object.owner = placer
			item:take_item()
			return item
			elseif pointed_thing.type == "node" and minetest.get_item_group(pointed_thing.name, "water")then
			local obj = minetest.env:add_entity(pointed_thing.under, vehicle)
			local object = obj:get_luaentity()
			object.owner = placer
			item:take_item()
			return item
			end
	end,
})
end


--out of date, left behind in case it is needed again
function vehicle_drop(ent, player, name)
	if ent.owner == player then
	local pos = ent.object:getpos()
	minetest.env:add_item(pos, name.."_spawner")
	ent.object:remove()
	end
end

function destroy(ent, player, name)
	if ent.object:get_hp() == 0 and ent.owner == player then
		local pos = ent.object:getpos()
		minetest.env:add_item(pos, "vehicles:tank_spawner")
		end
end