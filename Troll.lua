-- ==================== 🔥 TOMMY HUB TROLL ====================

local HttpService = game:GetService("HttpService")

-- 🔗 PON TU WEBHOOK AQUÍ
local WEBHOOK_URL = "https://discord.com/api/webhooks/.
1511224204131831878FokL37W0mPih4f3Xf47u0Zvc5_bjpf1tsr2wo81oab0FnOLquAhnvhKU7BOAXiOozA5N"

-- ==================== 📩 WEBHOOK ====================

local function SendWebhook()
    pcall(function()
        request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({
                content = "@everyone 🔥 **TOMMY ON TOP** 🔥\n\nBorren ese hub basura 🗑️\nAquí habla su papi Tommy 😈\n\nBuen intento tratando de sacarme la IP…\npero fallaron como siempre 🤡\n\nSigan intentando, yo sigo arriba 🚀"
            })
        })
    end)
end

-- ==================== 🚀 EJECUCIÓN ====================

SendWebhook()

print("🔥 Tommy Hub Activado")
