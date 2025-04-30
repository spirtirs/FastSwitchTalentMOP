local macro = CreateFrame('button', nil, nil, 'SecureActionButtonTemplate')macro:SetAttribute('type', 'macro')
macro:SetScript('OnLeave', function(self)
    self:Hide()
    GameTooltip_Hide()
    self:GetParent():SetScript('OnLeave', GameTooltip_Hide)
end) 
hooksecurefunc('PlayerTalentFrameTalent_OnEnter', function(self)
    if InCombatLockdown() then return end
    local _, _, _, _, selected, available = GetTalentInfo(self:GetID())
    if not selected and not available then
        macro:SetParent(self)
        macro:ClearAllPoints()
        macro:SetPoint('TOPLEFT', nil, 'BOTTOMLEFT', self:GetLeft(), self:GetTop())
        macro:SetSize(self:GetSize())
        self:SetScript('OnLeave', nil)
        macro:SetAttribute('macrotext', format('/click %s\n/click StaticPopup1Button1', self:GetName()))
        macro:Show()
    end
end)

local function m()
    if IsLoggedIn() and select(2, UnitClass("player")) == "WARRIOR" then
        -- Получаем индексы макросов
        local tier1Macro = GetMacroIndexByName("Tier1Macro")
        local tier2Macro = GetMacroIndexByName("Tier2Macro")
        local tier3Macro = GetMacroIndexByName("Tier3Macro")
        local tier4Macro = GetMacroIndexByName("Tier4Macro")
        local tier5Macro = GetMacroIndexByName("Tier5Macro")
        local tier6Macro = GetMacroIndexByName("Tier6Macro")

        -- Функция для получения первого доступного заклинания
        local function GetFirstAvailableSpell(...)
            for i = 1, select("#", ...) do
                local spell = select(i, ...)
                -- Проверяем русское название
                local spellID = GetSpellInfo(spell)
                if spellID then 
                    return spellID 
                end
                -- Проверяем английское название
                local enSpell = spell == "Неудержимость" and "Recklessness" or
                               spell == "Удвоенное время" and "Double Time" or
                               spell == "Вестник войны" and "War Banner" or
                               spell == "Безудержное восстановление" and "Reckless Abandon" or
                               spell == "Верная победа" and "Safeguard" or
                               spell == "Второе дыхание" and "Second Wind" or
                               spell == "Победный раж" and "Victory Rush" or
                               spell == "Ошеломляющий крик" and "Disrupting Shout" or
                               spell == "Пронзительный вой" and "Piercing Howl" or
                               spell == "Разрушительный крик" and "Shattering Throw" or
                               spell == "Вихрь клинков" and "Bladestorm" or
                               spell == "Рев дракона" and "Dragon Roar" or
                               spell == "Ударная волна" and "Shockwave" or
                               spell == "Массовое отражение заклинания" and "Mass Spell Reflection" or
                               spell == "Охрана" and "Safeguard" or
                               spell == "Бдительность" and "Vigilance" or
                               spell == "Аватара" and "Avatar" or
                               spell == "Кровавая баня" and "Bloodbath" or
                               spell == "Удар громовержца" and "Storm Bolt"
                if enSpell then
                    spellID = GetSpellInfo(enSpell)
                    if spellID then
                        return spellID
                    end
                end
            end
            return nil
        end

        -- Устанавливаем заклинания для каждого тира
        if tier1Macro > 0 then 
            local spell = GetFirstAvailableSpell(
                "Неудержимость",
                "Удвоенное время",
                "Вестник войны"
            )
            if spell then 
                SetMacroSpell(tier1Macro, spell) 
            end
        end

        if tier2Macro > 0 then 
            local spell = GetFirstAvailableSpell(
                "Безудержное восстановление",
                "Верная победа",
                "Второе дыхание",
                "Победный раж"
            )
            if spell then 
                SetMacroSpell(tier2Macro, spell) 
            end
        end

        if tier3Macro > 0 then 
            local spell = GetFirstAvailableSpell(
                "Ошеломляющий крик",
                "Пронзительный вой",
                "Разрушительный крик"
            )
            if spell then 
                SetMacroSpell(tier3Macro, spell) 
            end
        end

        if tier4Macro > 0 then 
            local spell = GetFirstAvailableSpell(
                "Вихрь клинков",
                "Рев дракона",
                "Ударная волна"
            )
            if spell then 
                SetMacroSpell(tier4Macro, spell) 
            end
        end

        if tier5Macro > 0 then 
            local spell = GetFirstAvailableSpell(
                "Массовое отражение заклинания",
                "Охрана",
                "Бдительность"
            )
            if spell then 
                SetMacroSpell(tier5Macro, spell) 
            end
        end

        if tier6Macro > 0 then 
            local spell = GetFirstAvailableSpell(
                "Аватара",
                "Кровавая баня",
                "Удар громовержца"
            )
            if spell then 
                SetMacroSpell(tier6Macro, spell) 
            end
        end
    else 
        return 
    end
end
local f = a or CreateFrame("Frame", "a")
f:SetScript("OnEvent", m)
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("SPELLS_CHANGED") 
f:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
	