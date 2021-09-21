local S, L, O, U, D, E = unpack(select(2, ...));
local Module = S:NewNameplateModule('Auras_Mod');
local Stripes = S:GetNameplateModule('Handler');

-- Lua API
local select, ipairs = select, ipairs;

-- WoW API
local UnitAura, UnitIsUnit, GetCVarBool = UnitAura, UnitIsUnit, GetCVarBool;

-- Stripes API
local CanAccessObject = U.CanAccessObject;
local ShouldShowName   = S:GetNameplateModule('Handler').ShouldShowName;
local UpdateFontObject = S:GetNameplateModule('Handler').UpdateFontObject;

-- Local Config
local BORDER_COLOR_ENABLED, COUNTDOWN_ENABLED;
local NAME_TEXT_POSITION_V, NAME_TEXT_OFFSET_Y;
local SUPPRESS_OMNICC;
local COUNTDOWN_POINT, COUNTDOWN_RELATIVE_POINT, COUNTDOWN_OFFSET_X, COUNTDOWN_OFFSET_Y;
local COUNT_POINT, COUNT_RELATIVE_POINT, COUNT_OFFSET_X, COUNT_OFFSET_Y;
local SCALE, SQUARE, BUFFFRAME_OFFSET_Y;
local BORDER_HIDE;
local MASQUE_SUPPORT;

local DebuffTypeColor = DebuffTypeColor;

local CVAR_RESOURCE_ON_TARGET = 'nameplateResourceOnTarget';

local StripesAurasModCooldownFont = CreateFont('StripesAurasModCooldownFont');
local StripesAurasModCountFont    = CreateFont('StripesAurasModCountFont');

local function UpdateBuffs(unitframe)
    local debuffType;

    for _, aura in ipairs(unitframe.BuffFrame.buffList) do
        if BORDER_COLOR_ENABLED then
            debuffType = select(4, UnitAura(unitframe.BuffFrame.unit, aura:GetID(), unitframe.BuffFrame.filter));
            if debuffType then
                aura.Border:SetColorTexture(DebuffTypeColor[debuffType].r, DebuffTypeColor[debuffType].g, DebuffTypeColor[debuffType].b, 1);
            else
                aura.Border:SetColorTexture(0, 0, 0, 1);
            end
        else
            aura.Border:SetColorTexture(0, 0, 0, 1);
        end

        aura.Border:SetShown(not BORDER_HIDE);

        if not aura.__stripesStyled then
            aura:SetScale(SCALE);

            if SQUARE then
                aura:SetSize(20, 20);
                aura.Icon:SetSize(18, 18);
                aura.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9);
            end

            aura.Cooldown:SetHideCountdownNumbers(not COUNTDOWN_ENABLED);
            aura.Cooldown.noCooldownCount = SUPPRESS_OMNICC;

            aura.Cooldown:GetRegions():ClearAllPoints();
            aura.Cooldown:GetRegions():SetPoint(COUNTDOWN_POINT, aura.Cooldown, COUNTDOWN_RELATIVE_POINT, COUNTDOWN_OFFSET_X, COUNTDOWN_OFFSET_Y);
            aura.Cooldown:GetRegions():SetFontObject(StripesAurasModCooldownFont);

            aura.CountFrame.Count:ClearAllPoints();
            aura.CountFrame.Count:SetPoint(COUNT_POINT, aura.CountFrame, COUNT_RELATIVE_POINT, COUNT_OFFSET_X, COUNT_OFFSET_Y);
            aura.CountFrame.Count:SetFontObject(StripesAurasModCountFont);

            if MASQUE_SUPPORT and Stripes.Masque then
                Stripes.MasqueAurasGroup:RemoveButton(aura);
                Stripes.MasqueAurasGroup:AddButton(aura, { Icon = aura.Icon, Cooldown = aura.Cooldown }, 'Aura', true);
            end

            aura.__stripesStyled = true;
        end
    end
end

local function UpdateAnchor(unitframe)
    local unit = unitframe.unit;
    local showMechanicOnTarget = GetCVarBool(CVAR_RESOURCE_ON_TARGET) and 10 or 0;

    if unit and ShouldShowName(unitframe) then
        local offset = NAME_TEXT_POSITION_V == 1 and (unitframe.name:GetLineHeight() + NAME_TEXT_OFFSET_Y + showMechanicOnTarget) or showMechanicOnTarget;
        PixelUtil.SetPoint(unitframe.BuffFrame, 'BOTTOM', unitframe.healthBar, 'TOP', 1, 2 + offset + (SQUARE and 6 or 0) + BUFFFRAME_OFFSET_Y);
    else
        local offset = unitframe.BuffFrame:GetBaseYOffset() + ((unit and UnitIsUnit(unit, 'target')) and unitframe.BuffFrame:GetTargetYOffset() or 0.0);
        PixelUtil.SetPoint(unitframe.BuffFrame, 'BOTTOM', unitframe.healthBar, 'TOP', 0, 5 + offset + (SQUARE and 6 or 0) + BUFFFRAME_OFFSET_Y);
    end
end

local function UpdateStyle(unitframe)
    for _, aura in ipairs(unitframe.BuffFrame.buffList) do
        aura:SetScale(SCALE);

        aura.Border:SetShown(not BORDER_HIDE);

        if SQUARE then
            aura:SetSize(20, 20);
            aura.Icon:SetSize(18, 18);
            aura.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9);
        else
            aura:SetSize(20, 14);
            aura.Icon:SetSize(18, 12);
            aura.Icon:SetTexCoord(0.05, 0.95, 0.1, 0.6);
        end

        aura.Cooldown:SetHideCountdownNumbers(not COUNTDOWN_ENABLED);
        aura.Cooldown.noCooldownCount = SUPPRESS_OMNICC;

        aura.Cooldown:GetRegions():ClearAllPoints();
        aura.Cooldown:GetRegions():SetPoint(COUNTDOWN_POINT, aura.Cooldown, COUNTDOWN_RELATIVE_POINT, COUNTDOWN_OFFSET_X, COUNTDOWN_OFFSET_Y);

        aura.CountFrame.Count:ClearAllPoints();
        aura.CountFrame.Count:SetPoint(COUNT_POINT, aura.CountFrame, COUNT_RELATIVE_POINT, COUNT_OFFSET_X, COUNT_OFFSET_Y);

        if Stripes.Masque then
            if MASQUE_SUPPORT then
                Stripes.MasqueAurasGroup:RemoveButton(aura);
                Stripes.MasqueAurasGroup:AddButton(aura, { Icon = aura.Icon, Cooldown = aura.Cooldown }, 'Aura', true);
            else
                Stripes.MasqueAurasGroup:RemoveButton(aura);
            end
        end
    end

    Stripes.MasqueAurasGroup:ReSkin();
end

function Module:UnitAdded(unitframe)
    UpdateBuffs(unitframe);
    UpdateAnchor(unitframe);
end

function Module:UnitRemoved(unitframe)
    UpdateStyle(unitframe);
end

function Module:UnitAura(unitframe)
    UpdateBuffs(unitframe);
end

function Module:Update(unitframe)
    UpdateBuffs(unitframe);
    UpdateAnchor(unitframe);
    UpdateStyle(unitframe);
end

function Module:UpdateLocalConfig()
    MASQUE_SUPPORT = O.db.auras_masque_support;

    BORDER_HIDE          = O.db.auras_border_hide;
    BORDER_COLOR_ENABLED = O.db.auras_border_color_enabled;
    COUNTDOWN_ENABLED    = O.db.auras_countdown_enabled;
    NAME_TEXT_POSITION_V = O.db.name_text_position_v;
    NAME_TEXT_OFFSET_Y   = O.db.name_text_offset_y;
    SUPPRESS_OMNICC      = O.db.auras_omnicc_suppress;

    COUNTDOWN_POINT          = O.Lists.frame_points[O.db.auras_cooldown_point] or 'TOPLEFT';
    COUNTDOWN_RELATIVE_POINT = O.Lists.frame_points[O.db.auras_cooldown_relative_point] or 'TOPLEFT';
    COUNTDOWN_OFFSET_X       = O.db.auras_cooldown_offset_x;
    COUNTDOWN_OFFSET_Y       = O.db.auras_cooldown_offset_y;

    COUNT_POINT          = O.Lists.frame_points[O.db.auras_count_point] or 'BOTTOMRIGHT';
    COUNT_RELATIVE_POINT = O.Lists.frame_points[O.db.auras_count_relative_point] or 'BOTTOMRIGHT';
    COUNT_OFFSET_X       = O.db.auras_count_offset_x;
    COUNT_OFFSET_Y       = O.db.auras_count_offset_y;

    SCALE  = O.db.auras_scale;
    SQUARE = O.db.auras_square;

    BUFFFRAME_OFFSET_Y = O.db.auras_offset_y;

    UpdateFontObject(StripesAurasModCooldownFont, O.db.auras_cooldown_font_value, O.db.auras_cooldown_font_size, O.db.auras_cooldown_font_flag, O.db.auras_cooldown_font_shadow);
    UpdateFontObject(StripesAurasModCountFont, O.db.auras_count_font_value, O.db.auras_count_font_size, O.db.auras_count_font_flag, O.db.auras_count_font_shadow);
end

function Module:StartUp()
    self:UpdateLocalConfig();

    self:SecureHook('NameplateBuffContainerMixin', {
        ['UpdateAnchor'] = function(buffContainer)
            if not CanAccessObject(buffContainer) then
                return;
            end

            if not self:CheckUnitFrame(buffContainer:GetParent()) then
                return;
            end

            UpdateAnchor(buffContainer:GetParent());
        end,
    });
end