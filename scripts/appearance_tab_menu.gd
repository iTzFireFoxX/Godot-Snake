extends ScrollContainer


@onready var MapColorOption: Control = %MapColorOption
@onready var FoodPullOption: Control = %FoodPullOption


func _on_play_menu_draw() -> void:
	_update_map_color_option()
	_update_food_pull_option()


func _update_map_color_option() -> void:
	for i in range(GameSettings.map_colors.size()):
		if GameSettings.appearance_settings.map_color == GameSettings.map_colors[i]:
			MapColorOption.MapColorsOptions.selected = i
			break


func _update_food_pull_option() -> void:
	if GameSettings.apple_sprite in GameSettings.appearance_settings["food_sprites"]:
		FoodPullOption.Apple.button_pressed = true
	if GameSettings.orange_sprite in GameSettings.appearance_settings["food_sprites"]:
		FoodPullOption.Orange.button_pressed = true
	if GameSettings.grapes_sprite in GameSettings.appearance_settings["food_sprites"]:
		FoodPullOption.Grapes.button_pressed = true
