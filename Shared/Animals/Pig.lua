---@class Pig: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Pig
NanosWorldCharacters.Pig = BaseDefaultCharacterSimple.Inherit("Pig", {
	name = "Pig",
	image = "assets://nanos-world/Thumbnails/SK_Pig.jpg",
	category = "animals",

	-- Random cue: calls now and then and on spawn, also used when hurt and dying
	random_sound = "nanos-world::A_Pig",
	spawn_sound = "nanos-world::A_Pig",
	death_sound = "nanos-world::A_Pig_Death",

	-- Customization: one entry per look, a material per slot (body, fur)
	materials = {
		{ "nanos-world::M_Pig", "nanos-world::M_PigHair" },
		{ "nanos-world::M_PigDirty", "nanos-world::M_PigHairDirty" },
	},
})

-- Constructor
function NanosWorldCharacters.Pig:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Pig", "nanos-world::ABP_Pig", (enable_ai ~= false))

	local materials = NanosWorldCharacters.Pig.materials[math.random(#NanosWorldCharacters.Pig.materials)]
	for slot, material in ipairs(materials) do
		self:SetMaterial(material, slot - 1)
	end

	self:SetHealth(150)
	self:SetMaxHealth(150)
	self:SetCapsuleSize(35, 51)
	self:SetSpeedSettings(600, 200)

	self:SetMaxAcceleration(510)
	self:SetBrakingSettings(4, 0.3, 612, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 45)
	self:SetRotationSettings(Rotator(0, 180, 0), false, true)
end