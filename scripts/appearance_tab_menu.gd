extends ScrollContainer


@onready var MapColorOption = %MapColorOption


func _on_play_menu_draw() -> void:
	match GameSettings.appearance_settings["map_color"]:
		GameSettings.map_colors[0]:
			MapColorOption.MapColorsOptions.selected = 0
		GameSettings.map_colors[1]:
			MapColorOption.MapColorsOptions.selected = 1
		GameSettings.map_colors[2]:
			MapColorOption.MapColorsOptions.selected = 2
		GameSettings.map_colors[3]:
			MapColorOption.MapColorsOptions.selected = 3
			
	MapColorOption.set_selected_color()
