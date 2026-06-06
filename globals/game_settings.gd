extends Node


var cell_size: int = 16


# Config actual del juego
var game_settings: Dictionary = {}
var appearance_settings: Dictionary = {}


# Config predefinida
const game_vels: Dictionary = {
    "very_slow": 1.0,
    "slow": 0.75,
    "normal": 0.5,
    "fast": 0.25,
    "very_fast": 0.1
}

const very_easy_diff: Dictionary = {
    "map_size": Vector2i(8, 8),
    "game_vel": game_vels["very_slow"],
    "food_amount": 5,
    "initial_size": 5,
    "passable_walls": true
}

const easy_diff: Dictionary = {
    "map_size": Vector2i(10, 10),
    "game_vel": game_vels["slow"],
    "food_amount": 2,
    "initial_size": 4,
    "passable_walls": true
}

const normal_diff: Dictionary = {
    "map_size": Vector2i(12, 12),
    "game_vel": game_vels["normal"],
    "food_amount": 1,
    "initial_size": 3,
    "passable_walls": false
}

const hard_diff: Dictionary = {
    "map_size": Vector2i(15, 15),
    "game_vel": game_vels["fast"],
    "food_amount": 1,
    "initial_size": 3,
    "passable_walls": false
}

const very_hard_diff: Dictionary = {
    "map_size": Vector2i(20, 20),
    "game_vel": game_vels["very_fast"],
    "food_amount": 1,
    "initial_size": 3,
    "passable_walls": false
}

const initial_appearance_settings: Dictionary = {
    "map_color": [Color("#75a743"), Color("#468232")]
}


func _ready() -> void:
    set_diff("normal")
    appearance_settings = initial_appearance_settings.duplicate()


func set_map_size_x(x: int) -> void:
    game_settings["map_size"].x = x


func set_map_size_y(y: int) -> void:
    game_settings["map_size"].y = y


func set_game_vel(game_vel: float) -> void:
    game_settings["game_vel"] = game_vel


func set_food_amount(food_amount: int) -> void:
    game_settings["food_amount"] = food_amount


func set_initial_size(initial_size: int) -> void:
    game_settings["initial_size"] = initial_size


func set_passable_walls(passable_walls: bool) -> void:
    game_settings["passable_walls"] = passable_walls


func set_diff(diff: String) -> void:
    match diff:
        "very_easy":
            game_settings = very_easy_diff.duplicate()
        "easy":
            game_settings = easy_diff.duplicate()
        "normal":
            game_settings = normal_diff.duplicate()
        "hard":
            game_settings = hard_diff.duplicate()
        "very_hard":
            game_settings = very_hard_diff.duplicate()
