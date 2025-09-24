extends Node2D


var timer : float = 0.0 # Contar el tiempo
var move_time : float = 1.0 # Intervalo de movimiento en segundos
# Serpiente inicial tamaño 3
var snake: Array = [
	[Vector2i(11, 5), Vector2i.RIGHT],
	[Vector2i(10, 5), Vector2i.RIGHT], 
	[Vector2i(9, 5), Vector2i.RIGHT]
]


# Definir sprites
@onready var head_animation = $Head # Temporal (placeholder)
var body_sprite = preload("res://assets/sprites/snake_body.png") # Temporal (placeholder)
var corner_sprite = preload("res://assets/sprites/snake_corner.png") # Temporal (placeholder)
var tail_sprite = preload("res://assets/sprites/snake_tail.png") # Temporal (placeholder)


func _ready():
	drawSprite()
	head_animation.play("head_animation") # Animacion de la cabeza de la serpiente

func _process(delta):
	timer += delta
	if timer >= move_time:
		timer = 0.0
		delSprites()
		updateSnakePos()
		drawSprite()


func updateSnakePos(): # Actualiza la posicion en la celda de cada parte de la serpiente sumando su posicion actual con su direccion
	for i in snake:
		i[0] += i[1]

func updateSpritePos(sprite, pos): # Actualiza la posicion en la pantalla de un sprite
	sprite.position = pos * 16

func drawSprite(): # Dibuja los sprites de cada parte de la serpiente en la pantalla
		for i in range(snake.size()):
			if i == 0:
				updateSpritePos(head_animation, snake[0][0])
				updateSpriteDir(head_animation, snake[0][1])
			else:
				var sprite = Sprite2D.new()
				if i == (snake.size() - 1):
					sprite.texture = tail_sprite
				else:
					sprite.texture = body_sprite
				sprite.centered = false
				updateSpritePos(sprite, snake[i][0])
				updateSpriteDir(sprite, snake[i][1])
				add_child(sprite)

func updateSpriteDir(sprite, dir): # Actualiza la direccion de un sprite
	match dir:
		Vector2i.RIGHT:
			sprite.rotation_degrees = 0
		Vector2i.DOWN:
			sprite.rotation_degrees = 90
		Vector2i.LEFT:
			sprite.rotation_degrees = 180
		Vector2i.UP:
			sprite.rotation_degrees = -90

func delSprites(): # Borra todos los Sprite2D antiguos
	for i in get_children():
		if i is Sprite2D:
			i.queue_free()
