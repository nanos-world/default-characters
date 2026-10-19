---@class HumanSkeleton: Character
---@overload fun(location: Vector, rotation: Rotator): HumanSkeleton
NanosWorldCharacters.HumanSkeleton = BaseDefaultCharacter.Inherit("HumanSkeleton", {
	name = "HumanSkeleton",
	image = "assets://nanos-world/Thumbnails/SK_HumanSkeleton.jpg",
	category = "humanoids",

	-- Customization
	is_male = true,

	-- Bones spawned as client side Props when it dies, each one placed relative to its skeleton bone
	-- The meshes are modeled in the reference pose with a centered pivot, so location and rotation map the bone space back to the mesh space
	death_bones = {
		{ bone = "head", mesh = "nanos-world::SM_HumanSkeleton_Head_Full", location = Vector(4.2, 2, 0), rotation = Rotator(-90, -10.5, 11.8) },
		{ bone = "spine_03", mesh = "nanos-world::SM_HumanSkeleton_Chest", location = Vector(-2.5, 0.8, 0), rotation = Rotator(-90, 90, -80.5) },
		{ bone = "upperarm_l", mesh = "nanos-world::SM_HumanSkeleton_Arm_L", location = Vector(27.2, 5, 2.7), rotation = Rotator(49.6, 6, 2.4) },
		{ bone = "upperarm_r", mesh = "nanos-world::SM_HumanSkeleton_Arm_R", location = Vector(-27.2, -5, -2.7), rotation = Rotator(49.6, 6, -177.6) },
		{ bone = "hand_l", mesh = "nanos-world::SM_HumanSkeleton_Hand_L", location = Vector(10.5, -2.8, 0), rotation = Rotator(22.8, 41.8, 104.1) },
		{ bone = "hand_r", mesh = "nanos-world::SM_HumanSkeleton_Hand_R", location = Vector(-10.5, 2.8, 0), rotation = Rotator(22.8, 41.8, -75.9) },
		{ bone = "thigh_l", mesh = "nanos-world::SM_HumanSkeleton_Leg_L", location = Vector(-43.1, -2.6, -0.4), rotation = Rotator(-78.9, 129.6, -130.8) },
		{ bone = "thigh_r", mesh = "nanos-world::SM_HumanSkeleton_Leg_R", location = Vector(43.1, 2.6, 0.4), rotation = Rotator(-78.9, 129.6, 49.2) },
		{ bone = "foot_l", mesh = "nanos-world::SM_HumanSkeleton_Feet_L", location = Vector(-8.2, 8.5, -1.4), rotation = Rotator(-87.2, 108, -108.7) },
		{ bone = "foot_r", mesh = "nanos-world::SM_HumanSkeleton_Feet_R", location = Vector(8.2, -8.5, 1.4), rotation = Rotator(-87.2, 108, 71.3) },
	}
})

-- Constructor
function NanosWorldCharacters.HumanSkeleton:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacter.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_HumanSkeleton", (enable_ai ~= false))

	-- NanosWorldCharactersHelper.CustomizeCharacter(self)

	-- Bones rattling instead of a voice
	self:SetDeathSound("nanos-world::A_Skeleton_Falling")
end

if (Client) then
	-- Hides the skeleton locally and makes it fall apart into loose bones
	NanosWorldCharacters.HumanSkeleton.Subscribe("Death", function(self)

		-- TODO only if close enough?
		self:SetVisibility(false)

		local velocity = self:GetVelocity()
		local center = self:GetSocketTransform("spine_01").Location

		for _, death_bone in ipairs(NanosWorldCharacters.HumanSkeleton.death_bones) do
			local transform = self:GetSocketTransform(death_bone.bone)

			local location = transform.Location + transform.Rotation:RotateVector(death_bone.location * transform.Scale)
			local rotation = (transform.Rotation:Quaternion() * death_bone.rotation:Quaternion()):Rotator()

			local prop = Prop(location, rotation, death_bone.mesh, CollisionType.IgnoreOnlyPawn, true, GrabMode.Disabled, CCDMode.Disabled, SpawnMode.Manual)
			prop:SetScale(transform.Scale)
			prop:SetLifeSpan(10)
			prop:FinishSpawn()

			-- Light burst outwards from the body center, slightly upwards
			local burst = (transform.Location - center):GetSafeNormal() * math.random(50, 100) + Vector(0, 0, 100)
			prop:AddImpulse(velocity + burst, true)
		end
	end)

	-- Shows it again if a Player respawns it
	NanosWorldCharacters.HumanSkeleton.Subscribe("Respawn", function(self)
		self:SetVisibility(true)
	end)
end
