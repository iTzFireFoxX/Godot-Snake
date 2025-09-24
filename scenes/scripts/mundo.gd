extends Node2D


var map_size: Vector2i = Vector2i(20, 10) # Definir tamaño del mapa (temporal)
var cell_size: int = 16 # Definir tamaño de las casillas en pixeles

func _ready():
	queue_redraw()

func _draw():
	# Dibujar el mapa en base al tamaño definido anteriormente
	for x in range(map_size.x):
		for y in range(map_size.y):
			var pos = Vector2i(x * cell_size, y * cell_size)
			# Dibujar las casillas de manera intercalada
			if x % 2 == y % 2:
				draw_rect(Rect2(pos, Vector2i(cell_size, cell_size)), Color.WEB_GREEN, true)
			else:
				draw_rect(Rect2(pos, Vector2i(cell_size, cell_size)), Color.DARK_GREEN, true)
