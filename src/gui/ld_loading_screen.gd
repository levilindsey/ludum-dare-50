tool
class_name LdLoadingScreen
extends Screen


var level_id := ""
var graph_load_start_time := INF


func _ready() -> void:
    var loading_image_wrapper := $VBoxContainer/LoadingImageWrapper
    loading_image_wrapper.visible = Sc.gui.is_loading_image_shown
    if Sc.gui.is_loading_image_shown:
        var loading_image: ScaffolderConfiguredImage = Sc.utils.add_scene(
                loading_image_wrapper,
                Sc.gui.loading_image_scene,
                true,
                true, \
                0)
        loading_image.original_scale = Sc.gui.loading_image_scale
    
    $VBoxContainer.rect_min_size.x = Sc.gui.screen_body_width
    
    _on_resized()


func set_params(params) -> void:
    .set_params(params)
    
    assert(params != null)
    assert(params.has("level_id"))
    level_id = params.level_id


func get_is_nav_bar_shown() -> bool:
    return true


func _on_transition_in_started(previous_screen: Screen) -> void:
    $VBoxContainer/LoadingImageWrapper.visible = true
    $VBoxContainer/Text.visible = true
    $VBoxContainer/ClickToContinueMessage.visible = false
    $VBoxContainer/LoadingProgress.visible = true
    self.mouse_default_cursor_shape = CURSOR_ARROW


func _on_transition_in_ended(previous_screen: Screen) -> void:
    ._on_transition_in_ended(previous_screen)
    if Sc.device.get_is_browser_app():
        Sc.audio.stop_music()
    Sc.time.set_timeout(funcref(self, "_load_level"), 0.05)


func _load_level() -> void:
    Sc.level_session.reset(level_id)
    Sc.save_state.set_last_level_played(level_id)
    
    $VBoxContainer/LoadingProgress/ProgressBar.value = 0.0
    $VBoxContainer/LoadingProgress/Label1.text = ""
    $VBoxContainer/LoadingProgress/Label2.text = ""
    
    var level: SurfacerLevel = Sc.utils.add_scene(
            null,
            Sc.level_config.get_level_config(level_id).scene_path,
            false,
            true)
    Sc.level = level
    if Su.debug_params.has("limit_parsing"):
        level.script = DebugLevel
    Sc.nav.screens["game"].add_level(level)
    Sc.level.graph_parser.connect(
            "calculation_started",
            self,
            "_on_calculation_started")
    Sc.level.graph_parser.connect(
            "load_started",
            self,
            "_on_load_started")
    Sc.level.graph_parser.connect(
            "calculation_progressed",
            self,
            "_on_graph_parse_progress")
    Sc.level.graph_parser.connect(
            "parse_finished",
            self,
            "_on_graph_parse_finished")
    graph_load_start_time = Sc.time.get_clock_time()
    level._load()


func _on_calculation_started() -> void:
    container.nav_bar.text = "Calculating platform graphs"
    $VBoxContainer/LoadingProgress/Duration.text = Sc.utils.get_time_string_from_seconds( \
            0.0, \
            false, \
            false, \
            true)
    $VBoxContainer/LoadingProgress/Label1.text = "Parsing surfaces"
    $VBoxContainer/LoadingProgress/Label2.text = ""


func _on_load_started() -> void:
    container.nav_bar.text = "Loading platform graphs"


func _on_graph_parse_progress(
        character_index: int,
        character_count: int,
        origin_surface_index: int,
        surface_count: int) -> void:
    var current_graph_calculation_progress_ratio := \
            origin_surface_index / float(surface_count)
    var progress := \
            (character_index + current_graph_calculation_progress_ratio) / \
            float(character_count) * \
            100.0
    
    var character_name: String = \
            Sc.level_config.get_level_config(Sc.level_session.id) \
            .platform_graph_character_names[character_index]
    var label_1 := "Character %s (%s of %s)" % [
        character_name,
        character_index + 1,
        character_count,
    ]
    var label_2 := "Out-bound surface %s of %s" % [
        origin_surface_index + 1,
        surface_count,
    ]
    
    $VBoxContainer/LoadingProgress/ProgressBar.value = progress
    $VBoxContainer/LoadingProgress/Duration.text = Sc.utils.get_time_string_from_seconds( \
            Sc.time.get_clock_time() - graph_load_start_time, \
            false, \
            false, \
            true)
    $VBoxContainer/LoadingProgress/Label1.text = label_1
    $VBoxContainer/LoadingProgress/Label2.text = label_2


# This is called when the graphs are ready, regardless of whether they were
# calculated-on-demand or loaded from a file.
func _on_graph_parse_finished() -> void:
    Sc.level.graph_parser.disconnect(
            "calculation_started",
            self,
            "_on_calculation_started")
    Sc.level.graph_parser.disconnect(
            "load_started",
            self,
            "_on_load_started")
    Sc.level.graph_parser.disconnect(
            "calculation_progressed",
            self,
            "_on_graph_parse_progress")
    Sc.level.graph_parser.disconnect(
            "parse_finished",
            self,
            "_on_graph_parse_finished")
    
    if !Sc.level.graph_parser.is_loaded_from_file:
        Sc.utils.give_button_press_feedback()
    
    $VBoxContainer/LoadingProgress/ProgressBar.value = 100
    $VBoxContainer/LoadingProgress/Duration.text = Sc.utils.get_time_string_from_seconds( \
            Sc.time.get_clock_time() - graph_load_start_time, \
            false, \
            false, \
            true)
    
    $VBoxContainer/LoadingImageWrapper.visible = true
    $VBoxContainer/Text.visible = true
    $VBoxContainer/ClickToContinueMessage.visible = true
    $VBoxContainer/LoadingProgress.visible = false
    
    self.mouse_default_cursor_shape = CURSOR_POINTING_HAND
    
    Sc.analytics.event(
            "graphs",
            "loaded",
            Sc.level_config.get_level_version_string(Sc.level_session.id),
            Sc.time.get_clock_time() - graph_load_start_time)


func _input(event: InputEvent) -> void:
    if is_instance_valid(Sc.level) and \
            Sc.level.graph_parser.is_parse_finished and \
            (event is InputEventKey or \
            event is InputEventMouseButton or \
            event is InputEventScreenTouch):
        Sc.nav.call_deferred("open", "game", ScreenTransition.FANCY)
