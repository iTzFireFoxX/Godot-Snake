extends Control


signal game_settings_updated()

# Passable Walls Buttons
@onready var PWYes: Button = %PWYes
@onready var PWNo: Button = %PWNo


func _on_pw_yes_pressed() -> void:
	GameSettings.set_passable_walls(true)
	game_settings_updated.emit()


func _on_pw_no_pressed() -> void:
	GameSettings.set_passable_walls(false)
	game_settings_updated.emit()
