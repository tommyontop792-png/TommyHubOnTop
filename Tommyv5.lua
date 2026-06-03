local Players = game:GetService("Players")
local player = Players.LocalPlayer

local razonDeBan = [[You have been banned from this experience.

Reason: Violating Community Standards - Exploiting (Error Code: por tu puta madre)
Ban Expiration: Permanent
Moderator ID: 1928374]]

task.wait(0.8)
player:Kick(razonDeBan)
