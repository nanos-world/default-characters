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
Package.Require("Humanoids/HumanSkeleton.lua")

-- CharacterSimple
Package.Require("Animals/Chicken.lua")
Package.Require("Animals/Cow.lua")
Package.Require("Animals/Sheep.lua")
Package.Require("Animals/Pig.lua")
Package.Require("Animals/Goat.lua")
Package.Require("Animals/Crocodile.lua")
Package.Require("Animals/Elephant.lua")
Package.Require("Animals/Hippopotamus.lua")
Package.Require("Animals/Lion.lua")
Package.Require("Animals/Lioness.lua")
Package.Require("Animals/Rhinoceros.lua")
Package.Require("Animals/Zebra.lua")
Package.Require("Animals/Crow.lua")
Package.Require("Animals/DeerDoe.lua")
Package.Require("Animals/DeerStag.lua")
Package.Require("Animals/Fox.lua")
Package.Require("Animals/Wolf.lua")
Package.Require("Robots/StackOBot.lua")