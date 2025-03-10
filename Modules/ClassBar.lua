local S, L, O, U, D, E = unpack((select(2, ...)));
local Module = S:NewNameplateModule('ClassBar');

-- Local Config
local ALPHA, SCALE, POINT, RELATIVE_POINT, OFFSET_X, OFFSET_Y;
local SHOW_ON_TARGET;

local function UpdatePosition(unitframe)
    if not SHOW_ON_TARGET then
        return;
    end

    if not NamePlateDriverFrame.classNamePlateMechanicFrame then
        return;
    end

    if unitframe.data.isPersonal then
        if NamePlateDriverFrame.classNamePlatePowerBar then
            NamePlateDriverFrame.classNamePlateMechanicFrame:ClearAllPoints();
            NamePlateDriverFrame.classNamePlateMechanicFrame:SetPoint('TOP', NamePlateDriverFrame.classNamePlatePowerBar, 'BOTTOM', 0, NamePlateDriverFrame.classNamePlateMechanicFrame.paddingOverride or -4);
        end
    else
        if unitframe.data.isTarget then
            NamePlateDriverFrame.classNamePlateMechanicFrame:ClearAllPoints();
            PixelUtil.SetPoint(NamePlateDriverFrame.classNamePlateMechanicFrame, POINT, unitframe.healthBar, RELATIVE_POINT, OFFSET_X, OFFSET_Y);
        end
    end
end

local function UpdateAlphaAndScale()
    if NamePlateDriverFrame.classNamePlateMechanicFrame then
        NamePlateDriverFrame.classNamePlateMechanicFrame:SetAlpha(ALPHA);
        NamePlateDriverFrame.classNamePlateMechanicFrame:SetScale(SCALE);
    end
end

function Module:UnitAdded(unitframe)
    UpdatePosition(unitframe);
end

function Module:Update(unitframe)
    UpdatePosition(unitframe);
end

function Module:UpdateLocalConfig()
    ALPHA = O.db.class_bar_alpha;
    SCALE = O.db.class_bar_scale;

    POINT          = O.Lists.frame_points[O.db.class_bar_point] or 'BOTTOM';
    RELATIVE_POINT = O.Lists.frame_points[O.db.class_bar_relative_point] or 'TOP';
    OFFSET_X       = O.db.class_bar_offset_x;
    OFFSET_Y       = O.db.class_bar_offset_y;

    SHOW_ON_TARGET = O.db.show_personal_resource_ontarget;

    UpdateAlphaAndScale();
end

function Module:StartUp()
    self:UpdateLocalConfig();
    self:SecureUnitFrameHook('CompactUnitFrame_UpdateSelectionHighlight', UpdatePosition);
end