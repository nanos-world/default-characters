---@class StackOBot: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): StackOBot
NanosWorldCharacters.StackOBot = BaseDefaultCharacterSimple.Inherit("StackOBot", {
	name = "Stack-O-Bot",
	image = "assets://nanos-world/Thumbnails/SK_StackOBot.jpg",
	category = "robots",

	-- Customization
	random_sound = "nanos-world::A_Robot_Beep_Whistle",
	spawn_sound = "nanos-world::A_Robot_Reaction"
})

-- Constructor
function NanosWorldCharacters.StackOBot:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_StackOBot", "nanos-world::ABP_StackOBot", (enable_ai ~= false))

	self:SetSpeedSettings(275, 150)

	Timer.Bind(
		Timer.SetInterval(function(stack_o_bot)
			if (stack_o_bot:IsDead()) then return end

			stack_o_bot:SetMood(math.random(0, 14))
		end, 15000, self),
		self
	)

	-- Sets a Mood
	self:SetMood(math.random(0, 14))

	self:SetMaterialColorParameter("Tint", Color.RandomPalette())
end

function NanosWorldCharacters.StackOBot:SetMood(value)
	self:SetMaterialScalarParameter("Mood", value)
end

-- Custom OnDeath implementation
function NanosWorldCharacters.StackOBot:OnDeath()
	self:SetMood(15)

	-- Plays "death" sound
	self:BroadcastRemoteEvent("PlaySound", "nanos-world::A_Robot_Shutdown")
end