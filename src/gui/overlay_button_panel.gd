tool
class_name OverlayButtonPanel
extends Node2D


signal button_pressed(button_type)

const _CONTAINER_OPACITY_EMPHASIZED := 0.99
const _CONTAINER_OPACITY_DEEMPHASIZED := 0.6

const _OPACITY_NORMAL := 0.9
const _OPACITY_HOVER := 0.999

const _VALUE_DELTA_NORMAL := 0.0
const _VALUE_DELTA_HOVER := 0.15

const _SATURATION_DELTA_NORMAL := 0.0
const _SATURATION_DELTA_HOVER := -0.1

const _BUTTON_SIZE := Vector2(16.0, 16.0)

# Array<TextureButton>
var buttons := []


func _ready() -> void:
    for button in $Buttons:
        button.connect(
                "mouse_entered", self, "_on_button_mouse_entered", [button])
        button.connect(
                "mouse_exited", self, "_on_button_mouse_exited", [button])
        button.connect("pressed", self, "_on_button_pressed", [button])
        button.rect_size = _BUTTON_SIZE


func set_buttons(button_types: Array) -> void:
    var visible_buttons := []
    
    # Set up hover behavior.
    for button in $Buttons:
        button.modulate.a = _OPACITY_NORMAL
        button.visible = button_types.find(_get_type_for_button(button)) >= 0
        visible_buttons.push_back(button)
    
    # Calculate the button row and column counts.
    var row_count: int
    var button_count := visible_buttons.size()
    if row_count > 6:
        row_count = 3
    elif row_count > 2:
        row_count = 2
    else:
        row_count = 1
    var column_count := int(ceil(button_count / row_count))
    
    # Assign the individual button positions.
    for row_i in row_count:
        for column_i in column_count:
            var button_i: int = row_i * column_count + column_count
            var button_position := _BUTTON_SIZE * Vector2(column_i, row_i)
            visible_buttons[button_i].rect_position = button_position
    
    # Assign the container position and size.
    var container_size := Vector2(column_count, row_count)
    $Buttons.rect_size = container_size
    $Buttons.rect_position = container_size * Vector2(-0.5, -1.0)


func emphasize() -> void:
    self.modulate.a = _CONTAINER_OPACITY_EMPHASIZED


func deemphasize() -> void:
    self.modulate.a = _CONTAINER_OPACITY_DEEMPHASIZED


func _on_button_mouse_entered(button: TextureButton) -> void:
    emphasize()
    button.modulate.s = _SATURATION_DELTA_HOVER
    button.modulate.v = _VALUE_DELTA_HOVER
    button.modulate.a = _OPACITY_HOVER


func _on_button_mouse_exited(button: TextureButton) -> void:
    deemphasize()
    button.modulate.s = _SATURATION_DELTA_NORMAL
    button.modulate.v = _VALUE_DELTA_NORMAL
    button.modulate.a = _OPACITY_NORMAL


func _on_button_pressed(button: TextureButton) -> void:
    Sc.utils.give_button_press_feedback()
    emit_signal("button_pressed", _get_type_for_button(button))


func _get_type_for_button(button: TextureButton) -> int:
    if button == $Destroy:
        return OverlayButtonType.DESTROY
    elif button == $Battery:
        return OverlayButtonType.BATTERY_STATION
    elif button == $Scanner:
        return OverlayButtonType.SCANNER_STATION
    elif button == $Solar:
        return OverlayButtonType.SOLAR_COLLECTOR
    else:
        Sc.logger.error("OverlayButtonPanel._get_type_for_button")
        return OverlayButtonType.UNKNOWN
