extends Control


@onready var CFOEYes: Button = %CFOEYes
@onready var CFOENo: Button = %CFOENo


func _on_cfoe_yes_pressed() -> void:
	GameSettings.appearance_settings["change_food_on_eat"] = true

func _on_cfoe_no_pressed() -> void:
	GameSettings.appearance_settings["change_food_on_eat"] = false
