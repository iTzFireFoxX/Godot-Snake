extends Node2D


# Definir variables
var game: Node2D # La variable del Node2D padre para obtener sus variables y funciones
var snake: Array # El array que contiene todas las partes de la serpiente incluida la cabeza

# Definir sprites
@onready var head = $Head # Temporal (placeholder)
var body_sprite = preload("res://assets/sprites/snake_body.png") # Temporal (placeholder)
var corner_sprite = preload("res://assets/sprites/snake_corner.png") # Temporal (placeholder)
var tail_sprite = preload("res://assets/sprites/snake_tail.png") # Temporal (placeholder)


func _ready():
	call_deferred("initSetup")

func initSetup():
	game = get_parent() # Llama al nodo padre
	game.dir = Vector2i.RIGHT # Dirección inicial derecha
	snake = [
		[Vector2i((game.map_size.x / 2) + 1, game.map_size.y / 2), Vector2i.RIGHT],
		[Vector2i(game.map_size.x / 2, game.map_size.y / 2), Vector2i.RIGHT],
		[Vector2i((game.map_size.x / 2) - 1, game.map_size.y / 2), Vector2i.RIGHT]
	] # Serpiente inicial
	drawSnakeSprites()
	head.play("head_animation") # Iniciar animacion de la cabeza de la serpiente
	
func updateSnakePos(): # Actualiza la posicion en la celda de cada parte de la serpiente sumando su posicion actual con su direccion
	for i in range(snake.size()):

		snake[i][0] = returnUpdatedPos(snake[i][0], snake[i][1])

		if i == 0:
			if snake[0][0] == game.apple_pos:
				addSnakePart()
				game.apple_pos = Vector2i(-1, -1)

func returnUpdatedPos(pos, dir): # Retorna la posicion actualizada de una parte de la serpiente en base a la dirección que tiene

	var updated_pos: Vector2i

	updated_pos = pos + dir

	# Dar la vuelta por los lados
	if pos.x > game.map_size.x - 1:
		updated_pos.x = 0
	elif pos.x < 0:
		updated_pos.x = game.map_size.x - 1

	# Dar la vuelta por arriba y abajo
	if pos.y > game.map_size.y - 1:
		updated_pos.y = 0
	elif pos.y < 0:
		updated_pos.y = game.map_size.y - 1
	
	return updated_pos

func drawSnakeSprites(): # Dibuja los sprites de cada parte de la serpiente en la pantalla
		for i in range(snake.size()):

			# Animación head
			if i == 0:
				head.position = game.returnSpritePos(snake[0][0])
				head.rotation_degrees = game.returnSpriteRotation(snake[0][1])
			else:
				var sprite = Sprite2D.new()

				# Sprite cola
				if i == (snake.size() - 1):
					game.drawSprite(sprite, tail_sprite, snake[i][0], game.returnSpriteRotation(snake[i][1]), self)

				# Sprite esquinas
				else:

					# Esquina inferior derecha
					if ((snake[i - 1][0] == snake[i][0] + Vector2i.UP) and (snake[i + 1][0] == snake[i][0] + Vector2i.LEFT) or (snake[i - 1][0] == snake[i][0] + Vector2i.LEFT) and (snake[i + 1][0] == snake[i][0] + Vector2i.UP)):
						game.drawSprite(sprite, corner_sprite, snake[i][0], 0, self)

					# Esquina superior derecha
					elif ((snake[i - 1][0] == snake[i][0] + Vector2i.LEFT) and (snake[i + 1][0] == snake[i][0] + Vector2i.DOWN) or (snake[i - 1][0] == snake[i][0] + Vector2i.DOWN) and (snake[i + 1][0] == snake[i][0] + Vector2i.LEFT)):
						game.drawSprite(sprite, corner_sprite, snake[i][0], -90, self)

					# Esquina superior izquierda
					elif ((snake[i - 1][0] == snake[i][0] + Vector2i.DOWN) and (snake[i + 1][0] == snake[i][0] + Vector2i.RIGHT) or (snake[i - 1][0] == snake[i][0] + Vector2i.RIGHT) and (snake[i + 1][0] == snake[i][0] + Vector2i.DOWN)):
						game.drawSprite(sprite, corner_sprite, snake[i][0], 180, self)

					# Esquina inferior izquieda
					elif ((snake[i - 1][0] == snake[i][0] + Vector2i.RIGHT) and (snake[i + 1][0] == snake[i][0] + Vector2i.UP) or (snake[i - 1][0] == snake[i][0] + Vector2i.UP) and (snake[i + 1][0] == snake[i][0] + Vector2i.RIGHT)):
						game.drawSprite(sprite, corner_sprite, snake[i][0], 90, self)

					# Sprite body
					else: 
						game.drawSprite(sprite, body_sprite, snake[i][0], game.returnSpriteRotation(snake[i][1]), self)

func updateSnakeDir(): # Actualiza la direccion de cada parte de la serpiente menos la cabeza
	for i in range(snake.size() -1, -1, -1):
		if i != 0:
			snake[i][1] = snake[i - 1][1]

func addSnakePart(): # Añade una parte a la serpiente
	snake.append([snake[snake.size() - 1][0], snake[snake.size() - 1][1]])
