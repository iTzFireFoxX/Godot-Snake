extends Camera2D


var zoom_x: float
var zoom_y: float
var viewport: Vector2

@onready var cell_size = GameSettings.cell_size

@onready var map_size = GameSettings.game_settings["map_size"]


func _ready():
	dynamic_zoom()
	position = Vector2((map_size.x * cell_size) / 2, (((map_size.y  * cell_size) - (2 * map_size.y)) / 2))


func _process(_delta):
	dynamic_zoom()


# Zoom dinamico al redimensionar
func dynamic_zoom():
	viewport = get_viewport_rect().size
	zoom_x = viewport.x / ((map_size.x * cell_size) + (1 * map_size.x))
	zoom_y = viewport.y / ((map_size.y * cell_size) + (3 * map_size.y))
	zoom = Vector2(min(zoom_x, zoom_y), min(zoom_x, zoom_y))
