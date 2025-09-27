extends Node2D


# Definir variables
var game: Node2D # La variable del Node2D padre para obtener sus variables y funciones
var dir: Vector2i # Indica la dirección inicial que tendra la serpiente
var timer : float # Cuenta el tiempo para cada tick del juego
var snake: Array # El array que contiene todas las partes de la serpiente incluida la cabeza

# Definir sprites
@onready var head_animation = $Head # Temporal (placeholder)
var body_sprite = preload("res://assets/sprites/snake_body.png") # Temporal (placeholder)
var corner_sprite = preload("res://assets/sprites/snake_corner.png") # Temporal (placeholder)
var tail_sprite = preload("res://assets/sprites/snake_tail.png") # Temporal (placeholder)


func _ready():
	call_deferred("initSetup")

func _process(delta):
	
	if Input.is_action_pressed("move_up") and snake[0][1] != Vector2i.DOWN:
		dir = Vector2i.UP 
	elif Input.is_action_pressed("move_down") and snake[0][1] != Vector2i.UP:
		dir = Vector2i.DOWN
	elif Input.is_action_pressed("move_right") and snake[0][1] != Vector2i.LEFT:
		dir = Vector2i.RIGHT
	elif Input.is_action_pressed("move_left") and snake[0][1] != Vector2i.RIGHT:
		dir = Vector2i.LEFT

	timer += delta

	if timer >= game.game_vel:
		timer = 0.0
		snake[0][1] = dir
		delSprites()
		updateSnakePos()
		updateSnakeDir()
		drawSprites()

func initSetup():
	game = get_parent() # Llama al nodo padre
	dir = Vector2i.RIGHT # Dirección inicial derecha
	timer = 0.0 # Tiempo inicial en 0
	snake = [
		[Vector2i((game.map_size.x / 2) + 1, game.map_size.y / 2), Vector2i.RIGHT],
		[Vector2i(game.map_size.x / 2, game.map_size.y / 2), Vector2i.RIGHT],
		[Vector2i((game.map_size.x / 2) - 1, game.map_size.y / 2), Vector2i.RIGHT]
	] # Serpiente inicial
	drawSprites()
	head_animation.play("head_animation") # Iniciar animacion de la cabeza de la serpiente
	
func updateSnakePos(): # Actualiza la posicion en la celda de cada parte de la serpiente sumando su posicion actual con su direccion
	for i in snake:
		i[0] += i[1]

		# Dar la vuelta por los lados
		if i[0].x > game.map_size.x - 1:
			i[0].x = 0
		elif i[0].x < 0:
			i[0].x = game.map_size.x - 1

		# Dar la vuelta por arriba y abajo
		if i[0].y > game.map_size.y - 1:
			i[0].y = 0
		elif i[0].y < 0:
			i[0].y = game.map_size.y - 1

func updateSpritePos(sprite, pos): # Actualiza la posicion en la pantalla de un sprite
	sprite.position = (pos * game.cell_size) + Vector2i(game.cell_size / 2, game.cell_size / 2)

func drawSprites(): # Dibuja los sprites de cada parte de la serpiente en la pantalla
		for i in range(snake.size()):
			if i == 0:
				updateSpritePos(head_animation, snake[0][0])
				updateSpriteRotation(head_animation, snake[0][1])
			else:
				var sprite = Sprite2D.new()
				if i == (snake.size() - 1):
					sprite.texture = tail_sprite
				else:
					# Esquina inferior derecha
					if (snake[i - 1][0] == snake[i][0] + Vector2i.UP) and (snake[i + 1][0] == snake[i][0] + Vector2i.LEFT):
						sprite.texture = corner_sprite
						updateSpritePos(sprite, snake[i][0])
						add_child(sprite) # Añadir sprite como nodo hijo
						continue
					elif (snake[i - 1][0] == snake[i][0] + Vector2i.LEFT) and (snake[i + 1][0] == snake[i][0] + Vector2i.UP):
						sprite.texture = corner_sprite
						updateSpritePos(sprite, snake[i][0])
						add_child(sprite) # Añadir sprite como nodo hijo
						continue

					# Esquina superior derecha
					elif (snake[i - 1][0] == snake[i][0] + Vector2i.LEFT) and (snake[i + 1][0] == snake[i][0] + Vector2i.DOWN):
						sprite.texture = corner_sprite
						updateSpritePos(sprite, snake[i][0])
						updateSpriteRotation(sprite, Vector2i.UP)
						add_child(sprite) # Añadir sprite como nodo hijo
						continue
					elif (snake[i - 1][0] == snake[i][0] + Vector2i.DOWN) and (snake[i + 1][0] == snake[i][0] + Vector2i.LEFT):
						sprite.texture = corner_sprite
						updateSpritePos(sprite, snake[i][0])
						updateSpriteRotation(sprite, Vector2i.UP)
						add_child(sprite) # Añadir sprite como nodo hijo
						continue
						
					# Esquina superior izquierda
					elif (snake[i - 1][0] == snake[i][0] + Vector2i.DOWN) and (snake[i + 1][0] == snake[i][0] + Vector2i.RIGHT):
						sprite.texture = corner_sprite
						updateSpritePos(sprite, snake[i][0])
						updateSpriteRotation(sprite, Vector2i.LEFT)
						add_child(sprite) # Añadir sprite como nodo hijo
						continue
					elif (snake[i - 1][0] == snake[i][0] + Vector2i.RIGHT) and (snake[i + 1][0] == snake[i][0] + Vector2i.DOWN):
						sprite.texture = corner_sprite
						updateSpritePos(sprite, snake[i][0])
						updateSpriteRotation(sprite, Vector2i.LEFT)
						add_child(sprite) # Añadir sprite como nodo hijo
						continue

					# Esquina inferior izquieda
					elif (snake[i - 1][0] == snake[i][0] + Vector2i.RIGHT) and (snake[i + 1][0] == snake[i][0] + Vector2i.UP):
						sprite.texture = corner_sprite
						updateSpritePos(sprite, snake[i][0])
						updateSpriteRotation(sprite, Vector2i.DOWN)
						add_child(sprite) # Añadir sprite como nodo hijo
						continue
					elif (snake[i - 1][0] == snake[i][0] + Vector2i.UP) and (snake[i + 1][0] == snake[i][0] + Vector2i.RIGHT):
						sprite.texture = corner_sprite
						updateSpritePos(sprite, snake[i][0])
						updateSpriteRotation(sprite, Vector2i.DOWN)
						add_child(sprite) # Añadir sprite como nodo hijo
						continue

					else:
						sprite.texture = body_sprite
				updateSpritePos(sprite, snake[i][0])
				updateSpriteRotation(sprite, snake[i][1])
				add_child(sprite) # Añadir sprite como nodo hijo

func updateSpriteRotation(sprite, d): # Actualiza la rotacion de un sprite
	match d:
		Vector2i.UP:
			sprite.rotation_degrees = -90
		Vector2i.DOWN:
			sprite.rotation_degrees = 90
		Vector2i.RIGHT:
			sprite.rotation_degrees = 0
		Vector2i.LEFT:
			sprite.rotation_degrees = 180

func delSprites(): # Borra todos los Sprite2D antiguos
	for i in get_children():
		if i is Sprite2D:
			i.queue_free()

func updateSnakeDir(): # Actualiza la direccion de cada parte de la serpiente menos la cabeza
	for i in range(snake.size() -1, -1, -1):
		if i != 0:
			snake[i][1] = snake[i - 1][1]
