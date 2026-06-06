extends Node2D


# Definir variables
var timer: float # Cuenta el tiempo para actualizar cada tick del juego
var dir: Vector2i # Direccion de la serpiente


# Nodos Hijos
@onready var Snake: Node2D = %Snake # Nodo de la serpiente
@onready var Food: Node2D = %Food # Nodo de la comida


@onready var cell_size: int = GameSettings.cell_size


# Config del juego
@onready var map_size: Vector2i = GameSettings.game_settings["map_size"] # Tamaño del mapa en cantidad de casillas (ancho y alto)
@onready var game_vel: float = GameSettings.game_settings["game_vel"] # Intervalo de velocidad a la que avanza el juego en segundos
@onready var passable_walls: bool = GameSettings.game_settings["passable_walls"] # Booleano para definir si los bordes son traspasables
@onready var initial_size: int = GameSettings.game_settings["initial_size"]

# Config de apariencia
@onready var map_color: Array = GameSettings.appearance_settings["map_color"] # Color del mapa


func _ready() -> void:
	Snake.food_eated.connect(_on_food_eated)
	Snake.win.connect(_on_win)
	Snake.lose.connect(_on_lose)

	dir = Vector2i.RIGHT
	Snake.init_snake(initial_size, dir)
	Food.init_food(_get_empty_cells(Snake.get_snake_pos_dict()))


func _on_food_eated(pos: Vector2i) -> void:
	Food.update_food_pos(pos, _get_empty_cells(Snake.get_snake_pos_dict()))


func _on_win() -> void:
	print("ganaste")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_lose() -> void:
	print("perdiste")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_draw() -> void:
	_draw_map()


func _process(delta) -> void:
	# Comprobar inputs
	if Input.is_action_pressed("move_up") and Snake.snake_dir[0] != Vector2i.DOWN:
		dir = Vector2i.UP
	elif Input.is_action_pressed("move_down") and Snake.snake_dir[0] != Vector2i.UP:
		dir = Vector2i.DOWN
	elif Input.is_action_pressed("move_right") and Snake.snake_dir[0] != Vector2i.LEFT:
		dir = Vector2i.RIGHT
	elif Input.is_action_pressed("move_left") and Snake.snake_dir[0] != Vector2i.RIGHT:
		dir = Vector2i.LEFT
	
	# Tick del juego
	timer += delta
	if timer >= game_vel:
		timer = 0.0
		Snake.update_snake(dir, Food.get_food_pos())


func _draw_map() -> void:
	# Dibujar el mapa en base al tamaño
	for x in range(map_size.x):
		for y in range(map_size.y):
			var pos = Vector2i(x * cell_size, y * cell_size)
			# Dibujar las casillas de manera intercalada
			if x % 2 == y % 2:
				draw_rect(Rect2(pos, Vector2i(cell_size, cell_size)), map_color[0], true)
			else:
				draw_rect(Rect2(pos, Vector2i(cell_size, cell_size)), map_color[1], true)


func _get_empty_cells(snake_pos_dict: Dictionary) -> Dictionary:
	var empty_cells: Dictionary
	for x in range(map_size.x):
		for y in range(map_size.y):
			if not snake_pos_dict.has(Vector2i(x, y)):
				empty_cells[Vector2i(x, y)] = true
	return (empty_cells)
