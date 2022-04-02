tool
class_name GameSchema
extends FrameworkSchema


const _METADATA_SCRIPT := GameMetadata

var _metadata := {
    pauses_on_focus_out = true,
    also_prints_to_stdout = true,
    logs_character_events = true,
    logs_analytics_events = true,
    logs_bootstrap_events = true,
    logs_device_settings = true,
    logs_in_editor_events = true,
    is_profiler_enabled = true,
    are_all_levels_unlocked = true,
    are_test_levels_included = true,
    is_save_state_cleared_for_debugging = false,
    opens_directly_to_level_id = "",
    is_splash_skipped = false,
    uses_threads = false,
    thread_count = 1,
    rng_seed = 176,
    is_mobile_supported = true,
    uses_level_scores = false,
    must_restart_level_to_change_settings = true,
    overrides_project_settings = true,
    overrides_input_map = true,
    are_button_controls_enabled_by_default = false,
    base_path = "",
    
    app_name = "Bootstrapper",
    app_id = "dev.levi.bootstrapper",
    app_version = "0.0.1",
    score_version = "0.0.1",
    data_agreement_version = "0.0.1",
    
    # Must start with "UA-".
    google_analytics_id = "",
    privacy_policy_url = "",
    terms_and_conditions_url = "",
    android_app_store_url = "",
    ios_app_store_url = "",
    support_url = "",
    log_gestures_url = "",
    error_logs_url = "",
    app_id_query_param = "",
    
    developer_name = "Levi Lindsey",
    developer_url = "https://levi.dev",
    github_url = "https://github.com/levilindsey/ludum-dare-50",
    
    godot_splash_screen_duration = 0.8,
    developer_splash_screen_duration = 1.0,
}

var _music_manifest := [
    # {
    #     name = "my_music",
    #     path_prefix = "res://assets/music/",
    #     volume_db = 0.0,
    #     bpm = 75.0,
    #     meter = 4,
    # },
]

var _sounds_manifest := [
    {
        name = "test_character_jump",
        volume_db = 0.0,
        path_prefix = "",
    },
    {
        name = "test_character_land",
        volume_db = 0.0,
        path_prefix = "",
    },
    {
        name = "test_character_hit_surface",
        volume_db = 0.0,
        path_prefix = "",
    },
]

var _audio_manifest := {
    sounds_manifest = _sounds_manifest,
    default_sounds_path_prefix = "res://assets/sounds/",
    default_sounds_file_suffix = ".wav",
    default_sounds_bus_index = 1,
    
    music_manifest = _music_manifest,
    default_music_path_prefix = "res://assets/music/",
    default_music_file_suffix = ".ogg",
    default_music_bus_index = 2,
    
    godot_splash_sound = "achievement",
    developer_splash_sound = "single_cat_snore",
    level_end_sound_win = "cadence_win",
    level_end_sound_lose = "cadence_lose",
    
    main_menu_music = "on_a_quest",
    game_over_music = "pause_menu",
    pause_menu_music = "pause_menu",
    default_level_music = "on_a_quest",
    
    pauses_level_music_on_pause = true,
    
    are_beats_tracked_by_default = true,
    
    is_arbitrary_music_speed_change_supported = true,
    is_music_speed_scaled_with_time_scale = true,
    is_music_speed_scaled_with_additional_debug_time_scale = true,
    
    is_music_paused_in_slow_motion = true,
    is_tick_tock_played_in_slow_motion = true,
    is_slow_motion_start_stop_sound_effect_played = true,
}

var _images_manifest_pixelated := {
    checkbox_path_prefix = \
            ScaffolderImages.DEFAULT_CHECKBOX_PIXEL_PATH_PREFIX,
    default_checkbox_size = \
            ScaffolderImages.DEFAULT_CHECKBOX_PIXEL_SIZE,
    checkbox_sizes = \
            ScaffolderImages.DEFAULT_CHECKBOX_PIXEL_SIZES,
    
    radio_button_path_prefix = \
            ScaffolderImages.DEFAULT_RADIO_BUTTON_PIXEL_PATH_PREFIX,
    default_radio_button_size = \
            ScaffolderImages.DEFAULT_RADIO_BUTTON_PIXEL_SIZE,
    radio_button_sizes = \
            ScaffolderImages.DEFAULT_RADIO_BUTTON_PIXEL_SIZES,
    
    tree_arrow_path_prefix = \
            ScaffolderImages.DEFAULT_TREE_ARROW_PIXEL_PATH_PREFIX,
    default_tree_arrow_size = \
            ScaffolderImages.DEFAULT_TREE_ARROW_PIXEL_SIZE,
    tree_arrow_sizes = \
            ScaffolderImages.DEFAULT_TREE_ARROW_PIXEL_SIZES,
    
    dropdown_arrow_path_prefix = \
            ScaffolderImages.DEFAULT_DROPDOWN_ARROW_PIXEL_PATH_PREFIX,
    default_dropdown_arrow_size = \
            ScaffolderImages.DEFAULT_DROPDOWN_ARROW_PIXEL_SIZE,
    dropdown_arrow_sizes = \
            ScaffolderImages.DEFAULT_DROPDOWN_ARROW_PIXEL_SIZES,
    
    slider_grabber_path_prefix = \
            ScaffolderImages.DEFAULT_SLIDER_GRABBER_PIXEL_PATH_PREFIX,
    default_slider_grabber_size = \
            ScaffolderImages.DEFAULT_SLIDER_GRABBER_PIXEL_SIZE,
    slider_grabber_sizes = \
            ScaffolderImages.DEFAULT_SLIDER_GRABBER_PIXEL_SIZES,
    
    slider_tick_path_prefix = \
            ScaffolderImages.DEFAULT_SLIDER_TICK_PIXEL_PATH_PREFIX,
    default_slider_tick_size = \
            ScaffolderImages.DEFAULT_SLIDER_TICK_PIXEL_SIZE,
    slider_tick_sizes = \
            ScaffolderImages.DEFAULT_SLIDER_TICK_PIXEL_SIZES,
    
    app_logo = preload(
            "res://addons/scaffolder/assets/images/logos/scaffolder_logo.png"),
    app_logo_scale = 1.0,
    
    developer_logo = preload(
            "res://addons/scaffolder/assets/images/logos/snoring_cat_logo_about.png"),
    developer_splash = preload(
            "res://addons/scaffolder/assets/images/logos/snoring_cat_logo_splash.png"),
    
    go_normal = preload(
            "res://addons/scaffolder/assets/images/gui/icons/go_normal.png"),
    go_scale = 1.5,
    
    about_circle_pressed = preload(
            "res://addons/scaffolder/assets/images/gui/icons/about_circle_pressed.png"),
    about_circle_hover = preload(
            "res://addons/scaffolder/assets/images/gui/icons/about_circle_hover.png"),
    about_circle_normal = preload(
            "res://addons/scaffolder/assets/images/gui/icons/about_circle_normal.png"),
    
    alert_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/alert_normal.png"),
    
    close_pressed = \
            preload("res://addons/scaffolder/assets/images/gui/icons/close_pressed.png"),
    close_hover = \
            preload("res://addons/scaffolder/assets/images/gui/icons/close_hover.png"),
    close_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/close_normal.png"),
    
    gear_circle_pressed = \
            preload("res://addons/scaffolder/assets/images/gui/icons/gear_circle_pressed.png"),
    gear_circle_hover = \
            preload("res://addons/scaffolder/assets/images/gui/icons/gear_circle_hover.png"),
    gear_circle_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/gear_circle_normal.png"),
    
    home_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/home_normal.png"),
    
    left_caret_pressed = \
            preload("res://addons/scaffolder/assets/images/gui/icons/left_caret_pressed.png"),
    left_caret_hover = \
            preload("res://addons/scaffolder/assets/images/gui/icons/left_caret_hover.png"),
    left_caret_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/left_caret_normal.png"),
    
    pause_circle_pressed = \
            preload("res://addons/scaffolder/assets/images/gui/icons/pause_circle_pressed.png"),
    pause_circle_hover = \
            preload("res://addons/scaffolder/assets/images/gui/icons/pause_circle_hover.png"),
    pause_circle_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/pause_circle_normal.png"),
    
    pause_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/pause_normal.png"),
    play_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/play_normal.png"),
    retry_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/retry_normal.png"),
    stop_normal = \
            preload("res://addons/scaffolder/assets/images/gui/icons/stop_normal.png"),
}

var _gui_manifest := {
    third_party_license_text = \
            ThirdPartyLicenses.TEXT + \
            SurfaceTilerThirdPartyLicenses.TEXT + \
            ScaffolderThirdPartyLicenses.TEXT + \
            SurfacerThirdPartyLicenses.TEXT,
    settings_item_manifest = {
        groups = {
            annotations = {
                item_classes = [
                ],
            },
            hud = {
                item_classes = [
                ],
            },
            miscellaneous = {
                item_classes = [
                ],
            },
        },
    },
    hud_manifest = {
        hud_key_value_box_size = Vector2(256.0, 48.0),
        hud_key_value_list_item_manifest = [
        ],
        is_hud_visible_by_default = true,
        is_inspector_enabled_default = false,
        inspector_panel_starts_open = false,
    },
    welcome_panel_manifest = {
        items = [
        ],
    },
    screen_manifest = {
        screens = [
        ],
    },
}

var _character_scenes := [
    preload("res://src/characters/test_character/test_character.tscn"),
    preload("res://src/characters/test_character2/test_character2.tscn"),
]

var _character_categories := [
]

var _character_manifest := {
    default_character_name = "test_character",
    character_scenes = _character_scenes,
    character_categories = _character_categories,
    omits_npcs = false,
}

var _properties := {
}

var _additive_overrides := {
    ScaffolderSchema: {
        metadata = _metadata,
        audio_manifest = _audio_manifest,
        images_manifest_pixelated = _images_manifest_pixelated,
        character_manifest = _character_manifest,
        gui_manifest = _gui_manifest,
        level_config_class = LevelConfig,
        level_session_class = LevelSession,
        colors_manifest = \
            Utils.get_direct_color_properties(GameDefaultColors.new()),
        annotation_parameters_manifest = Sc.utils.merge(
            Utils.get_direct_non_color_properties(
                GameDefaultAnnotationParameters.new()),
            Utils.get_direct_non_color_properties(
                GameDefaultColors.new())),
    },
    SurfaceTilerSchema: {
        includes_intra_subtile_45_concave_cusps = false,
        tilesets = [
            {
                recalculate_tileset = [TYPE_CUSTOM, RecalculateTilesetCustomProperty],
                tile_set = preload("res://src/tiles/collidable_tileset.tres"),
                quadrant_size = 16,
                corner_match_tiles = [
                    {
                        outer_autotile_name = "autotile",
                        inner_autotile_name = "__inner_autotile__",
                        tileset_quadrants_path = \
                            "res://assets/images/tiles/tileset_quadrants.png",
                        tile_corner_type_annotations_path = \
                            "res://assets/images/tiles/tileset_corner_type_annotations.png",
                        subtile_collision_margin = 0.0,
                        are_45_degree_subtiles_used = true,
                        are_27_degree_subtiles_used = false,
                        properties = "default",
                        is_collidable = true,
                    },
                ],
                non_corner_match_tiles = [
                    {
                        name = "decorations",
                        properties = "",
                        is_collidable = false,
                    },
                ],
            },
        ],
    },
}

var _subtractive_overrides := {
    ScaffolderSchema: {
        character_manifest = {
            character_scenes = [
                preload("res://addons/squirrel_away/src/characters/squirrel/squirrel.tscn"),
            ],
            character_categories = [
                # ScaffolderSchema._SQUIRREL_CATEGORY,
            ]
        }
    },
    SurfaceTilerSchema: {
        tilesets = [
            SurfacerSchema.DEFAULT_TILESET_CONFIG,
        ],
    },
}


func _init().(
        _METADATA_SCRIPT,
        _properties,
        _additive_overrides,
        _subtractive_overrides) -> void:
    pass
