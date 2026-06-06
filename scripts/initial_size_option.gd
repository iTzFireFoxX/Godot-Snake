extends Control


signal game_settings_updated()


# InitialSize Input
@onready var InitialSizeInput: LineEdit = %InitialSizeInput


func set_initial_size(initial_size: String) -> void:
	GameSettings.set_initial_size(initial_size.to_int())
	game_settings_updated.emit()


func _on_initial_size_input_text_submitted(new_text: String) -> void:
	set_initial_size(new_text)


func _on_initial_size_input_focus_exited() -> void:
	set_initial_size(InitialSizeInput.text)