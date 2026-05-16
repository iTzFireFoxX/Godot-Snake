extends Node2D
class_name Snake

signal food_eated(food_pos: Vector2i)


var snake_size: int = 0
var snake_pos: Array[Vector2i] = []
var snake_dir: Array[Vector2i] = []
var snake_nodes: Array[Node] = []


# Sprites
var head_sprite: Resource = preload("res://assets/sprites/snake/default/snake_head.png")
var body_sprite: Resource = preload("res://assets/sprites/snake/default/snake_body.png")
var corner_sprite: Resource = preload("res://assets/sprites/snake/default/snake_corner.png")
var tail_sprite: Resource = preload("res://assets/sprites/snake/default/snake_tail.png")


@onready var cell_size: int = GameSettings.cell_size


@onready var map_size: Vector2i = GameSettings.map_size # Tamaño del mapa en cantidad de casillas (ancho y alto)
@onready var passable_walls: bool = GameSettings.passable_walls # Booleano para definir si los bordes son traspasables


# Genera la serpiente inicial de un tamaño variable en el centro del mapa
func init_snake(size: int, dir: Vector2i) -> void:
	for i in range(size):
		add_snake_part(Vector2i((map_size.x/2), (map_size.y/2)) + (-dir * (i+1) + (roundi(size/2.0) * dir)), dir)
		set_snake_node_pos(i)
	set_snake_nodes_sprites()


func update_snake(dir: Vector2i, food_pos_dict: Dictionary) -> void:

	if snake_size == (map_size.x * map_size.y):
		print("ganaste")
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
	else:

		var tail_pos: Vector2i = snake_pos[snake_size-1]
		var tail_dir: Vector2i = snake_dir[snake_size-1]

		set_snake_part_dir(0, dir)
		for i in range(snake_size):
			set_snake_part_pos(i)
			set_snake_node_pos(i)

		var snake_pos_dict: Dictionary = get_snake_pos_dict_no_head()
		
		if snake_pos_dict.has(snake_pos[0]) or (snake_pos[0].x >= map_size.x or snake_pos[0].x < 0 or snake_pos[0].y >= map_size.y or snake_pos[0].y < 0):
			print("perdiste")
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

		elif food_pos_dict.has(snake_pos[0]):
			eat_food(tail_pos, tail_dir)
					
		set_snake_dir()
		set_snake_nodes_sprites()


func eat_food(tail_pos: Vector2i, tail_dir: Vector2i) -> void:
	add_snake_part(tail_pos, tail_dir)
	set_snake_node_pos(snake_size-1)
	food_eated.emit(snake_pos[0])


func get_snake_pos_dict() -> Dictionary:
	var snake_pos_dict: Dictionary = {}
	for i in snake_pos:
		snake_pos_dict[i] = true
	return snake_pos_dict


func get_snake_pos_dict_no_head() -> Dictionary:
	var snake_pos_dict: Dictionary = {}
	for i in range(snake_size):
		if i != 0:
			snake_pos_dict[snake_pos[i]] = true
	return snake_pos_dict


func add_snake_part(pos: Vector2i, dir: Vector2i) -> void:
	snake_pos.append(pos)
	snake_dir.append(dir)
	add_snake_node()
	snake_size += 1


# Agrega un nodo hijo al nodo Snake
func add_snake_node() -> void:
	var snake_node = Sprite2D.new()
	add_child(snake_node)
	snake_nodes.append(snake_node)


func set_snake_node_pos(index: int) -> void:
	snake_nodes[index].position = (snake_pos[index] * cell_size) + Vector2i(cell_size/2, cell_size/2)


func set_snake_node_sprite(index: int, dir: Vector2i, sprite: Resource) -> void:
	match dir:
		Vector2i.UP:
			snake_nodes[index].rotation_degrees = -90
		Vector2i.DOWN:
			snake_nodes[index].rotation_degrees = 90
		Vector2i.RIGHT:
			snake_nodes[index].rotation_degrees = 0
		Vector2i.LEFT:
			snake_nodes[index].rotation_degrees = 180
	snake_nodes[index].texture = sprite


func set_snake_nodes_sprites() -> void:
	for i in range(snake_size):
		# Sprite head
		if i == 0:
			set_snake_node_sprite(i, snake_dir[i], head_sprite)
		# Sprite tail
		elif i == snake_nodes.size() - 1:
			set_snake_node_sprite(i, snake_dir[i], tail_sprite)
		# Corner inferior derecha
		elif ((return_snake_part_updated_pos(snake_pos[i], Vector2i.UP) == snake_pos[i-1]) and (return_snake_part_updated_pos(snake_pos[i], Vector2i.LEFT) == snake_pos[i+1])) or ((return_snake_part_updated_pos(snake_pos[i], Vector2i.LEFT) == snake_pos[i-1]) and (return_snake_part_updated_pos(snake_pos[i], Vector2i.UP) == snake_pos[i+1])):
			set_snake_node_sprite(i, Vector2i.RIGHT, corner_sprite)
		# Corner superior derecha
		elif ((return_snake_part_updated_pos(snake_pos[i], Vector2i.LEFT) == snake_pos[i-1]) and (return_snake_part_updated_pos(snake_pos[i], Vector2i.DOWN) == snake_pos[i+1])) or ((return_snake_part_updated_pos(snake_pos[i], Vector2i.DOWN) == snake_pos[i-1]) and (return_snake_part_updated_pos(snake_pos[i], Vector2i.LEFT) == snake_pos[i+1])):
			set_snake_node_sprite(i, Vector2i.UP, corner_sprite)
		# Corner superior izquierda
		elif ((return_snake_part_updated_pos(snake_pos[i], Vector2i.DOWN) == snake_pos[i-1]) and (return_snake_part_updated_pos(snake_pos[i], Vector2i.RIGHT) == snake_pos[i+1])) or ((return_snake_part_updated_pos(snake_pos[i], Vector2i.RIGHT) == snake_pos[i-1]) and (return_snake_part_updated_pos(snake_pos[i], Vector2i.DOWN) == snake_pos[i+1])):
			set_snake_node_sprite(i, Vector2i.LEFT, corner_sprite)
		# Corner inferior izquieda
		elif ((return_snake_part_updated_pos(snake_pos[i], Vector2i.RIGHT) == snake_pos[i-1]) and (return_snake_part_updated_pos(snake_pos[i], Vector2i.UP) == snake_pos[i+1])) or ((return_snake_part_updated_pos(snake_pos[i], Vector2i.UP) == snake_pos[i-1]) and (return_snake_part_updated_pos(snake_pos[i], Vector2i.RIGHT) == snake_pos[i+1])):
			set_snake_node_sprite(i, Vector2i.DOWN, corner_sprite)
		# Sprite body
		else: 
			set_snake_node_sprite(i, snake_dir[i], body_sprite)


func return_snake_part_updated_pos(snake_pos: Vector2i, dir: Vector2i) -> Vector2i:
	var updated_pos: Vector2i = snake_pos
	updated_pos += dir

	if passable_walls:
		# Dar la vuelta por los lados
		if updated_pos.x > map_size.x - 1:
			updated_pos.x = 0
		elif updated_pos.x < 0:
			updated_pos.x = map_size.x - 1
		# Dar la vuelta por arriba y abajo
		if updated_pos.y > map_size.y - 1:
			updated_pos.y = 0
		elif updated_pos.y < 0:
			updated_pos.y = map_size.y - 1

	return updated_pos


func set_snake_part_pos(index: int) -> void:
	snake_pos[index] = return_snake_part_updated_pos(snake_pos[index], snake_dir[index])


func set_snake_part_dir(index: int, dir: Vector2i) -> void:
	snake_dir[index] = dir


# Actualiza la direccion de cada parte de la serpiente menos la cabeza
func set_snake_dir():
	for i in range(snake_size-1, -1, -1):
		if i != 0:
			set_snake_part_dir(i, snake_dir[i-1])
