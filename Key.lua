local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- [НАСТРОЙКИ ДОСТУПА]
local VALID_KEY = "Update1"
local SCRIPT_URL = "https://raw.githubusercontent.com/pavelsteam00-hash/Trident/refs/heads/main/Trident.lua"

local Window = Fluent:CreateWindow({
    Title = "Trident Survival | Authorization",
    SubTitle = "Beta Test Access",
    TabWidth = 160,
    Size = UDim2.fromOffset(400, 320), -- Немного увеличил высоту для текста
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local AuthTab = Window:AddTab({ Title = "Auth", Icon = "lock" })

-- Инструкция для пользователя
AuthTab:AddParagraph({
    Title = "Как получить ключ?",
    Content = "Чтобы получить ключ, скопируйте ссылку ниже и перейдите в наш Telegram канал."
})

-- Поле ввода
local KeyInput = AuthTab:AddInput("KeyInput", {
    Title = "", 
    Default = "",
    Placeholder = "Вставьте ключ здесь...",
    Numeric = false,
    Finished = false, 
    Password = true, 
    Callback = function(Value) end
})

AuthTab:AddButton({
    Title = "Verify and Launch",
    Description = "Проверить ключ и запустить скрипт",
    Callback = function()
        if KeyInput.Value == VALID_KEY then
            Fluent:Notify({
                Title = "Успешно",
                Content = "Доступ разрешен! Загрузка...",
                Duration = 3
            })
            
            Window:Destroy()
            
            local success, err = pcall(function()
                local raw_code = game:HttpGet(SCRIPT_URL)
                loadstring(raw_code)()
            end)
            
            if not success then
                warn("Ошибка загрузки: " .. tostring(err))
            end
        else
            Fluent:Notify({
                Title = "Ошибка",
                Content = "Неверный ключ! Попробуйте снова.",
                Duration = 5
            })
        end
    end
})

AuthTab:AddButton({
    Title = "Copy Support Link",
    Description = "Скопировать ссылку на Telegram",
    Callback = function()
        setclipboard("https://t.me/Goodhub1season") 
        Fluent:Notify({
            Title = "Скопировано",
            Content = "Ссылка на Telegram скопирована в буфер обмена!",
            Duration = 3
        })
    end
})

Window:SelectTab(1)
