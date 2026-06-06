extends Control


signal game_settings_updated()

# Map Size Inputs
@onready var WidthInput: LineEdit = %WidthInput
@onready var HeightInput: LineEdit = %HeightInput


func set_width(width: String) -> void:
	GameSettings.set_map_size_x(width.to_int())
	game_settings_updated.emit()


func set_height(height: String) -> void:
	GameSettings.set_map_size_y(height.to_int())
	game_settings_updated.emit()


func _on_width_input_text_submitted(new_text: String) -> void:
	set_width(new_text)


func _on_height_input_text_submitted(new_text: String) -> void:
	set_height(new_text)


func _on_width_input_focus_exited() -> void:
	set_width(WidthInput.text)


func _on_height_input_focus_exited() -> void:
	set_height(HeightInput.text)