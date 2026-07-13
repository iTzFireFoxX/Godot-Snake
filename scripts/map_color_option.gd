extends Control


@onready var MapColorsOptions: OptionButton = %MapColorsOptions
@onready var ColorPreview: GridContainer = %ColorPreview


func _on_map_colors_options_item_selected(index: int) -> void:
	GameSettings.set_map_color(index)
	set_selected_color()


func set_selected_color() -> void:
	ColorPreview.get_node("Rect1").color = GameSettings.appearance_settings["map_color"][0]
	ColorPreview.get_node("Rect4").color = GameSettings.appearance_settings["map_color"][0]
	ColorPreview.get_node("Rect2").color = GameSettings.appearance_settings["map_color"][1]
	ColorPreview.get_node("Rect3").color = GameSettings.appearance_settings["map_color"][1]
