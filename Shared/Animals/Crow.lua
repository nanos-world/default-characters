---@class Crow: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Crow
NanosWorldCharacters.Crow = BaseDefaultCharacterSimple.Inherit("Crow", {
	name = "Crow",
	image = "assets://nanos-world/Thumbnails/SK_Crow.jpg",
	category = "animals",

	-- Random cue: calls now and then and on spawn, also used when hurt and dying
	random_sound = "nanos-world::A_Crow",
	spawn_sound = "nanos-world::A_Crow",

	-- Flight: animations played on the ABP's DefaultSlot over the ground locomotion
	flight = {
		take_off = "nanos-world::A_Crow_TakeOff",
		take_off_time = 1.0,		-- seconds of TakeOff before the wings settle into Fly
		fly = "nanos-world::A_Crow_Fly",
		glide = "nanos-world::A_Crow_Glide",
		altitude = { 800, 1500 },	-- above the take off spot
		distance = { 1500, 3000 },	-- between waypoints
		waypoints = { 2, 3 },		-- before heading down to land
		scare_radius = 600,			-- takes off when a character gets this close
		random_chance = 0.2,		-- chance an idle wander becomes a flight instead
		walk_acceleration = 68,
		fly_acceleration = 900,
	},

	-- Player flight: no Flying mode, the crow falls with gravity and every Jump in mid air is a flap
	player_flight = {
		flap_speed = 320,			-- vertical speed a flap sets
		flap_delay = 0.15,			-- seconds from the press to the push, so it rises with the wings' downstroke (the Fly animation restarts on each flap)
		flap_time = 0.6,			-- seconds of Fly after a flap before it settles back into Glide
		glide_sink = 120,			-- fastest it sinks while gliding (holding Crouch dives instead)
		gravity = 0.5,
		air_speed = 600,			-- horizontal speed in the air
		walk_speed = 80,
		walk_gravity = 0.35,
		air_rotation_rate = 120,	-- degrees per second it turns towards where it flies, slow enough to bank instead of spinning
		walk_rotation_rate = 300,
	},
})

-- Constructor
function NanosWorldCharacters.Crow:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Crow", "nanos-world::ABP_Crow", (enable_ai ~= false))

	self:SetHealth(20)
	self:SetMaxHealth(20)
	self:SetCapsuleSize(12, 17)
	self:SetSpringArmSettings(nil, 150)
	self:SetCollision(CollisionType.IgnoreOnlyPawn)

	self:SetSpeedSettings(NanosWorldCharacters.Crow.player_flight.walk_speed, 26, 700)

	self:SetMaxAcceleration(NanosWorldCharacters.Crow.flight.walk_acceleration)
	self:SetBrakingSettings(4, 0.3, 81, 900, 0, 0)

	self:SetAIAvoidanceSettings(true, 22)
	self:SetRotationSettings(Rotator(0, NanosWorldCharacters.Crow.player_flight.walk_rotation_rate, 0), false, true)

	-- Flaps its way down from jumps
	self:SetAirControl(0.8)
	self:SetJumpZVelocity(500)
	self:SetGravityScale(NanosWorldCharacters.Crow.player_flight.walk_gravity)

	-- Disables crouching since we don't have a resting animation
	self:SetCanCrouch(false)

	-- Takes off when someone gets too close
	if (enable_ai ~= false) then
		Timer.Bind(Timer.SetInterval(self.CheckScared, 500, self), self)
	end
end

if (Server) then
	local function RandomRange(range)
		return range[1] + math.random() * (range[2] - range[1])
	end

	-- Some idle wanders become short flights
	function NanosWorldCharacters.Crow:MoveRandom(distance)
		if (self.is_flying) then return end

		if (math.random() < NanosWorldCharacters.Crow.flight.random_chance) then
			self:TakeOff()
		else
			NPCBase.MoveRandom(self, distance)
		end
	end

	function NanosWorldCharacters.Crow:CheckScared()
		if (self.is_flying or self:IsDead() or self:GetPlayer() ~= nil) then return end

		local location = self:GetLocation()

		for _, character in pairs(Server.GetActorsInRadius(location, NanosWorldCharacters.Crow.flight.scare_radius, { "Character" }, self:GetDimension())) do
			if (not character:IsDead()) then
				self:TakeOff(location - character:GetLocation())
				return
			end
		end
	end

	-- Leaves the ground, heading along flee_direction first when there is one
	function NanosWorldCharacters.Crow:TakeOff(flee_direction)
		if (self.is_flying or self:IsDead() or self:GetPlayer() ~= nil) then return end

		local flight = NanosWorldCharacters.Crow.flight

		self.ground_z = self:GetLocation().Z
		self.waypoints_left = math.random(flight.waypoints[1], flight.waypoints[2])
		self.flee_direction = flee_direction and Vector(flee_direction.X, flee_direction.Y, 0):GetSafeNormal() or nil

		self:StartFlight()
		self:NextWaypoint()
	end

	-- Flying mode and the take off animation, settling into Fly after it (shared by the AI and the player)
	function NanosWorldCharacters.Crow:StartFlight()
		local flight = NanosWorldCharacters.Crow.flight

		self.is_flying = true
		self:SetMaxAcceleration(flight.fly_acceleration)
		self:SetFlyingMode(true)
		self:PlayAnimation(flight.take_off, "", false, 0.1, 0.2)

		Timer.Bind(
			Timer.SetTimeout(function()
				if (not self.is_flying or self:IsDead()) then return end

				self:PlayFlightAnimation(flight.fly)
			end, flight.take_off_time * 1000),
			self
		)
	end

	function NanosWorldCharacters.Crow:NextWaypoint()
		local flight = NanosWorldCharacters.Crow.flight
		local location = self:GetLocation()

		local direction = self.flee_direction or Rotator(0, math.random(360), 0):GetForwardVector()
		self.flee_direction = nil

		local target = location + direction * RandomRange(flight.distance)

		-- Last leg heads down close to the ground it took off from
		if (self.waypoints_left <= 0) then
			target.Z = self.ground_z + 120
			self.is_landing = true
		else
			target.Z = self.ground_z + RandomRange(flight.altitude)
		end

		self.waypoints_left = self.waypoints_left - 1
		self.waypoint_time = Server.GetTime()

		-- Flaps going up, glides going down
		if (target.Z < location.Z - 200) then
			self:PlayFlightAnimation(flight.glide)
		elseif (self.flight_animation == flight.glide) then
			self:PlayFlightAnimation(flight.fly)
		end

		self:MoveTo(target, 150)
	end

	function NanosWorldCharacters.Crow:PlayFlightAnimation(animation)
		if (self.flight_animation == animation) then return end

		if (self.flight_animation) then
			self:StopAnimation(self.flight_animation)
		end

		self.flight_animation = animation
		self:PlayAnimation(animation, "", true, 0.3, 0.3)
	end

	function NanosWorldCharacters.Crow:Land()
		if (not self.is_flying) then return end

		self.is_flying = false
		self.is_landing = false

		if (self.flight_animation) then
			self:StopAnimation(self.flight_animation)
			self.flight_animation = nil
		end

		-- Drops the last bit, the ABP plays Fly while falling and Landing when it touches down
		self:SetFlyingMode(false)
		self:SetMaxAcceleration(NanosWorldCharacters.Crow.flight.walk_acceleration)
	end

	function NanosWorldCharacters.Crow:OnMoveComplete(success)
		if (not self.is_flying or self:GetPlayer() ~= nil) then return end

		-- The ground move the flight replaces reports a failure right after take off, ignore it (GetTime is in ms)
		if (not success and Server.GetTime() - (self.waypoint_time or 0) < 300) then return end

		if (not success or self.is_landing or self:IsDead()) then
			self:Land()
		else
			self:NextWaypoint()
		end
	end

	-- Shot: flies off along the hit direction (from_direction is the way the base NPC logic runs to), replacing that ground run
	function NanosWorldCharacters.Crow:OnTakeDamage(damage, bone, type, from_direction)
		Timer.Bind(
			Timer.SetTimeout(function()
				if (self.is_flying or self:IsDead() or self:GetPlayer() ~= nil) then return end
				self:TakeOff(from_direction)
			end, 50),
			self
		)
	end

	function NanosWorldCharacters.Crow:OnDeath()
		self:Land()
		self:StopGliding()
	end

	-- Player flight: the client applies the flap itself (it owns the movement), the server switches to air speed and gravity and plays the wings
	function NanosWorldCharacters.Crow:PlayerFlap(player)
		if (self:GetPlayer() ~= player or self:IsDead()) then return end

		self:StartGliding()

		-- Restarts the wing beat on every flap, so the client's delayed push lands on its downstroke
		local fly = NanosWorldCharacters.Crow.flight.fly

		self.last_flap = Server.GetTime()
		self.flight_animation = fly
		self:PlayAnimation(fly, "", true, 0.1, 0.3, 1, true)
	end

	function NanosWorldCharacters.Crow:StartGliding()
		if (self.is_gliding) then return end

		local player_flight = NanosWorldCharacters.Crow.player_flight

		-- Taken over in the middle of an AI flight: leaves the Flying mode and glides from there
		if (self.is_flying) then
			self.is_flying = false
			self.is_landing = false
			self:SetFlyingMode(false)
		end

		self.is_gliding = true
		self.last_flap = Server.GetTime()

		self:SetSpeedSettings(player_flight.air_speed, 26, 700)
		self:SetMaxAcceleration(NanosWorldCharacters.Crow.flight.fly_acceleration)
		self:SetGravityScale(player_flight.gravity)
		self:SetRotationSettings(Rotator(0, player_flight.air_rotation_rate, 0), false, true)

		self.glide_timer = Timer.SetInterval(self.UpdateGliding, 200, self)
		Timer.Bind(self.glide_timer, self)
	end

	-- Flaps for a moment after each flap, glides in between
	function NanosWorldCharacters.Crow:UpdateGliding()
		if (Server.GetTime() - self.last_flap > NanosWorldCharacters.Crow.player_flight.flap_time * 1000) then
			self:PlayFlightAnimation(NanosWorldCharacters.Crow.flight.glide)
		end
	end

	function NanosWorldCharacters.Crow:StopGliding()
		if (not self.is_gliding) then return end

		local player_flight = NanosWorldCharacters.Crow.player_flight

		self.is_gliding = false

		Timer.ClearInterval(self.glide_timer)
		self.glide_timer = nil

		if (self.flight_animation) then
			self:StopAnimation(self.flight_animation)
			self.flight_animation = nil
		end

		self:SetSpeedSettings(player_flight.walk_speed, 26, 700)
		self:SetMaxAcceleration(NanosWorldCharacters.Crow.flight.walk_acceleration)
		self:SetGravityScale(player_flight.walk_gravity)
		self:SetRotationSettings(Rotator(0, player_flight.walk_rotation_rate, 0), false, true)
	end

	-- Sent by the client that moves this crow when it touches the ground
	function NanosWorldCharacters.Crow:OnLanded(player)
		self:StopGliding()
	end

	-- Possessed in mid flight: the AI's route stops (NPCBase stops the movement) and the player glides on from there
	function NanosWorldCharacters.Crow:OnPossess()
		if (self.is_flying) then
			self:StartGliding()
		end
	end

	-- Released in the middle of an AI flight (never happens while gliding, StartGliding left the Flying mode)
	function NanosWorldCharacters.Crow:OnUnPossess()
		self:Land()
	end

	NanosWorldCharacters.Crow.Subscribe("MoveComplete", NanosWorldCharacters.Crow.OnMoveComplete)
	NanosWorldCharacters.Crow.Subscribe("TakeDamage", NanosWorldCharacters.Crow.OnTakeDamage)
	NanosWorldCharacters.Crow.Subscribe("UnPossess", NanosWorldCharacters.Crow.OnUnPossess)
	NanosWorldCharacters.Crow.SubscribeRemote("Flap", NanosWorldCharacters.Crow.PlayerFlap)
	NanosWorldCharacters.Crow.SubscribeRemote("Landed", NanosWorldCharacters.Crow.OnLanded)
end

if (Client) then
	local function GetLocalCrow()
		local player = Client.GetLocalPlayer()
		local crow = player and player:GetControlledCharacter()

		if (crow and crow:IsA(NanosWorldCharacters.Crow) and not crow:IsDead()) then
			return crow
		end
	end

	-- The press that jumps off the ground is just that jump, every press in mid air is a flap
	Input.Bind("Jump", InputEvent.Pressed, function()
		local crow = GetLocalCrow()
		if (not crow) then return end

		local velocity_z = crow:GetVelocity().Z
		if ((not crow.is_airborne and math.abs(velocity_z) < 1) or Client.GetTime() - (crow.jumped_at or 0) < 150) then return end

		crow.is_airborne = true
		crow:CallRemoteEvent("Flap")

		local player_flight = NanosWorldCharacters.Crow.player_flight

		Timer.SetTimeout(function()
			if (not crow:IsValid() or crow:IsDead()) then return end

			local current_z = crow:GetVelocity().Z
			if (current_z < player_flight.flap_speed) then
				crow:AddImpulse(Vector(0, 0, player_flight.flap_speed - current_z), true)
			end
		end, player_flight.flap_delay * 1000)
	end)

	-- Gliding: caps how fast the crow sinks (also when it walks off a ledge or is taken over mid flight), unless Crouch is held to dive
	Client.Subscribe("Tick", function()
		local crow = GetLocalCrow()
		if (not crow or Input.IsBindingDown("Crouch")) then return end

		local velocity_z = crow:GetVelocity().Z
		local glide_sink = NanosWorldCharacters.Crow.player_flight.glide_sink

		if (velocity_z < -glide_sink) then
			crow:AddImpulse(Vector(0, 0, -glide_sink - velocity_z), true)
		end
	end)

	NanosWorldCharacters.Crow.Subscribe("Jump", function(self)
		self.jumped_at = Client.GetTime()
		self.is_airborne = true
	end)

	-- Only the client moving this crow sees it land, it tells the server to go back to walking
	-- CallRemoteEvent finds the package through the caller's _ENV upvalue, so this callback touches a global (Client) or the call logs a fallback warning
	NanosWorldCharacters.Crow.Subscribe("Land", function(self)
		self.is_airborne = false

		if (Client and self:HasNetworkAuthority()) then
			self:CallRemoteEvent("Landed")
		end
	end)
end
