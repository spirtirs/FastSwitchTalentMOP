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
    if IsLoggedIn() and select(2,UnitClass("player"))=="WARRIOR" then
    SetMacroSpell("Tier1Macro", GetSpellInfo("Неудержимость") or GetSpellInfo("Удвоенное время") or GetSpellInfo("Вестник войны"))
    SetMacroSpell("Tier2Macro", GetSpellInfo("Безудержное восстановление") or GetSpellInfo("Верная победа") or GetSpellInfo("Второе дыхание") or GetSpellInfo("Победный раж"))
    SetMacroSpell("Tier3Macro", GetSpellInfo("Ошеломляющий крик") or GetSpellInfo("Пронзительный вой") or GetSpellInfo("Разрушительный крик"))
    SetMacroSpell("Tier4Macro", GetSpellInfo("Вихрь клинков") or GetSpellInfo("Рев дракона") or GetSpellInfo("Ударная волна"))
    SetMacroSpell("Tier5Macro", GetSpellInfo("Массовое отражение заклинания") or GetSpellInfo("Охрана") or GetSpellInfo("Бдительность"))
    SetMacroSpell("Tier6Macro", GetSpellInfo("Аватара") or GetSpellInfo("Кровавая баня") or GetSpellInfo("Удар громовержца"))
    else return end
end
local f = a or CreateFrame("Frame", "a")
f:SetScript("OnEvent", m)
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("SPELLS_CHANGED") 
f:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
	