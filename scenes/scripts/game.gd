extends Node2D


# Definir variables
var map_size: Vector2i # Tamaño del mapa en cantidad de casillas (ancho y alto)
var cell_size: int # Tamaño de las casillas cuadradas
var game_vel: float # Intervalo de velocidad a la que avanza el juego en segundos

func _ready():
	map_size = Vector2i(20, 20) # Definir tamaño del mapa (temporal)
	cell_size = 16 # Definir tamaño de las casillas en pixeles
	game_vel = 0.1 # Definir el intervalo de velocidad en segundos
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
