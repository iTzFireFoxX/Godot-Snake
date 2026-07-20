extends Node2D


var food_pos: Dictionary = {}
var food_nodes: Array[Node] = []


var food_sprites: Array = GameSettings.appearance_settings["food_sprites"]


@onready var cell_size: int = GameSettings.cell_size


@onready var food_amount: int = GameSettings.game_settings["food_amount"]


func init_food(empty_cells: Dictionary) -> void:
	var random_pos: Vector2i
	for i in range(food_amount):
		random_pos = return_valid_food_cells(empty_cells).pick_random()
		food_pos[random_pos] = i
		add_food_node()
		set_food_node_pos(i, random_pos)
		set_food_node_sprite(i, food_sprites.pick_random())


func get_food_pos() -> Dictionary:
	return food_pos


func update_food_pos(pos: Vector2i, empty_cells: Dictionary) -> void:
	var valid_cells: Array[Vector2i] = return_valid_food_cells(empty_cells)
	var index: int = food_pos[pos]
	food_pos.erase(pos)
	if valid_cells.is_empty():
		food_nodes[index].queue_free()
	else:
		var random_pos = valid_cells.pick_random()
		food_pos[random_pos] = index
		set_food_node_pos(index, random_pos)
		if GameSettings.appearance_settings["change_food_on_eat"]:
			set_food_node_sprite(index, food_sprites.pick_random())


func return_valid_food_cells(empty_cells: Dictionary) -> Array[Vector2i]:
	var valid_cells: Array[Vector2i] = []
	for i in empty_cells:
		if not food_pos.has(i):
			valid_cells.append(i)
	return valid_cells


# Agrega un nodo hijo al nodo Food
func add_food_node() -> void:
	var food_node = Sprite2D.new()
	add_child(food_node)
	food_nodes.append(food_node)


func set_food_node_pos(index: int, pos: Vector2i) -> void:
	food_nodes[index].position = (pos * cell_size) + Vector2i(cell_size / 2, cell_size / 2)


func set_food_node_sprite(index: int, sprite: Resource) -> void:
	food_nodes[index].texture = sprite
