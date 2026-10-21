---@class Elephant: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Elephant
NanosWorldCharacters.Elephant = BaseDefaultCharacterSimple.Inherit("Elephant", {
	name = "Elephant",
	image = "assets://nanos-world/Thumbnails/SK_Elephant.jpg",
	category = "animals",

	-- Random cue: calls now and then and on spawn, also used when hurt and dying
	random_sound = "nanos-world::A_Elephant",
	spawn_sound = "nanos-world::A_Elephant",

	-- Tusks are separate meshes on the same skeleton
	tusks = {
		"nanos-world::SK_ElephantTusksSmall",
		"nanos-world::SK_ElephantTusksMedium",
		"nanos-world::SK_ElephantTusksBig",
	},
})

-- Constructor
function NanosWorldCharacters.Elephant:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Elephant", "nanos-world::ABP_Elephant", (enable_ai ~= false))

	self:AddSkeletalMeshAttached("tusks", NanosWorldCharacters.Elephant.tusks[math.random(#NanosWorldCharacters.Elephant.tusks)])

	self:SetHealth(1500)
	self:SetMaxHealth(1500)
	self:SetCapsuleSize(120, 204)
	self:SetSpeedSettings(350, 116)

	self:SetMaxAcceleration(210)
	self:SetBrakingSettings(4, 0.3, 252, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 130)
	self:SetRotationSettings(Rotator(0, 60, 0), false, true)

	-- Disables crouching since we don't have a resting animation
	self:SetCanCrouch(false)
end