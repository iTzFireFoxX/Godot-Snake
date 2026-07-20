extends Control


signal game_settings_updated()


@onready var MapSizeOption: Control = %MapSizeOption

# InitialSize Input
@onready var InitialSizeInput: LineEdit = %InitialSizeInput


func _ready() -> void:
	MapSizeOption.game_settings_updated.connect(_on_game_settings_updated)


func _on_game_settings_updated() -> void:
	set_initial_size(InitialSizeInput.text)


func set_initial_size(initial_size: String) -> void:
	if initial_size.to_int() < 3:
		InitialSizeInput.text = "3"
	
	if initial_size.to_int() > GameSettings.game_settings["map_size"].x:
		InitialSizeInput.text = str(GameSettings.game_settings["map_size"].x)

	GameSettings.set_initial_size(InitialSizeInput.text.to_int())
	game_settings_updated.emit()


func _on_initial_size_input_text_submitted(new_text: String) -> void:
	set_initial_size(new_text)


func _on_initial_size_input_focus_exited() -> void:
	set_initial_size(InitialSizeInput.text)
