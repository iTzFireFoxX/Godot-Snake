extends Node2D


var t_mapa: Vector2i = Vector2i(20, 10) # Definir tamaño del mapa (temporal)
var t_casilla: int = 16 # Definir tamaño de las casillas en pixeles

func _ready():
	queue_redraw()

func _draw():
	# Dibujar el mapa en base al tamaño definido anteriormente
	for ancho in range(t_mapa.x):
		for alto in range(t_mapa.y):
			var pos = Vector2i(ancho * t_casilla, alto * t_casilla)
			# Dibujar las casillas de manera intercalada
			if ancho % 2 == alto % 2:
				draw_rect(Rect2(pos, Vector2i(t_casilla, t_casilla)), Color.WEB_GREEN, true)
			else:
				draw_rect(Rect2(pos, Vector2i(t_casilla, t_casilla)), Color.DARK_GREEN, true)
