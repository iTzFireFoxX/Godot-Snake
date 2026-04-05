extends ScrollContainer


# Map Color
@onready var MapColorsOptions: OptionButton = %MapColorsOptions
@onready var ColorPreview: GridContainer = %ColorPreview


func _on_play_menu_draw() -> void:
	MapColorsOptions.item_selected.emit(0)
	MapColorsOptions.selected = 0
	

func _on_map_colors_options_item_selected(index: int) -> void:
	var color1: Color
	var color2: Color

	match index:
		0: # Verde
			color1 = Color("#75a743")
			color2 = Color("#468232")
		1: # Azul
			color1 = Color("#4f8fba")
			color2 = Color("#3c5e8b")
		2: # Rojo
			color1 = Color("#a53030")
			color2 = Color("#752438")
	
	ColorPreview.get_node("Rect1").color = color1
	ColorPreview.get_node("Rect4").color = color1
	ColorPreview.get_node("Rect2").color = color2
	ColorPreview.get_node("Rect3").color = color2

	GameSettings.map_color = [color1, color2]
