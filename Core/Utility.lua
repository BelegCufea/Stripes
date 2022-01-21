local S, L, O, U, D, E = unpack(select(2, ...));

-- Lua API
local pairs, ipairs, select, type, unpack, tostring, tonumber, string_format, string_len, string_sub, string_gsub, string_byte, math_floor = pairs, ipairs, select, type, unpack, tostring, tonumber, string.format, string.len, string.sub, string.gsub, string.byte, math.floor;

-- WoW/Lua API
local strsplit = strsplit;

-- WoW API
local UnitClassBase, UnitIsTapDenied, UnitIsDeadOrGhost, UnitIsConnected, UnitIsPlayer, UnitPlayerControlled, UnitSelectionColor, GetPlayerInfoByGUID =
      UnitClassBase, UnitIsTapDenied, UnitIsDeadOrGhost, UnitIsConnected, UnitIsPlayer, UnitPlayerControlled, UnitSelectionColor, GetPlayerInfoByGUID;
local UnitLevel, UnitEffectiveLevel, UnitGUID, UnitAffectingCombat, UnitClassification, UnitTreatAsPlayerForDisplay =
      UnitLevel, UnitEffectiveLevel, UnitGUID, UnitAffectingCombat, UnitClassification, UnitTreatAsPlayerForDisplay;
local UnitGroupRolesAssigned, GetSpecialization, GetSpecializationRole = UnitGroupRolesAssigned, GetSpecialization, GetSpecializationRole;
local UnitCastingInfo, UnitChannelInfo = UnitCastingInfo, UnitChannelInfo;
local GetQuestDifficultyColor = GetQuestDifficultyColor;
local IsInGuild, GetGuildInfo = IsInGuild, GetGuildInfo;
local IsActiveBattlefieldArena, GetZonePVPInfo, IsInInstance, UnitInBattleground, C_Map_GetBestMapForUnit = IsActiveBattlefieldArena, GetZonePVPInfo, IsInInstance, UnitInBattleground, C_Map.GetBestMapForUnit
local GetSpellInfo, IsSpellKnown, IsSpellKnownOrOverridesKnown, IsPlayerSpell = GetSpellInfo, IsSpellKnown, IsSpellKnownOrOverridesKnown, IsPlayerSpell;

-- WoW C API
local C_MythicPlus_GetCurrentAffixes, C_ChallengeMode_GetActiveKeystoneInfo = C_MythicPlus.GetCurrentAffixes, C_ChallengeMode.GetActiveKeystoneInfo;

local EMPTY_STRING = '';
local PLAYER_UNIT = 'player';
local PET_UNIT    = 'pet';

U.TooltipScanner = CreateFrame('GameTooltip', 'Stripes_TooltipScanner', nil, 'SharedTooltipTemplate');
U.TooltipScanner.Name = 'Stripes_TooltipScanner';
U.TooltipScanner:SetOwner(UIParent, 'ANCHOR_NONE');
U.TooltipScanner:SetScript('OnTooltipAddMoney', nil);
U.TooltipScanner:SetScript('OnTooltipCleared', nil);

U.Print = function(message, debug)
    if not message or message == EMPTY_STRING then
        return;
    end

    if debug and S.Debug then
        print(string_format('%s | DEBUG | %s', S.Media.GRADIENT_NAME, message));
    else
        print(string_format('%s | %s', S.Media.GRADIENT_NAME, message));
    end
end

U.CanAccessObject = function(obj)
    return issecure() or not obj:IsForbidden();
end

U.PlayerInCombat = function()
    return (InCombatLockdown() or (UnitAffectingCombat(PLAYER_UNIT) or UnitAffectingCombat(PET_UNIT)));
end

U.UnitIsTapped = function(unit)
    return not UnitPlayerControlled(unit) and UnitIsTapDenied(unit);
end

U.IsPlayer = function(unit)
    return UnitIsPlayer(unit) or UnitTreatAsPlayerForDisplay(unit);
end

U.UnitIsPet = function(unit)
    return (not UnitIsPlayer(unit) and UnitPlayerControlled(unit));
end

U.PlayerInGuild = function()
    return IsInGuild() and GetGuildInfo(PLAYER_UNIT);
end

U.UnitInGuild = function(unit)
    return GetGuildInfo(unit);
end

U.UnitIsCasting = function(unit)
    local spellId = select(9, UnitCastingInfo(unit));

    if not spellId then
        spellId = select(8, UnitChannelInfo(unit));
    end

    return spellId;
end

U.IsPlayerEffectivelyTank = function ()
	local assignedRole = UnitGroupRolesAssigned(PLAYER_UNIT);

	if assignedRole == 'NONE' then
		local spec = GetSpecialization();
		return spec and GetSpecializationRole(spec) == 'TANK';
	end

	return assignedRole == 'TANK';
end

U.IsInArena = function()
    if IsActiveBattlefieldArena() or GetZonePVPInfo() == 'arena' or select(2, IsInInstance()) == 'arena' or (UnitInBattleground(PLAYER_UNIT) and (C_Map_GetBestMapForUnit(PLAYER_UNIT) and C_Map_GetBestMapForUnit(PLAYER_UNIT) < 0)) then
        return true;
    else
        return false;
    end
end

do
    local UNIT_CREATURE_LINK = 'unit:Creature-0-0-0-0-%d';
    local UNKNOWN = UNKNOWN;

    U.GetNpcNameByID = function(id)
        if not id or id == 0 then
            return UNKNOWN, UNKNOWN;
        end

        U.TooltipScanner:ClearLines();
        U.TooltipScanner:SetOwner(UIParent, 'ANCHOR_NONE');
        U.TooltipScanner:SetHyperlink(string_format(UNIT_CREATURE_LINK, id));

        return _G[U.TooltipScanner.Name .. 'TextLeft1']:GetText() or UNKNOWN, _G[U.TooltipScanner.Name .. 'TextLeft2']:GetText() or UNKNOWN;
    end

    U.GetNpcSubLabelByID = function(id)
        if not id or id == 0 then
            return UNKNOWN;
        end

        U.TooltipScanner:ClearLines();
        U.TooltipScanner:SetOwner(UIParent, 'ANCHOR_NONE');
        U.TooltipScanner:SetHyperlink(string_format(UNIT_CREATURE_LINK, id));

        return _G[U.TooltipScanner.Name .. 'TextLeft2']:GetText() or UNKNOWN;
    end

end

U.GetNpcID = function(unit)
    return tonumber((select(6, strsplit('-', UnitGUID(unit) or EMPTY_STRING))));
end

U.GetNpcIDByGUID = function(guid)
    return tonumber((select(6, strsplit('-', guid or EMPTY_STRING))));
end

do
    local LCN = {};

    for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
        LCN[v] = k;
    end

    for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
        LCN[v] = k;
    end

    U.GetClassColor = function(class, str)
        if not class then
            class = UnitClassBase(PLAYER_UNIT);
        elseif not RAID_CLASS_COLORS[class] then
            if LCN[class] then
                class = LCN[class];
            else
                class = UnitClassBase(class);
            end
        end

        class = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class];

        if not class then
            class = CreateColor(0.8, 0.8, 0.8);
        end

        if str == 2 then
            return class.r, class.g, class.b;
        elseif str then
            return string_format('%02x%02x%02x', class.r * 255, class.g * 255, class.b * 255);
        else
            return class;
        end
    end
end

do
    local reusableUnitColorTable = {
        r = 1,
        g = 1,
        b = 1,
    };

    U.GetUnitColor = function(unit, str)
        local r, g, b;

        if UnitIsTapDenied(unit) or UnitIsDeadOrGhost(unit) or not UnitIsConnected(unit) then
            r, g, b = 0.5, 0.5, 0.5;
        else
            if UnitIsPlayer(unit) or U.UnitIsPet(unit) then
                return U.GetClassColor(unit, str);
            else
                r, g, b = UnitSelectionColor(unit);
            end
        end

        if str == 2 then
            return r, g, b;
        elseif str then
            return string_format('%02x%02x%02x', r * 255, g * 255, b * 255);
        else
            reusableUnitColorTable.r = r;
            reusableUnitColorTable.g = b;
            reusableUnitColorTable.b = b;

            return reusableUnitColorTable;
        end
    end
end

U.GetClassColorByGUID = function(guid, str)
    return U.GetClassColor(select(2, GetPlayerInfoByGUID(guid)), str);
end

do
    local ClassificationTable = {
        elite     = { '+',  'elite'      },
        rare      = { 'r',  'rare'       },
        rareelite = { 'r+', 'rare elite' },
        worldboss = { 'b',  'boss'       },
    };

    U.GetUnitLevel = function(unit, long, real)
        local level = real and UnitLevel(unit) or UnitEffectiveLevel(unit);
        local classification = UnitClassification(unit);
        local diff = GetQuestDifficultyColor(level <= 0 and 999 or level);

        if ClassificationTable[classification] then
            classification = long and ClassificationTable[classification][2] or ClassificationTable[classification][1];
        else
            classification = EMPTY_STRING;
        end

        if level == -1 then
            level = '??';
        end

        return level, classification, diff;
    end
end

U.GetUnitArenaId = function(unit)
    for i = 1, GetNumArenaOpponents() do
        if UnitIsUnit(unit, 'arena' .. i) or UnitIsUnit(unit, 'arenapet' .. i) then
            return i;
        end
    end
end

U.IsAffixCurrent = function(affixID)
    local currentAffixes = C_MythicPlus_GetCurrentAffixes();

    if currentAffixes then
        for _, affix in ipairs(currentAffixes) do
            if affix.id == affixID then
                return true;
            end
        end
    end

    return false;
end

U.IsAffixActive = function(affixID)
    local _, affixes = C_ChallengeMode_GetActiveKeystoneInfo();

    if affixes then
        for i = 1, #affixes do
            if affixes[i] == affixID then
                return true;
            end
        end
    end

    return false;
end

U.IsSpellKnown = function(spellId)
    return IsSpellKnown(spellId) or IsSpellKnownOrOverridesKnown(spellId) or IsPlayerSpell(spellId);
end

--[[
    IsPlayerSpell(spellId), IsSpellKnown(spellId), IsSpellKnownOrOverridesKnown(spellId)
    Incorrectly returned false for some spells
    FindSpellOverrideByID, FindBaseSpellByID -- to not forget
]]

U.GetTrulySpellId = function(spellId)
    return select(7, GetSpellInfo(GetSpellInfo(spellId))); -- here we extract the spell name and then get needed spellId by spell name
end

U.GetInterruptSpellId = function()
    if D.KickByClassId[D.Player.ClassId] then
        return D.KickByClassId[D.Player.ClassId][D.Player.SpecIndex];
    end

    -- Warlock logic
    local spellId;

    if D.Player.SpecIndex == 1 or D.Player.SpecIndex == 3 then -- Aff & Destro
        if IsSpellKnown(19647, true) then -- Felhunter
            spellId = 119910;
        elseif IsPlayerSpell(108503) then
            spellId = 132409;
        end
    elseif D.Player.SpecIndex == 2 then -- Demo
        if IsSpellKnown(89766, true) then -- Felguard
            spellId = 119914;
        elseif IsSpellKnown(19647, true) then -- Felhunter
            spellId = 119910;
        end
    end

    return spellId;
end

U.IsInInstance = function()
    local inInstance, instanceType = IsInInstance();

    if inInstance or not (instanceType == 'none') then
        return true;
    end

    return false;
end

-- Colors
U.RGB2HEX = function(r, g, b)
	if type(r) == 'table' then
		if r.r then
			r, g, b = r.r, r.g, r.b;
		else
			r, g, b = unpack(r);
		end
	end

	if not r or not g or not b then
		r, g, b = 1, 1, 1;
	end

    return string_format('%02x%02x%02x', r * 255, g * 255, b * 255);
end

U.RGB2CFFHEX = function(r, g, b)
	if type(r) == 'table' then
		if r.r then
			r, g, b = r.r, r.g, r.b;
		else
			r, g, b = unpack(r);
		end
	end

	if not r or not g or not b then
		r, g, b = 1, 1, 1;
	end

    return string_format('|cff%02x%02x%02x', r * 255, g * 255, b * 255);
end

U.HEX2RGB = function(hex)
    hex = string_gsub(hex, '#', EMPTY_STRING);

    if string_len(hex) == 3 then
        return (tonumber('0x' .. string_sub(hex, 1, 1)) * 17) / 255, (tonumber('0x' .. string_sub(hex, 2, 2)) * 17) / 255, (tonumber('0x' .. string_sub(hex, 3, 3)) * 17) / 255;
    else
        return tonumber('0x' .. string_sub(hex, 1, 2)) / 255, tonumber('0x' .. string_sub(hex, 3, 4)) / 255, tonumber('0x' .. string_sub(hex, 5, 6)) / 255;
    end
end

-- Math
U.ShortValue = function(num)
    num = tonumber(num);

    if not num then
        return;
    end

    if num < 1000 then
        return math_floor(num);
    elseif num >= 1000000000000 then
        return string_format('%.3ft', num/1000000000000);
    elseif num >= 1000000000 then
        return string_format('%.3fb', num/1000000000);
    elseif num >= 1000000 then
        return string_format('%.2fm', num/1000000);
    elseif num >= 1000 then
        return string_format('%.1fk', num/1000);
    end
end

U.NUMBER_SEPARATOR = ',';

do
    local NUMBER_SEPARATOR = U.NUMBER_SEPARATOR;

    U.LargeNumberFormat = function(amount, separator)
        amount = tostring(amount);
        separator = separator or NUMBER_SEPARATOR;

        local newDisplay = '';
        local strlen = string_len(amount);

        for i = 4, strlen, 3 do
            newDisplay = separator .. string_sub(amount, -(i - 1), -(i - 3)) .. newDisplay;
        end

        return string_sub(amount, 1, (strlen % 3 == 0) and 3 or (strlen % 3)) .. newDisplay;
    end
end

-- String
do
    local function chsize(char)
        if not char then
            return 0;
        elseif char > 240 then
            return 4;
        elseif char > 225 then
            return 3;
        elseif char > 192 then
            return 2;
        else
            return 1;
        end
    end

    U.UTF8SUB = function(str, startChar, numChars)
        numChars = numChars or #str;

        local startIndex = 1;

        while startChar > 1 do
            local char = string_byte(str, startIndex);

            startIndex = startIndex + chsize(char);
            startChar = startChar - 1;
        end

        local currentIndex = startIndex;

        while numChars > 0 and currentIndex <= #str do
            local char = string_byte(str, currentIndex);

            currentIndex = currentIndex + chsize(char);
            numChars = numChars - 1;
        end

        return string_sub(str, startIndex, currentIndex - 1);
    end
end

U.FirstToUpper = function(str)
    return str:gsub('^[%z\1-\127\194-\244][\128-\191]', string.upper);
end

U.FirstToLower = function(str)
    return str:gsub('^[%z\1-\127\194-\244][\128-\191]', string.lower);
end

-- Table
U.TableCount = function(tbl)
    local count = 0;

    for _, _ in pairs(tbl) do
        count = count + 1;
    end

    return count;
end

U.DeepCopy = function(orig)
    local orig_type = type(orig);
    local copy;

    if orig_type == 'table' then
        copy = {};

        for orig_key, orig_value in next, orig, nil do
            copy[U.DeepCopy(orig_key)] = U.DeepCopy(orig_value);
        end

        setmetatable(copy, U.DeepCopy(getmetatable(orig)));
    else -- number, string, boolean, etc
        copy = orig;
    end

    return copy;
end

U.Merge = function(src, dst)
    if type(src) ~= 'table' then
        return {};
    end

    if type(dst) ~= 'table' then
        dst = {};
    end

    for k, v in pairs(src) do
        if type(v) == 'table' then
            dst[k] = U.Merge(v, dst[k]);
        elseif type(v) ~= type(dst[k]) then
            dst[k] = v;
        end
    end

    return dst;
end