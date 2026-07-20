extends Control


signal game_settings_updated()


# Game Vel Buttons
var GameVelButtonGroup: ButtonGroup = preload("res://scenes/game_vel_button_group.tres")

@onready var VerySlowVel: Button = %VerySlowVel
@onready var SlowVel: Button = %SlowVel
@onready var NormalVel: Button = %NormalVel
@onready var FastVel: Button = %FastVel
@onready var VeryFastVel: Button = %VeryFastVel

# Game Vel Input
@onready var GameVelInput: LineEdit = %GameVelInput


func set_game_vel(game_vel: String) -> void:
	if game_vel.to_float() < 0.1:
		GameVelInput.text = "0.1"

	GameSettings.set_game_vel(GameVelInput.text.to_float())
	game_settings_updated.emit()


func _on_very_slow_vel_pressed() -> void:
	GameSettings.set_game_vel(GameSettings.game_vels["very_slow"])
	game_settings_updated.emit()


func _on_slow_vel_pressed() -> void:
	GameSettings.set_game_vel(GameSettings.game_vels["slow"])
	game_settings_updated.emit()


func _on_normal_vel_pressed() -> void:
	GameSettings.set_game_vel(GameSettings.game_vels["normal"])
	game_settings_updated.emit()


func _on_fast_vel_pressed() -> void:
	GameSettings.set_game_vel(GameSettings.game_vels["fast"])
	game_settings_updated.emit()


func _on_very_fast_vel_pressed() -> void:
	GameSettings.set_game_vel(GameSettings.game_vels["very_fast"])
	game_settings_updated.emit()


func _on_game_vel_input_text_submitted(new_text: String) -> void:
	set_game_vel(new_text)


func _on_game_vel_input_focus_exited() -> void:
	set_game_vel(GameVelInput.text)
