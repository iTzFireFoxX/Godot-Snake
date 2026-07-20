extends Control


@onready var Apple: Button = %Apple
@onready var Orange: Button = %Orange
@onready var Grapes: Button = %Grapes


func _on_apple_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		if GameSettings.apple_sprite not in GameSettings.appearance_settings["food_sprites"]:
			GameSettings.appearance_settings["food_sprites"].append(GameSettings.apple_sprite)
	elif toggled_on == false:
		if GameSettings.apple_sprite in GameSettings.appearance_settings["food_sprites"]:
			GameSettings.appearance_settings["food_sprites"].erase(GameSettings.apple_sprite)
	if GameSettings.appearance_settings["food_sprites"].is_empty():
		Apple.button_pressed = true


func _on_orange_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		if GameSettings.orange_sprite not in GameSettings.appearance_settings["food_sprites"]:
			GameSettings.appearance_settings["food_sprites"].append(GameSettings.orange_sprite)
	elif toggled_on == false:
		if GameSettings.orange_sprite in GameSettings.appearance_settings["food_sprites"]:
			GameSettings.appearance_settings["food_sprites"].erase(GameSettings.orange_sprite)
	if GameSettings.appearance_settings["food_sprites"].is_empty():
		Orange.button_pressed = true

func _on_grapes_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		if GameSettings.grapes_sprite not in GameSettings.appearance_settings["food_sprites"]:
			GameSettings.appearance_settings["food_sprites"].append(GameSettings.grapes_sprite)
	elif toggled_on == false:
		if GameSettings.grapes_sprite in GameSettings.appearance_settings["food_sprites"]:
			GameSettings.appearance_settings["food_sprites"].erase(GameSettings.grapes_sprite)
	if GameSettings.appearance_settings["food_sprites"].is_empty():
		Grapes.button_pressed = true
