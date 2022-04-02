tool
class_name GameInterface
extends SurfacerFrameworkGlobal


const _SCHEMA_PATH := "res://src/config/game_schema.gd"


func _init().(_SCHEMA_PATH) -> void:
    pass


func _get_members_to_destroy() -> Array:
    return []


func _amend_manifest() -> void:
    ._amend_manifest()
    _override_manifest(_get_manifest_overrides())


func _configure_sub_modules() -> void:
    ._configure_sub_modules()


func _load_state() -> void:
    ._load_state()


# This method is useful for defining parameters that are likely to change
# between builds or between development and production environments.
func _get_manifest_overrides() -> Array:
    var debug: bool = \
            Sc.modes.get_is_active("release", "local_dev") and \
            OS.is_debug_build()
    var playtest: bool = Sc.modes.get_is_active("release", "playtest")
    var is_using_threads: bool = Sc.modes.get_is_active("threading", "enabled")
    var is_using_pixel_style: bool = \
            Sc.modes.get_is_active("ui_smoothness", "pixelated")
    var are_annotations_emphasized: bool = \
            Sc.modes.get_is_active("annotations", "emphasized")
    
    var debug_window_size = ScaffolderGuiConfig.SCREEN_RESOLUTIONS.default
#    var debug_window_size = ScaffolderGuiConfig.SCREEN_RESOLUTIONS.full_screen
#    var debug_window_size = ScaffolderGuiConfig.SCREEN_RESOLUTIONS.google_ads_portrait
    
    var overrides := []
    Sc.utils.concat(overrides, _get_common_overrides_for_release_mode())
    Sc.utils.concat(overrides, _get_common_overrides_for_annotations_mode())
    Sc.utils.concat(overrides, [
        ["Sc.manifest.metadata.app_version", "0.0.1"],
        
        ["Sc.manifest.metadata.debug", debug, "release"],
        ["Sc.manifest.metadata.playtest", playtest, "release"],
        ["Sc.manifest.metadata.rng_seed", 723],
        ["Sc.manifest.metadata.pauses_on_focus_out", false],
        ["Sc.manifest.metadata.also_prints_to_stdout", true],
        ["Sc.manifest.metadata.logs_character_events", true],
        ["Sc.manifest.metadata.logs_analytics_events", false],
        ["Sc.manifest.metadata.logs_bootstrap_events", false],
        ["Sc.manifest.metadata.logs_device_settings", false],
        ["Sc.manifest.metadata.logs_in_editor_events", true],
        ["Sc.manifest.metadata.are_all_levels_unlocked", true],
        ["Sc.manifest.metadata.are_test_levels_included", true],
        ["Sc.manifest.metadata.is_save_state_cleared_for_debugging", false],
        ["Sc.manifest.metadata.opens_directly_to_level_id", "0"],
#        ["Sc.manifest.metadata.opens_directly_to_level_id", ""],
        ["Sc.manifest.metadata.is_splash_skipped", true],
        ["Sc.manifest.metadata.are_button_controls_enabled_by_default", true],
        
        ["Su.manifest.are_loaded_surfaces_deeply_validated", false],
        
        ["Sc.manifest.character_manifest.omits_npcs", \
            Sc.manifest.character_manifest.omits_npcs and debug],
        
        ["Su.manifest.precompute_platform_graph_for_levels", [
#            "0",
        ]],
        ["Su.manifest.ignores_platform_graph_save_files", false],
        
        ["Sc.manifest.metadata.thread_count", \
            OS.get_processor_count() if is_using_threads else 1, "threading"],
        ["Su.manifest.uses_threads_for_platform_graph_calculation", \
            Su.manifest.uses_threads_for_platform_graph_calculation and \
            is_using_threads],
        
        ["Sc.manifest.gui_manifest.debug_window_size", debug_window_size],
        ["Sc.manifest.gui_manifest.hud_manifest.is_inspector_enabled_default", true],
        ["Sc.manifest.gui_manifest.hud_manifest.is_hud_visible_by_default", true],
    ])
    
    return overrides
