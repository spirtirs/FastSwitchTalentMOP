local iconFixer = CreateFrame("Frame")

local function FixSpecIcons()
    if not PlayerTalentFrameSpecialization then return end
    
    for i = 1, GetNumSpecializations() do
        local button = PlayerTalentFrameSpecialization["specButton"..i]
        if button and button.specIcon then
            local id, name, description, icon = GetSpecializationInfo(i)
            if icon then
                button.specIcon:SetTexture(icon)
                button.specIcon:SetTexCoord(0, 1, 0, 1)
            end
        end
    end
end

iconFixer:RegisterEvent("ADDON_LOADED")
iconFixer:RegisterEvent("PLAYER_TALENT_UPDATE")
iconFixer:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
iconFixer:RegisterEvent("PLAYER_ENTERING_WORLD")

iconFixer:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addon = ...
        if addon == "Blizzard_TalentUI" then
            -- Хук на показ окна талантов
            PlayerTalentFrame:HookScript("OnShow", FixSpecIcons)
            -- Сразу пробуем исправить
            FixSpecIcons()
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        -- Пробуем исправить после входа в игру
        C_Timer.After(1, FixSpecIcons)
    else
        -- Для остальных событий просто пытаемся исправить
        FixSpecIcons()
    end
end) 