local S, L, O, U, D, E = unpack(select(2, ...));
local Module = S:NewModule('Options');

O.Lists = {
    hide_non_casting_modifiers = {'LALT', 'LCTRL', 'LSHIFT', 'RALT', 'RCTRL', 'RSHIFT'},

    target_indicator_texture_path = {
        [1]  = S.Media.Path .. 'Textures\\Arrow\\standart_right_32',
        [2]  = S.Media.Path .. 'Textures\\Arrow\\single_right_64',
        [3]  = S.Media.Path .. 'Textures\\Arrow\\double_right_64',
        [4]  = S.Media.Path .. 'Textures\\Arrow\\triangle_right_64',
        [5]  = S.Media.Path .. 'Textures\\Arrow\\thin_right_64',
        [6]  = S.Media.Path .. 'Textures\\Arrow\\thick_arrow_right_64',
        [7]  = S.Media.Path .. 'Textures\\Arrow\\double_edge_64',
        [8]  = S.Media.Path .. 'Textures\\Arrow\\double_smooth_64',
        [9]  = S.Media.Path .. 'Textures\\Arrow\\triple_smooth_64',
        [10] = S.Media.Path .. 'Textures\\Arrow\\lightning_hor_64',
        [11] = S.Media.Path .. 'Textures\\Arrow\\letter_a_64',
        [12] = S.Media.Path .. 'Textures\\Arrow\\likeplane_64',
        [13] = S.Media.Path .. 'Textures\\Arrow\\wifi_hor_64',
        [14] = S.Media.Path .. 'Textures\\Arrow\\heart_arrow_64',
        [15] = S.Media.Path .. 'Textures\\Arrow\\simple_heart_64',
        [16] = S.Media.Path .. 'Textures\\Arrow\\chick_64',
        [17] = S.Media.Path .. 'Textures\\Arrow\\kitty_fat_64',
        [18] = S.Media.Path .. 'Textures\\Arrow\\crab_64',
        [19] = S.Media.Path .. 'Textures\\Arrow\\turtle_64',
        [20] = S.Media.Path .. 'Textures\\Arrow\\bat_64',
        [21] = S.Media.Path .. 'Textures\\Arrow\\snake_64',
        [22] = S.Media.Path .. 'Textures\\Arrow\\duck_64',
        [23] = S.Media.Path .. 'Textures\\Arrow\\meorawr_64',
        [24] = S.Media.Path .. 'Textures\\Arrow\\semlar_64',
        [25] = S.Media.Path .. 'Textures\\Arrow\\gregory_64',
        [26] = S.Media.Path .. 'Textures\\Arrow\\composite_right_64',
    },

    motion = {
        [1] = UNIT_NAMEPLATES_TYPE_1,
        [2] = UNIT_NAMEPLATES_TYPE_2,
    },

    name_position = {
        [1] = L['POSITION_LEFT'],
        [2] = L['POSITION_CENTER'],
        [3] = L['POSITION_RIGHT'],
    },

    name_position_v = {
        [1] = L['POSITION_TOP'],
        [2] = L['POSITION_BOTTOM'],
    },

    raid_target_icon_position = {
        [1] = L['POSITION_LEFT'],
        [2] = L['POSITION_RIGHT'],
        [3] = L['POSITION_CENTER'],
        [4] = L['POSITION_TOP'],
        [5] = L['POSITION_BOTTOM'],
    },

    auras_sort_method = {
        [1] = L['AURAS_SORT_EXPIRES_ASC'],
        [2] = L['AURAS_SORT_EXPIRES_DESC'],
    },

    health_text_display_mode = {
        [1] = '1.2M  100%',
        [2] = '1.2M | 100%',
        [3] = '1.2M - 100%',
        [4] = '1.2M / 100%',
        [5] = '1.2M [100%]',
        [6] = '1.2M (100%)',
        [7] = '1.2M',
        [8] = '100%',
        [9] = '53918',
        [10] = '53' .. U.NUMBER_SEPARATOR .. '918',
    },

    font_flags = {
        [1] = 'NONE',
        [2] = 'OUTLINE',
        [3] = 'THICKOUTLINE',
        [4] = 'MONOCHROME',
        [5] = 'OUTLINE, MONOCHROME',
        [6] = 'THICKOUTLINE, MONOCHROME',
    },

    font_flags_localized = {
        [1] = L['FONT_FLAG_NONE'],
        [2] = L['FONT_FLAG_OUTLINE'],
        [3] = L['FONT_FLAG_THICKOUTLINE'],
        [4] = L['FONT_FLAG_MONOCHROME'],
        [5] = L['FONT_FLAG_OUTLINE_MONOCHROME'],
        [6] = L['FONT_FLAG_THICKOUTLINE_MONOCHROME'],
    },

    frame_points = {
        [1] = 'BOTTOM',
        [2] = 'BOTTOMLEFT',
        [3] = 'BOTTOMRIGHT',
        [4] = 'CENTER',
        [5] = 'LEFT',
        [6] = 'RIGHT',
        [7] = 'TOP',
        [8] = 'TOPLEFT',
        [9] = 'TOPRIGHT',
    },

    frame_points_localized = {
        [1] = L['FRAME_POINT_BOTTOM'],
        [2] = L['FRAME_POINT_BOTTOMLEFT'],
        [3] = L['FRAME_POINT_BOTTOMRIGHT'],
        [4] = L['FRAME_POINT_CENTER'],
        [5] = L['FRAME_POINT_LEFT'],
        [6] = L['FRAME_POINT_RIGHT'],
        [7] = L['FRAME_POINT_TOP'],
        [8] = L['FRAME_POINT_TOPLEFT'],
        [9] = L['FRAME_POINT_TOPRIGHT'],
    },

    frame_points_simple = {
        [1] = 'LEFT',
        [2] = 'CENTER',
        [3] = 'RIGHT',
    },

    frame_points_simple_localized = {
        [1] = L['POSITION_LEFT'],
        [2] = L['POSITION_CENTER'],
        [3] = L['POSITION_RIGHT'],
    },

    frame_strata = {
        [1] = L['FRAME_STRATA_INHERIT'],
        [2] = 'BACKGROUND',
        [3] = 'LOW',
        [4] = 'MEDIUM',
        [5] = 'HIGH',
        [6] = 'DIALOG',
        [7] = 'FULLSCREEN',
        [8] = 'FULLSCREEN_DIALOG',
        [9] = 'TOOLTIP',
    },

    custom_color_npcs = {
        [1]  = '|TInterface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle:12:12:2:0|t ' .. L['OPTIONS_COMMON'],
        [2]  = S.Media.DUNGEON_ICON_INLINE .. L['DUNGEON_SL_MISTS'],
        [3]  = S.Media.DUNGEON_ICON_INLINE .. L['DUNGEON_SL_NW'],
        [4]  = S.Media.DUNGEON_ICON_INLINE .. L['DUNGEON_SL_DOS'],
        [5]  = S.Media.DUNGEON_ICON_INLINE .. L['DUNGEON_SL_HOA'],
        [6]  = S.Media.DUNGEON_ICON_INLINE .. L['DUNGEON_SL_PF'],
        [7]  = S.Media.DUNGEON_ICON_INLINE .. L['DUNGEON_SL_SD'],
        [8]  = S.Media.DUNGEON_ICON_INLINE .. L['DUNGEON_SL_SOA'],
        [9]  = S.Media.DUNGEON_ICON_INLINE .. L['DUNGEON_SL_TOP'],
        [10] = S.Media.DUNGEON_ICON_INLINE .. L['DUNGEON_SL_TTVM'],
        [11] = S.Media.RAID_ICON_INLINE    .. L['RAID_SL_CN'],
        [12] = S.Media.RAID_ICON_INLINE    .. L['RAID_SL_SOD'],
    },

    quest_indicator_position = {
        [1] = L['POSITION_LEFT'],
        [2] = L['POSITION_RIGHT'],
    },

    name_text_coloring_mode = {
        [1] = L['OPTIONS_NAME_TEXT_COLORING_MODE_NONE'],
        [2] = L['OPTIONS_NAME_TEXT_COLORING_MODE_CLASS'],
        [3] = L['OPTIONS_NAME_TEXT_COLORING_MODE_FACTION'],
    },

    name_text_coloring_mode_npc = {
        [1] = L['OPTIONS_NAME_TEXT_COLORING_MODE_NONE'],
        [2] = L['OPTIONS_NAME_TEXT_COLORING_MODE_RELATION'],
    },

    mythic_plus_percentage_use_mode = {
        [1] = L['OPTIONS_MYTHIC_PLUS_PERCENTAGE_USE_MODE_EMBEDDED'],
        [2] = L['OPTIONS_MYTHIC_PLUS_PERCENTAGE_USE_MODE_MDT'],
    },

    name_text_abbreviation_mode = {
        [1] = L['OPTIONS_NAME_TEXT_ABBREVIATED_WITHOUT_SPACE'],
        [2] = L['OPTIONS_NAME_TEXT_ABBREVIATED_WITH_SPACE'],
        [3] = L['OPTIONS_NAME_TEXT_ABBREVIATED_LAST_WORD'],
    },

    health_text_block_mode = {
        [1] = L['OPTIONS_HEALTH_TEXT_SINGLE_BLOCK'],
        [2] = L['OPTIONS_HEALTH_TEXT_DOUBLE_BLOCK'],
    },

    glow_type = {
        [1] = L['GLOW_TYPE_PIXEL'],
        [2] = L['GLOW_TYPE_AUTOCAST'],
        [3] = L['GLOW_TYPE_BUTTON'],
    },

    name_text_with_title_mode = {
        [1] = L['OPTIONS_NAME_WITH_TITLE_MODE_ALL'],
        [2] = L['OPTIONS_NAME_WITH_TITLE_MODE_ONLY_FRIENDLY'],
        [3] = L['OPTIONS_NAME_WITH_TITLE_MODE_ONLY_ENEMY'],
    },
};

O.DefaultValues = {
    -- Common
    name_text_enabled                = true,
    name_text_font_value             = 'BigNoodleToo Titling',
    name_text_font_size              = 11,
    name_text_font_flag              = 1, -- NONE
    name_text_font_shadow            = true,
    name_text_position               = 2, -- CENTER
    name_text_position_v             = 1, -- TOP
    name_text_offset_y               = 0,
    name_text_truncate               = false,
    name_text_abbreviated            = false,
    name_text_abbreviated_mode       = 1, -- Without space
    name_text_coloring_mode          = 1, -- NONE
    name_text_coloring_mode_npc      = 1, -- NONE
    faction_icon_enabled             = false,
    class_icon_enabled               = false,
    class_icon_arena_only            = false,
    target_name_enabled              = true,
    target_name_only_enemy           = true,
    target_name_not_me               = false,
    target_name_role_icon            = true,
    name_text_show_arenaid           = false,
    name_text_show_arenaid_solo      = false,
    name_text_custom_color           = { 1, 0.85, 0, 1},
    name_without_realm               = false,
    name_text_translit               = false,
    name_text_with_title             = false,
    name_text_with_title_mode        = 1, -- ALL
    name_text_replace_diacritics     = false,

    health_text_enabled      = true,
    health_text_hide_full    = false,
    health_text_display_mode = 1,
    health_text_font_value   = 'BigNoodleToo Titling',
    health_text_font_size    = 11,
    health_text_font_flag    = 1, -- NONE
    health_text_font_shadow  = true,
    health_text_x_offset     = -1,
    health_text_y_offset     = 0,
    health_text_anchor       = 3, -- RIGHT
    health_text_custom_color_enabled = false,
    health_text_custom_color         = { 1, 1, 1, 1 },
    health_text_block_mode  = 1,
    health_text_block_1_display_mode = 7,
    health_text_block_1_x_offset     = 1,
    health_text_block_1_y_offset     = 0,
    health_text_block_1_anchor       = 1, -- LEFT
    health_text_block_2_display_mode = 8,
    health_text_block_2_x_offset     = -1,
    health_text_block_2_y_offset     = 0,
    health_text_block_2_anchor       = 3, -- RIGHT

    level_text_enabled        = true,
    level_text_hide_max       = false,
    level_text_font_value     = 'BigNoodleToo Titling',
    level_text_font_size      = 11,
    level_text_font_flag      = 1, -- NONE
    level_text_font_shadow    = true,
    level_text_x_offset       = 1,
    level_text_y_offset       = 0,
    level_text_use_diff_color = true,
    level_text_anchor         = 1, -- LEFT
    level_text_custom_color_enabled = false,
    level_text_custom_color         = { 1, 1, 1, 1 },

    -- Health bar
    health_bar_texture_value        = 'Stripes Flat';
    health_bar_border_hide          = false,
    health_bar_border_thin          = true,
    health_bar_class_color_friendly = C_CVar.GetCVar('ShowClassColorInFriendlyNameplate') == '1',
    health_bar_class_color_enemy    = C_CVar.GetCVar('ShowClassColorInNameplate') == '1',

    health_bar_color_dc              = { 0.5, 0.5, 0.5, 1 },
    health_bar_color_tapped          = { 0.9, 0.9, 0.9, 1 },
    health_bar_color_friendly_player = { 0.667, 0.667, 1, 1 },
    health_bar_color_friendly_npc    = { 0, 1, 0, 1 },
    health_bar_color_enemy_player    = { 1, 0, 0, 1 },
    health_bar_color_enemy_npc       = { 1, 0, 0, 1 },
    health_bar_color_neutral_npc     = { 1, 1, 0, 1 },

    absorb_bar_enabled = true,
    absorb_bar_at_top  = false,

    threat_color_enabled  = true,
    threat_color_reversed = false,
    threat_color_status_0 = { 1.00, 0.00, 0.00 },
    threat_color_status_1 = { 0.75, 0.70, 0.15 },
    threat_color_status_2 = { 1.00, 0.35, 0.10 },
    threat_color_status_3 = { 0.15, 0.75, 0.15 },
    threat_color_offtank  = { 0.60, 0.00, 0.85 },
    threat_color_pettank  = { 0.00, 0.44, 1.00 },

    threat_percentage_enabled        = false,
    threat_percentage_coloring       = true,
    threat_percentage_point          = 8, -- TOPLEFT
    threat_percentage_relative_point = 2, -- BOTTOMLEFT
    threat_percentage_offset_x       = 0,
    threat_percentage_offset_y       = 0,
    threat_percentage_font_value     = 'Expressway Bold',
    threat_percentage_font_size      = 8,
    threat_percentage_font_flag      = 1, -- NONE
    threat_percentage_font_shadow    = true,

    target_indicator_enabled  = true,
    target_indicator_color    = { 1, 1, 1 },
    target_indicator_texture  = 3,
    target_indicator_x_offset = 0,
    target_indicator_y_offset = 0,
    target_indicator_size     = 16,
    target_glow_enabled       = true,
    target_glow_color         = { 1, 1, 1 },
    hover_glow_enabled        = true,
    target_highlight          = true,

    execution_enabled      = false,
    execution_low_percent  = 30,
    execution_high_enabled = false,
    execution_high_percent = 75,
    execution_color        = { 1, 0.85, 0 },
    execution_glow         = true,

    -- Cast bar
    castbar_timer_enabled    = true,
    castbar_text_font_value  = 'BigNoodleToo Titling',
    castbar_text_font_size   = 11,
    castbar_text_font_flag   = 1, -- NONE
    castbar_text_font_shadow = true,
    castbar_texture_value    = 'Stripes Flat',
    castbar_on_hp_bar        = false,
    castbar_icon_large       = false,
    castbar_icon_right_side  = false,
    castbar_start_cast_color       = { 1, 0.7, 0 },
    castbar_start_channel_color    = { 0, 1, 0 },
    castbar_noninterruptible_color = { 0.7, 0.7, 0.7 },
    castbar_failed_cast_color      = { 1, 0, 0 },
    castbar_show_tradeskills           = false,
    castbar_show_shield                = true,
    castbar_show_icon_notinterruptible = true,

    who_interrupted_enabled = true,

    -- Sizes
    size_clickable_area_show   = false,

    size_enemy_clickable_width  = 132,
    size_enemy_clickable_height = 40,
    size_enemy_height           = 12,
    size_enemy_minus_height     = 6,
    size_enemy_click_through    = false,

    size_friendly_clickable_width  = 132,
    size_friendly_clickable_height = 40,
    size_friendly_height           = 12,
    size_friendly_click_through    = false,

    size_self_width         = 92,
    size_self_height        = 4,
    size_self_click_through = C_CVar.GetCVar('NameplatePersonalClickThrough') == '1',

    overlap_h = tonumber(C_CVar.GetCVar('nameplateOverlapH')), -- 0.8
    overlap_v = tonumber(C_CVar.GetCVar('nameplateOverlapV')), -- 1.1

    large_top_inset    = tonumber(C_CVar.GetCVar('nameplateLargeTopInset')),    -- 0.1
    large_bottom_inset = tonumber(C_CVar.GetCVar('nameplateLargeBottomInset')), -- 0.15
    other_top_inset    = tonumber(C_CVar.GetCVar('nameplateOtherTopInset')),    -- 0.08
    other_bottom_inset = tonumber(C_CVar.GetCVar('nameplateOtherBottomInset')), -- 0.1
    self_top_inset     = tonumber(C_CVar.GetCVar('nameplateSelfTopInset')),    -- 0.5
    self_bottom_inset  = tonumber(C_CVar.GetCVar('nameplateSelfBottomInset')), -- 0.2

    scale_large     = tonumber(C_CVar.GetCVar('nameplateLargerScale')),   -- 1.2
    scale_global    = tonumber(C_CVar.GetCVar('nameplateGlobalScale')),   -- 1
    scale_selected  = tonumber(C_CVar.GetCVar('nameplateSelectedScale')), -- 1.2
    scale_self      = tonumber(C_CVar.GetCVar('nameplateSelfScale')),     -- 1

    -- Visibility
    motion       = tonumber(C_CVar.GetCVar('nameplateMotion')) + 1,
    motion_speed = tonumber(C_CVar.GetCVar('nameplateMotionSpeed')), -- 0.025

    show_always_openworld  = C_CVar.GetCVar('nameplateShowAll') == '1',
    show_always_instance   = C_CVar.GetCVar('nameplateShowAll') == '1',
    max_distance_openworld = 60,
    max_distance_instance  = 60,

    show_friendly                = C_CVar.GetCVar('nameplateShowFriends') == '1',
    show_friendly_only_in_combat = false,
    show_friendly_minions        = C_CVar.GetCVar('nameplateShowFriendlyMinions') == '1',
    show_friendly_guardians      = C_CVar.GetCVar('nameplateShowFriendlyGuardians') == '1',
    show_friendly_npcs           = C_CVar.GetCVar('nameplateShowFriendlyNPCs') == '1',
    show_friendly_pets           = C_CVar.GetCVar('nameplateShowFriendlyPets') == '1',
    show_friendly_totems         = C_CVar.GetCVar('nameplateShowFriendlyTotems') == '1',

    show_enemy                = C_CVar.GetCVar('nameplateShowEnemies') == '1';
    show_enemy_only_in_combat = false,
    show_enemy_minions        = C_CVar.GetCVar('nameplateShowEnemyMinions') == '1',
    show_enemy_guardians      = C_CVar.GetCVar('nameplateShowEnemyGuardians') == '1',
    show_enemy_minus          = C_CVar.GetCVar('nameplateShowEnemyMinus') == '1',
    show_enemy_pets           = C_CVar.GetCVar('nameplateShowEnemyPets') == '1',
    show_enemy_totems         = C_CVar.GetCVar('nameplateShowEnemyTotems') == '1',

    show_personal                   = false,
    show_personal_always            = false,
    show_personal_resource_ontarget = C_CVar.GetCVar('nameplateResourceOnTarget') == '1',

    hide_non_casting_enabled              = false,
    hide_non_casting_modifier             = 2, -- CTRL
    hide_non_casting_show_uninterruptible = true,

    raid_target_icon_show              = true,
    raid_target_icon_scale             = 1,
    raid_target_icon_frame_strata      = 1, -- Inherit
    raid_target_icon_position          = 1, -- LEFT
    raid_target_icon_position_offset_x = -4,
    raid_target_icon_position_offset_y = 0,
    raid_target_hpbar_coloring         = false,

    name_only_friendly_enabled               = C_CVar.GetCVar('nameplateShowOnlyNames') == '1',
    name_only_friendly_color_name_by_health  = true,
    name_only_friendly_color_name_by_class   = true,
    name_only_friendly_guild_name            = true,
    name_only_friendly_guild_name_color      = { 0.8, 0.8, 0.8, 1 },
    name_only_friendly_guild_name_same_color = { 0.15, 0.85, 0.35, 1 },
    name_only_friendly_y_offset              = 0,
    name_only_friendly_players_only          = false,
    name_only_friendly_stacking              = false,

    selected_alpha      = tonumber(C_CVar.GetCVar('nameplateSelectedAlpha')), -- 1
    max_alpha           = tonumber(C_CVar.GetCVar('nameplateMaxAlpha')), -- 1
    max_alpha_distance  = tonumber(C_CVar.GetCVar('nameplateMaxAlphaDistance')), -- 40
    min_alpha           = tonumber(C_CVar.GetCVar('nameplateMinAlpha')), -- 0.6
    min_alpha_distance  = tonumber(C_CVar.GetCVar('nameplateMinAlphaDistance')), -- 10
    occluded_alpha_mult = tonumber(C_CVar.GetCVar('nameplateOccludedAlphaMult')), -- 0.4

    -- Mythic plus
    mythic_plus_percentage_enabled     = true,
    mythic_plus_percentage_use_mode    = 1, -- EMBEDDED
    mythic_plus_percentage_font_value  = 'Expressway Bold',
    mythic_plus_percentage_font_size   = 8,
    mythic_plus_percentage_font_flag   = 1, -- NONE
    mythic_plus_percentage_font_shadow = true,

    explosive_orbs_crosshair = false,
    explosive_orbs_counter   = false,
    explosive_orbs_glow      = true,

    spiteful_enabled         = true,
    spiteful_show_only_on_me = true,
    spiteful_glow            = true,
    spiteful_glow_color      = { 1, 0.35, 0, 1},

    mythic_plus_auto_slot_keystone = true,

    mythic_plus_questunwatch_enabled = true,
    mythic_plus_questunwatch_data    = {},

    -- Useful
    quest_indicator_enabled  = true,
    quest_indicator_position = 2, -- RIGHT

    stealth_detect_enabled       = false,
    stealth_detect_always        = false,
    stealth_detect_not_in_combat = true,

    totem_icon_enabled = false,

    talking_head_suppress        = false,
    talking_head_suppress_always = false,

    combat_indicator_enabled          = true,
    combat_indicator_color            = { 1, 0, 0, 1 },
    combat_indicator_size             = 8,
    combat_indicator_point            = 4, -- CENTER
    combat_indicator_relative_point   = 1, -- BOTTOM
    combat_indicator_offset_x         = 0,
    combat_indicator_offset_y         = 0,

    spell_interrupted_icon  = false,
    spell_interrupted_icon_frame_strata            = 5, -- HIGH
    spell_interrupted_icon_countdown_font_value    = 'BigNoodleToo Titling',
    spell_interrupted_icon_countdown_font_size     = 14,
    spell_interrupted_icon_countdown_font_flag     = 1, -- NONE
    spell_interrupted_icon_countdown_font_shadow   = true,
    spell_interrupted_icon_caster_name_show        = true,
    spell_interrupted_icon_caster_name_font_value  = 'BigNoodleToo Titling',
    spell_interrupted_icon_caster_name_font_size   = 6,
    spell_interrupted_icon_caster_name_font_flag   = 1, -- NONE
    spell_interrupted_icon_caster_name_font_shadow = true,

    pvp_healers_enabled    = true,
    pvp_healers_sound      = false,
    pvp_healers_icon_scale = 1,

    pve_healers_enabled    = true,
    pve_healers_sound      = false,
    pve_healers_icon_scale = 1,

    -- Auras
    auras_filter_player_enabled    = true,
    auras_blacklist_enabled        = false,
    auras_blacklist                = {},
    auras_border_color_enabled     = true,
    auras_show_debuffs_on_friendly = C_CVar.GetCVar('nameplateShowDebuffsOnFriendly') == '1',
    auras_sort_enabled             = false,
    auras_sort_method              = 1, -- ASC
    auras_pandemic_enabled         = false,
    auras_pandemic_color           = { 0, 1, 0 },
    auras_omnicc_suppress          = true,
    auras_expire_glow_enabled      = false,
    auras_expire_glow_percent      = 20,
    auras_expire_glow_color        = { 1, 0.85, 0, 1},
    auras_expire_glow_type         = 1, -- PIXEL
    auras_square                   = false,
    auras_scale                    = 1,
    auras_offset_y                 = 0,
    auras_hpbar_color_enabled      = false,
    auras_hpbar_color_data         = {},

    auras_countdown_enabled     = true,
    auras_cooldown_font_value   = 'BigNoodleToo Titling',
    auras_cooldown_font_size    = 14,
    auras_cooldown_font_flag    = 2, -- OUTLINE
    auras_cooldown_font_shadow  = true,
    auras_cooldown_point            = 8, -- TOPLEFT
    auras_cooldown_relative_point   = 8, -- TOPELFT
    auras_cooldown_offset_x         = -2,
    auras_cooldown_offset_y         = 4,
    auras_count_font_value      = 'BigNoodleToo Titling',
    auras_count_font_size       = 12,
    auras_count_font_flag       = 2, -- OUTLINE
    auras_count_font_shadow     = true,
    auras_count_point            = 3, -- BOTTOMRIGHT
    auras_count_relative_point   = 3, -- BOTTOMRIGHT
    auras_count_offset_x         = 3,
    auras_count_offset_y         = -2,

    auras_spellsteal_enabled              = true,
    auras_spellsteal_color                = { 1, 0.95, 0.35, 1 },
    auras_spellsteal_countdown_enabled    = true,
    auras_spellsteal_cooldown_font_value  = 'BigNoodleToo Titling',
    auras_spellsteal_cooldown_font_size   = 14,
    auras_spellsteal_cooldown_font_flag   = 2, -- OUTLINE
    auras_spellsteal_cooldown_font_shadow = true,
    auras_spellsteal_cooldown_point            = 8, -- TOPLEFT
    auras_spellsteal_cooldown_relative_point   = 8, -- TOPELFT
    auras_spellsteal_cooldown_offset_x         = -2,
    auras_spellsteal_cooldown_offset_y         = 4,
    auras_spellsteal_count_font_value     = 'BigNoodleToo Titling',
    auras_spellsteal_count_font_size      = 12,
    auras_spellsteal_count_font_flag      = 2, -- OUTLINE
    auras_spellsteal_count_font_shadow    = true,
    auras_spellsteal_count_point            = 3, -- BOTTOMRIGHT
    auras_spellsteal_count_relative_point   = 3, -- BOTTOMRIGHT
    auras_spellsteal_count_offset_x         = 3,
    auras_spellsteal_count_offset_y         = -2,

    auras_mythicplus_enabled              = true,
    auras_mythicplus_countdown_enabled    = true,
    auras_mythicplus_cooldown_font_value  = 'BigNoodleToo Titling',
    auras_mythicplus_cooldown_font_size   = 14,
    auras_mythicplus_cooldown_font_flag   = 2, -- OUTLINE
    auras_mythicplus_cooldown_point            = 8, -- TOPLEFT
    auras_mythicplus_cooldown_relative_point   = 8, -- TOPELFT
    auras_mythicplus_cooldown_offset_x         = -2,
    auras_mythicplus_cooldown_offset_y         = 4,
    auras_mythicplus_cooldown_font_shadow = true,
    auras_mythicplus_count_font_value     = 'BigNoodleToo Titling',
    auras_mythicplus_count_font_size      = 12,
    auras_mythicplus_count_font_flag      = 2, -- OUTLINE
    auras_mythicplus_count_font_shadow    = true,
    auras_mythicplus_count_point            = 3, -- BOTTOMRIGHT
    auras_mythicplus_count_relative_point   = 3, -- BOTTOMRIGHT
    auras_mythicplus_count_offset_x         = 3,
    auras_mythicplus_count_offset_y         = -2,

    auras_important_enabled                = true,
    auras_important_scale                  = 1.3,
    auras_important_countdown_enabled      = true,
    auras_important_cooldown_font_value    = 'BigNoodleToo Titling',
    auras_important_cooldown_font_size     = 12,
    auras_important_cooldown_font_flag     = 2, -- OUTLINE
    auras_important_cooldown_font_shadow   = true,
    auras_important_cooldown_point            = 8, -- TOPLEFT
    auras_important_cooldown_relative_point   = 8, -- TOPELFT
    auras_important_cooldown_offset_x         = -2,
    auras_important_cooldown_offset_y         = 4,
    auras_important_count_font_value       = 'BigNoodleToo Titling',
    auras_important_count_font_size        = 12,
    auras_important_count_font_flag        = 2, -- OUTLINE
    auras_important_count_font_shadow      = true,
    auras_important_count_point            = 3, -- BOTTOMRIGHT
    auras_important_count_relative_point   = 3, -- BOTTOMRIGHT
    auras_important_count_offset_x         = 3,
    auras_important_count_offset_y         = -2,
    auras_important_castername_show        = true,
    auras_important_castername_font_value  = 'BigNoodleToo Titling',
    auras_important_castername_font_size   = 6,
    auras_important_castername_font_flag   = 1, -- NONE
    auras_important_castername_font_shadow = true,

    auras_custom_enabled              = true,
    auras_custom_scale                = 1,
    auras_custom_offset_y             = 0,
    auras_custom_countdown_enabled    = true,
    auras_custom_cooldown_font_value  = 'BigNoodleToo Titling',
    auras_custom_cooldown_font_size   = 14,
    auras_custom_cooldown_font_flag   = 2, -- OUTLINE
    auras_custom_cooldown_font_shadow = true,
    auras_custom_cooldown_point            = 8, -- TOPLEFT
    auras_custom_cooldown_relative_point   = 8, -- TOPELFT
    auras_custom_cooldown_offset_x         = -2,
    auras_custom_cooldown_offset_y         = 4,
    auras_custom_count_font_value     = 'BigNoodleToo Titling',
    auras_custom_count_font_size      = 12,
    auras_custom_count_font_flag      = 2, -- OUTLINE
    auras_custom_count_font_shadow    = true,
    auras_custom_count_point            = 3, -- BOTTOMRIGHT
    auras_custom_count_relative_point   = 3, -- BOTTOMRIGHT
    auras_custom_count_offset_x         = 3,
    auras_custom_count_offset_y         = -2,
    auras_custom_border_color         = { 0.80, 0.05, 0.05, 1 },
    auras_custom_data                 = {},
    auras_custom_helpful              = false,
    auras_custom_to_blacklist         = true,

    custom_color_enabled = true,
    custom_color_data    = {},

    use_global_font_value  = false,
    use_global_font_size   = false,
    use_global_font_flag   = false,
    use_global_font_shadow = false,
    global_font_value  = 'BigNoodleToo Titling',
    global_font_size   = 11,
    global_font_flag   = 1, -- NONE
    global_font_shadow = true,
};

local PROFILE_DEFAULT_ID = '1';
local PROFILE_DEFAULT_NAME = L['OPTIONS_PROFILE_DEFAULT_NAME'];

function Module:IsNameExists(name)
    for _, data in pairs(StripesDB.profiles) do
        if name == data.profileName then
            return true;
        end
    end

    return false;
end

function Module:FindIndexByName(name)
    for index, data in pairs(StripesDB.profiles) do
        if name == data.profileName then
            return index;
        end
    end
end

do
    local indexes = {};
    function Module:GetNewIndex()
        wipe(indexes);

        local maxIndex = 0;

        for index, _ in pairs(StripesDB.profiles) do
            table.insert(indexes, tonumber(index), index);
        end

        maxIndex = table.maxn(indexes);

        return tostring(maxIndex + 1);
    end
end

function Module:StartUp()
    StripesDB.freqUsed = StripesDB.freqUsed or {};

    StripesDB.characters = StripesDB.characters or {};
    StripesDB.profiles   = StripesDB.profiles or {};

    if not StripesDB.characters[D.Player.NameWithRealm] then
        StripesDB.characters[D.Player.NameWithRealm] = {
            profileId = PROFILE_DEFAULT_ID,
        };
    end

    local profileId = StripesDB.characters[D.Player.NameWithRealm].profileId;

    StripesDB.profiles[profileId] = StripesDB.profiles[profileId] or {};

    local profileName;
    if StripesDB.profiles[profileId].profileName then
        profileName = StripesDB.profiles[profileId].profileName;
    end

    if next(StripesDB.profiles[profileId]) == nil then
        StripesDB.profiles[profileId] = U.DeepCopy(O.DefaultValues);
    else
        StripesDB.profiles[profileId] = U.Merge(O.DefaultValues, StripesDB.profiles[profileId]);
    end

    StripesDB.profiles[profileId].profileName = profileName or PROFILE_DEFAULT_NAME;

    O.db = StripesDB.profiles[profileId];
    O.activeProfileId   = profileId;
    O.activeProfileName = StripesDB.profiles[profileId].profileName;

    for pId, data in pairs(StripesDB.profiles) do
        StripesDB.profiles[pId] = U.Merge(O.DefaultValues, data);
    end
end