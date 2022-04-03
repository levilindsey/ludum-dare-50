tool
class_name GameLevel
extends SurfacerLevel


var command_center: CommandCenter

var main_bot: ConstructionBot

# Array<Station>
var stations := []

# Array<Bot>
var bots := []

# Array<PowerLine>
var power_lines := []


#func _load() -> void:
#    ._load()


func _start() -> void:
    ._start()
    
    command_center = Sc.utils.get_child_by_type($Stations, CommandCenter)
    main_bot = Sc.utils.get_child_by_type(self, ConstructionBot)
    
    Sc.level._on_station_created(command_center)
    Sc.level._on_bot_created(main_bot)
    
    # FIXME: Remove this.
    Sc.level._on_station_created(Sc.utils.get_child_by_type($Stations, SolarCollector))
    
    for station in stations:
        station._on_level_started()
    for bot in bots:
        bot._on_level_started()


func _destroy() -> void:
    ._destroy()
    for bot in bots:
        bot.queue_free()
    for station in stations:
        station.queue_free()


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


func add_bot(bot: Bot) -> void:
    $Bots.add_child(bot)
    _on_bot_created(bot)
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
