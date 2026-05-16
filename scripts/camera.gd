extends Camera2D


var game: Node2D
var zoom_x: float
var zoom_y: float
var viewport: Vector2


func _ready():
	call_deferred("init_camera")


func _process(_delta):
	dynamic_zoom()


# Inicializar camara
func init_camera(): 
	game = get_parent()
	dynamic_zoom()
	position = Vector2((game.map_size.x * game.cell_size) / 2, (game.map_size.y * game.cell_size) / 2)


# Zoom dinamico al redimensionar
func dynamic_zoom():
	viewport = get_viewport_rect().size
	zoom_x = viewport.x / (game.map_size.x * game.cell_size)
	zoom_y = viewport.y / (game.map_size.y * game.cell_size)
	zoom = Vector2(min(zoom_x, zoom_y), min(zoom_x, zoom_y))
