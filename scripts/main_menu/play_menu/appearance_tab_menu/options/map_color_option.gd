extends Control


@onready var MapColorsOptions: OptionButton = %MapColorsOptions

	
func _on_map_colors_options_item_selected(index: int) -> void:
	GameSettings.set_map_color(index)
