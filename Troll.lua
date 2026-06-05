-- ==================== 🔥 TOMMY HUB TROLL ====================

local HttpService = game:GetService("HttpService")

-- 🔗 PON TU WEBHOOK AQUÍ
local WEBHOOK_URL = "https://discord.com/api/webhooks/1512299599778549872/xndBdj2ZZqGnnKQIzzvPekpnpCLzL-NxYZwpdi5SBjUsXwSTc32UdhbKK7VJnzBw9G0J"

-- ==================== 📩 WEBHOOK ====================

local function SendWebhook()
    pcall(function()
        request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({
                content = "🔥 ** @everoyne TOMMY ON TOP** 🔥\n\nBorren ese hub basura 🗑️\nAquí habla su papi Tommy 😈\n\nBuen intento tratando de sacarme la IP…\npero fallaron como siempre 🤡\n\nSigan intentando, yo sigo arriba 🚀"
            })
        })
    end)
end

-- ==================== 🚀 EJECUCIÓN ====================

SendWebhook()

print("🔥 Tommy Hub Activado")
