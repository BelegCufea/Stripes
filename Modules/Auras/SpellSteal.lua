local S, L, O, U, D, E = unpack(select(2, ...));
local Module = S:NewNameplateModule('Auras_SpellSteal');

-- WoW API
local CooldownFrame_Set, GetCVarBool, UnitIsUnit, GetTime, AuraUtil_ForEachAura = CooldownFrame_Set, GetCVarBool, UnitIsUnit, GetTime, AuraUtil.ForEachAura;

-- Stripes API
local ShouldShowName = S:GetNameplateModule('Handler').ShouldShowName;
local UpdateFontObject = S:GetNameplateModule('Handler').UpdateFontObject;

-- Local Config
local ENABLED, COUNTDOWN_ENABLED;
local NAME_TEXT_POSITION_V, NAME_TEXT_OFFSET_Y;
local SUPPRESS_OMNICC;
local COUNTDOWN_POINT, COUNTDOWN_RELATIVE_POINT, COUNTDOWN_OFFSET_X, COUNTDOWN_OFFSET_Y;
local COUNT_POINT, COUNT_RELATIVE_POINT, COUNT_OFFSET_X, COUNT_OFFSET_Y;
local SCALE, SQUARE, BUFFFRAME_OFFSET_Y;
local GLOW_ENABLED, GLOW_TYPE;

-- Libraries
local LCG = S.Libraries.LCG;

local StripesAurasSpellStealCooldownFont = CreateFont('StripesAurasSpellStealCooldownFont');
local StripesAurasSpellStealCountFont    = CreateFont('StripesAurasSpellStealCountFont');

local BUFF_MAX_DISPLAY = BUFF_MAX_DISPLAY;
local filter = 'HELPFUL';
local CVAR_RESOURCE_ON_TARGET = 'nameplateResourceOnTarget';

local function CreateAnchor(unitframe)
    if unitframe.AurasSpellSteal then
        return;
    end

    local frame = CreateFrame('Frame', '$parentAurasSpellSteal', unitframe);
    frame:SetPoint('LEFT', unitframe.healthBar, 'LEFT', -1, 0);
    frame:SetPoint('BOTTOM', unitframe.BuffFrame, 'TOP', 0, 4);
    frame:SetHeight(14);

    frame.buffList = {};

    unitframe.AurasSpellSteal = frame;
end

local function UpdateAnchor(unitframe)
    if not unitframe.BuffFrame.buffList[1] or not unitframe.BuffFrame.buffList[1]:IsShown() then
        local showMechanicOnTarget = GetCVarBool(CVAR_RESOURCE_ON_TARGET) and 10 or 0;

        if ShouldShowName(unitframe) then
            local offset = NAME_TEXT_POSITION_V == 1 and (unitframe.name:GetLineHeight() + NAME_TEXT_OFFSET_Y + showMechanicOnTarget) or showMechanicOnTarget;
            PixelUtil.SetPoint(unitframe.AurasSpellSteal, 'BOTTOM', unitframe.healthBar, 'TOP', 1, 2 + offset + (SQUARE and 6 or 0) + BUFFFRAME_OFFSET_Y);
        else
            local offset = unitframe.BuffFrame:GetBaseYOffset() + (UnitIsUnit(unitframe.data.unit, 'target') and unitframe.BuffFrame:GetTargetYOffset() or 0.0);
            PixelUtil.SetPoint(unitframe.AurasSpellSteal, 'BOTTOM', unitframe.healthBar, 'TOP', 0, 5 + offset + (SQUARE and 6 or 0) + BUFFFRAME_OFFSET_Y);
        end
    else
        unitframe.AurasSpellSteal:SetPoint('BOTTOM', unitframe.BuffFrame, 'TOP', 0, 4);
    end
end

local function UpdateGlow(aura)
    if not GLOW_ENABLED then
        return;
    end

    if GLOW_TYPE == 1 then
        LCG.PixelGlow_Start(aura);
    elseif GLOW_TYPE == 2 then
        LCG.AutoCastGlow_Start(aura);
    elseif GLOW_TYPE == 3 then
        LCG.ButtonGlow_Start(aura);
    end
end

local function StopGlow(aura)
    LCG.PixelGlow_Stop(aura);
    LCG.AutoCastGlow_Stop(aura);
    LCG.ButtonGlow_Stop(aura);
end

local function Update(unitframe)
    if not ENABLED or not unitframe.data.unit or unitframe.data.unitType == 'SELF' then
        unitframe.AurasSpellSteal:SetShown(false);
        return;
    end

    unitframe.AurasSpellSteal.unit   = unitframe.data.unit;
    unitframe.AurasSpellSteal.filter = filter;

    local buffIndex = 1;
    local index = 1;

    local _, texture, count, duration, expirationTime, isStealable;
    local aura;

    AuraUtil_ForEachAura(unitframe.AurasSpellSteal.unit, unitframe.AurasSpellSteal.filter, BUFF_MAX_DISPLAY, function(...)
        _, texture, count, _, duration, expirationTime, _, isStealable = ...;

        if isStealable then
            aura = unitframe.AurasSpellSteal.buffList[buffIndex];

            if not aura then
                aura = CreateFrame('Frame', nil, unitframe.AurasSpellSteal, 'NameplateBuffButtonTemplate');
                aura:SetMouseClickEnabled(false);
                aura.layoutIndex = buffIndex;

                aura:SetScale(SCALE);

                if SQUARE then
                    aura:SetSize(20, 20);
                    aura.Icon:SetSize(18, 18);
                    aura.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9);
                end

                aura.Cooldown:GetRegions():ClearAllPoints();
                aura.Cooldown:GetRegions():SetPoint(COUNTDOWN_POINT, aura.Cooldown, COUNTDOWN_RELATIVE_POINT, COUNTDOWN_OFFSET_X, COUNTDOWN_OFFSET_Y);
                aura.Cooldown:GetRegions():SetFontObject(StripesAurasSpellStealCooldownFont);
                aura.Cooldown.noCooldownCount = SUPPRESS_OMNICC;

                aura.CountFrame.Count:ClearAllPoints();
                aura.CountFrame.Count:SetPoint(COUNT_POINT, aura.CountFrame, COUNT_RELATIVE_POINT, COUNT_OFFSET_X, COUNT_OFFSET_Y);
                aura.CountFrame.Count:SetFontObject(StripesAurasSpellStealCountFont);

                aura.Border:SetColorTexture(unpack(O.db.auras_spellsteal_color));

                unitframe.AurasSpellSteal.buffList[buffIndex] = aura;
            end

            aura:ClearAllPoints();
            aura:SetPoint('TOPLEFT', (buffIndex - 1) * 22, 0);

            aura:SetID(index);

            aura.Icon:SetTexture(texture);

            if count > 1 then
                aura.CountFrame.Count:SetText(count);
                aura.CountFrame.Count:SetShown(true);
            else
                aura.CountFrame.Count:SetShown(false);
            end

            CooldownFrame_Set(aura.Cooldown, expirationTime - duration, duration, duration > 0, true);

            if expirationTime - GetTime() >= 3600 then
                aura.Cooldown:SetHideCountdownNumbers(true);
            else
                aura.Cooldown:SetHideCountdownNumbers(not COUNTDOWN_ENABLED);
            end

            StopGlow(aura);
            UpdateGlow(aura);

            aura:SetShown(true);

            buffIndex = buffIndex + 1;
        end

        index = index + 1;

        return buffIndex > BUFF_MAX_DISPLAY;
    end);

    for i = buffIndex, BUFF_MAX_DISPLAY do
        if unitframe.AurasSpellSteal.buffList[i] then
            unitframe.AurasSpellSteal.buffList[i]:SetShown(false);
        else
            break;
        end
    end

    if buffIndex > 1 then
        if not unitframe.AurasSpellSteal:IsShown() then
            unitframe.AurasSpellSteal:SetShown(true);
        end

        UpdateAnchor(unitframe);
    else
        if unitframe.AurasSpellSteal:IsShown() then
            unitframe.AurasSpellSteal:SetShown(false);
        end
    end
end

local function UpdateStyle(unitframe)
    for _, aura in ipairs(unitframe.AurasSpellSteal.buffList) do
        aura:SetScale(SCALE);

        if SQUARE then
            aura:SetSize(20, 20);
            aura.Icon:SetSize(18, 18);
            aura.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9);
        else
            aura:SetSize(20, 14);
            aura.Icon:SetSize(18, 12);
            aura.Icon:SetTexCoord(0.05, 0.95, 0.1, 0.6);
        end

        aura.Cooldown.noCooldownCount = SUPPRESS_OMNICC;
        aura.Border:SetColorTexture(unpack(O.db.auras_spellsteal_color));

        aura.Cooldown:GetRegions():ClearAllPoints();
        aura.Cooldown:GetRegions():SetPoint(COUNTDOWN_POINT, aura.Cooldown, COUNTDOWN_RELATIVE_POINT, COUNTDOWN_OFFSET_X, COUNTDOWN_OFFSET_Y);

        aura.CountFrame.Count:ClearAllPoints();
        aura.CountFrame.Count:SetPoint(COUNT_POINT, aura.CountFrame, COUNT_RELATIVE_POINT, COUNT_OFFSET_X, COUNT_OFFSET_Y);

        StopGlow(aura);
        UpdateGlow(aura);
    end
end

local function Reset(unitframe)
    if unitframe.AurasSpellSteal and unitframe.AurasSpellSteal.buffList then
        for _, aura in ipairs(unitframe.AurasSpellSteal.buffList) do
            StopGlow(aura);
        end
    end
end

function Module:UnitAdded(unitframe)
    CreateAnchor(unitframe);
    Update(unitframe);
end

function Module:UnitRemoved(unitframe)
    if unitframe.AurasSpellSteal then
        unitframe.AurasSpellSteal:SetShown(false);
    end

    Reset(unitframe);
end

function Module:UnitAura(unitframe)
    Update(unitframe);
end

function Module:Update(unitframe)
    Update(unitframe);
    UpdateStyle(unitframe);
end

function Module:UpdateLocalConfig()
    ENABLED              = O.db.auras_spellsteal_enabled;
    COUNTDOWN_ENABLED    = O.db.auras_spellsteal_countdown_enabled;
    NAME_TEXT_POSITION_V = O.db.name_text_position_v;
    NAME_TEXT_OFFSET_Y   = O.db.name_text_offset_y;
    SUPPRESS_OMNICC      = O.db.auras_omnicc_suppress;

    COUNTDOWN_POINT          = O.Lists.frame_points[O.db.auras_spellsteal_cooldown_point] or 'TOPLEFT';
    COUNTDOWN_RELATIVE_POINT = O.Lists.frame_points[O.db.auras_spellsteal_cooldown_relative_point] or 'TOPLEFT';
    COUNTDOWN_OFFSET_X       = O.db.auras_spellsteal_cooldown_offset_x;
    COUNTDOWN_OFFSET_Y       = O.db.auras_spellsteal_cooldown_offset_y;

    COUNT_POINT          = O.Lists.frame_points[O.db.auras_spellsteal_count_point] or 'BOTTOMRIGHT';
    COUNT_RELATIVE_POINT = O.Lists.frame_points[O.db.auras_spellsteal_count_relative_point] or 'BOTTOMRIGHT';
    COUNT_OFFSET_X       = O.db.auras_spellsteal_count_offset_x;
    COUNT_OFFSET_Y       = O.db.auras_spellsteal_count_offset_y;

    SCALE  = O.db.auras_scale;
    SQUARE = O.db.auras_square;

    BUFFFRAME_OFFSET_Y = O.db.auras_offset_y;

    GLOW_ENABLED = O.db.auras_spellsteal_glow_enabled;
    GLOW_TYPE    = O.db.auras_spellsteal_glow_type;

    UpdateFontObject(StripesAurasSpellStealCooldownFont, O.db.auras_spellsteal_cooldown_font_value, O.db.auras_spellsteal_cooldown_font_size, O.db.auras_spellsteal_cooldown_font_flag, O.db.auras_spellsteal_cooldown_font_shadow);
    UpdateFontObject(StripesAurasSpellStealCountFont, O.db.auras_spellsteal_count_font_value, O.db.auras_spellsteal_count_font_size, O.db.auras_spellsteal_count_font_flag, O.db.auras_spellsteal_count_font_shadow);
end

function Module:StartUp()
    self:UpdateLocalConfig();
end