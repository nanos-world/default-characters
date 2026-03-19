---@class NanosWorldCharacters
NanosWorldCharacters = {}

Package.Export("NanosWorldCharacters", NanosWorldCharacters)

-- Helpers/Base
Package.Require("Config.lua")
Package.Require("NPC.lua")

-- TODO require all native?
-- Character
Package.Require("Humanoids/MannequinMale.lua")
Package.Require("Humanoids/MannequinFemale.lua")
Package.Require("Humanoids/Male.lua")
Package.Require("Humanoids/Female.lua")
Package.Require("Humanoids/ClassicMale.lua")
Package.Require("Humanoids/PostApocalyptic.lua")
Package.Require("Humanoids/AdventureMaleA.lua")
Package.Require("Humanoids/AdventureMaleB.lua")
Package.Require("Humanoids/AdventureMaleC.lua")
Package.Require("Humanoids/AdventureFemaleA.lua")
Package.Require("Humanoids/AdventureFemaleB.lua")

-- CharacterSimple
Package.Require("Animals/Chicken.lua")
Package.Require("Robots/StackOBot.lua")