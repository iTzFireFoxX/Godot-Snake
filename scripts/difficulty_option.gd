extends Control


signal game_settings_updated()


# Difficulty Buttons
var DifficultyButtonGroup: ButtonGroup = preload("res://scenes/difficulty_button_group.tres")

@onready var VeryEasyDiff: Button = %VeryEasyDiff
@onready var EasyDiff: Button = %EasyDiff
@onready var NormalDiff: Button = %NormalDiff
@onready var HardDiff: Button = %HardDiff
@onready var VeryHardDiff: Button = %VeryHardDiff


func _on_very_easy_diff_pressed() -> void:
	GameSettings.set_diff("very_easy")
	game_settings_updated.emit()


func _on_easy_diff_pressed() -> void:
	GameSettings.set_diff("easy")
	game_settings_updated.emit()


func _on_normal_diff_pressed() -> void:
	GameSettings.set_diff("normal")
	game_settings_updated.emit()


func _on_hard_diff_pressed() -> void:
	GameSettings.set_diff("hard")
	game_settings_updated.emit()


func _on_very_hard_diff_pressed() -> void:
	GameSettings.set_diff("very_hard")
	game_settings_updated.emit()
