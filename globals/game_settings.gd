extends Node


var cell_size: int = 16


# Config del juego
var map_size: Vector2i
var game_vel: float
var passable_walls: bool
var food_amount: int = 1

# Config de apariencia
var map_color: Array[Color]