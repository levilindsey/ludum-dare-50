tool
class_name GameLevel
extends SurfacerLevel


const _CONSTRUCTOR_BOT_SCENE := preload(
        "res://src/characters/construction_bot/construction_bot.tscn")

var bot_selector: BotSelector

var command_center: CommandCenter

var main_bot: ConstructionBot

# Array<Station>
var stations := []

# Array<Bot>
var bots := []

# Array<PowerLine>
var power_lines := []


func _load() -> void:
    ._load()
    
    Sc.gui.hud.set_up()


func _start() -> void:
    ._start()
    
    bot_selector = BotSelector.new()
    add_child(bot_selector)
    
    command_center = Sc.utils.get_child_by_type($Stations, CommandCenter)
    
    Sc.level._on_station_created(command_center)
    
    # FIXME: Remove this.
    Sc.level._on_station_created(
            Sc.utils.get_child_by_type($Stations, SolarCollector))
    
    main_bot = add_bot("constructor")
    
    var second_bot = add_bot("constructor")
    
    for station in stations:
        station._on_level_started()
    for bot in bots:
        bot._on_level_started()


func _destroy() -> void:
    ._destroy()
    for station in stations:
        station.queue_free()
    for power_line in power_lines:
        power_line.queue_free()


#func _on_initial_input() -> void:
#    ._on_initial_input()


#func quit(immediately := true) -> void:
#    .quit(immediately)


#func _on_intro_choreography_finished() -> void:
#    ._on_intro_choreography_finished()


#func pause() -> void:
#    .pause()


#func on_unpause() -> void:
#    .on_unpause()


func _on_bot_selection_changed(selected_bot) -> void:
    for station in stations:
        station._on_bot_selection_changed(selected_bot)
    for bot in bots:
        bot.set_is_selected(bot == selected_bot)


func add_power_line(power_line: PowerLine) -> void:
    $PowerLines.add_child(power_line)
    _on_power_line_created(power_line)
func remove_power_line(power_line: PowerLine) -> void:
    _on_power_line_destroyed(power_line)
func _on_power_line_created(power_line: PowerLine) -> void:
    power_lines.push_back(power_line)
func _on_power_line_destroyed(power_line: PowerLine) -> void:
    self.power_lines.erase(power_line)
    power_line.queue_free()


func add_bot(bot_name: String) -> Bot:
    var bot_scene: PackedScene
    match bot_name:
        "constructor":
            bot_scene = _CONSTRUCTOR_BOT_SCENE
        _:
            Sc.logger.error("GameLevel.add_bot")
            return null
    var bot: Bot = add_character(
            bot_scene,
            command_center.position + Vector2(0, -4),
            true,
            false,
            true)
    bot_selector._on_bot_created(bot)
    _on_bot_created(bot)
    return bot
func remove_bot(bot: Bot) -> void:
    _on_bot_destroyed(bot)
func _on_bot_created(bot: Bot) -> void:
    self.bots.push_back(bot)
func _on_bot_destroyed(bot: Bot) -> void:
    self.bots.erase(bot)
    bot.queue_free()


func add_station(station: Station) -> void:
    $Stations.add_child(station)
    _on_station_created(station)
func remove_station(station: Station) -> void:
    _on_station_destroyed(station)
func _on_station_created(station: Station) -> void:
    self.stations.push_back(station)
func _on_station_destroyed(station: Station) -> void:
    self.stations.erase(station)
    station.queue_free()


func get_music_name() -> String:
    return "on_a_quest"


func get_slow_motion_music_name() -> String:
    # FIXME: Add slo-mo music
    return ""
