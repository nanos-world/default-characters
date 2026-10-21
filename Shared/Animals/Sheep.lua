---@class Sheep: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Sheep
NanosWorldCharacters.Sheep = BaseDefaultCharacterSimple.Inherit("Sheep", {
	name = "Sheep",
	image = "assets://nanos-world/Thumbnails/SK_Sheep.jpg",
	category = "animals",

	-- Random cue: calls now and then and on spawn, also used when hurt and dying
	random_sound = "nanos-world::A_Sheep",
	spawn_sound = "nanos-world::A_Sheep",
})

-- Constructor
function NanosWorldCharacters.Sheep:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Sheep", "nanos-world::ABP_Sheep", (enable_ai ~= false))

	self:SetHealth(120)
	self:SetMaxHealth(120)
	self:SetCapsuleSize(30, 41)
	self:SetSpeedSettings(300, 100)

	self:SetMaxAcceleration(255)
	self:SetBrakingSettings(4, 0.3, 306, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 40)
	self:SetRotationSettings(Rotator(0, 180, 0), false, true)
end