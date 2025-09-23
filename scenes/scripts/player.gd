extends Node2D

var pos : Vector2i = Vector2i(10, 5) # Comenzar en el centro
var dir : Vector2i = Vector2i.RIGHT # Comenzar moviendo hacia la derecha
var timer : float = 0.0 # Contar el tiempo
var move_time : float = 1 # Intervalo de movimiento

@onready var anim = $AnimatedSprite2D

func _ready():
    position = pos * 16

func _process(delta):
    timer += delta
    if timer >= move_time:
        timer = 0.0
        pos += dir
        position = pos * 16

    anim.play("default")