extends Node2D


# Definir variables
var timer : float # Cuenta el tiempo para actualizar cada tick del juego
var map_size: Vector2i # Tamaño del mapa en cantidad de casillas (ancho y alto)
var cell_size: int # Tamaño de las casillas cuadradas
var game_vel: float # Intervalo de velocidad a la que avanza el juego en segundos
var apple: Sprite2D # Nodo de la manzana
var apple_pos: Vector2i # Posicion de la manzana (casilla)
var snake: Node2D # Nodo de la serpiente
var dir: Vector2i
var snake_pos: Array
var win: bool

var rng = RandomNumberGenerator.new() # Generación de números aleatorios

# Definir sprites
var apple_sprite = preload("res://assets/sprites/apple.png")

func _ready():
	win = false
	snake = $Snake
	apple = $Apple
	map_size = Vector2i(10, 10) # Definir tamaño del mapa (temporal)
	cell_size = 16 # Definir tamaño de las casillas en pixeles
	game_vel = 0.4 # Definir el intervalo de velocidad en segundos
	call_deferred("drawApple")
	queue_redraw()

func _process(delta):
	# Comprobar inputs
	if Input.is_action_pressed("move_up") and snake.snake[0][1] != Vector2i.DOWN:
		dir = Vector2i.UP 
	elif Input.is_action_pressed("move_down") and snake.snake[0][1] != Vector2i.UP:
		dir = Vector2i.DOWN
	elif Input.is_action_pressed("move_right") and snake.snake[0][1] != Vector2i.LEFT:
		dir = Vector2i.RIGHT
	elif Input.is_action_pressed("move_left") and snake.snake[0][1] != Vector2i.RIGHT:
		dir = Vector2i.LEFT

	timer += delta
	if timer >= game_vel:
		timer = 0.0
		snake.snake[0][1] = dir
		del2DSprites(snake)
		snake.updateSnakePos()
		snake.updateSnakeDir()

		snake_pos = []
		for j in snake.snake:
			snake_pos.append(j[0])
		snake_pos.pop_front()

		# Ganar
		if win == true:
			print("ganaste")
			get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
		if snake.snake.size() >= (map_size.x * map_size.y):
			apple.position = returnSpritePos(apple_pos)
			win = true

		# Perder
		elif snake.snake[0][0] in snake_pos:
			print("perdiste")
			get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
		
		# Redibujar manzana
		elif apple_pos == Vector2i(-1, -1):
			drawApple()
		
		snake.drawSnakeSprites()

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

func drawApple(): # Dibuja la manzana en el mapa de forma aleatoria teniendo en cuenta a la serpiente
	var n: int
	snake_pos = []
	while true:
		n = rng.randi_range(0, map_size.x - 1)
		apple_pos.x = n
		n = rng.randi_range(0, map_size.y - 1)
		apple_pos.y = n
		for i in snake.snake:
			snake_pos.append(i[0])
		if apple_pos not in snake_pos:
			break
	apple.position = returnSpritePos(apple_pos)

func drawSprite(sprite, texture, pos, rot, node): # Dibuja un sprite en pantalla
	sprite.texture = texture
	sprite.position = returnSpritePos(pos)
	sprite.rotation_degrees = rot
	node.add_child(sprite)

func returnSpritePos(pos): # Retorna la posición a la que debe dibujarse un sprite en la pantalla
	return (pos * cell_size) + Vector2i(cell_size / 2, cell_size / 2)

func returnSpriteRotation(d): # Retorna la rotacion de un sprite dependiendo de su dirección
	match d:
		Vector2i.UP:
			return -90
		Vector2i.DOWN:
			return 90
		Vector2i.RIGHT:
			return 0
		Vector2i.LEFT:
			return 180

func del2DSprites(node): # Borra todos los Sprites2D
	for i in node.get_children():
		if i is Sprite2D:
			i.queue_free()
