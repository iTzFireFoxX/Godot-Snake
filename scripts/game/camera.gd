extends Camera2D


@onready var cell_size: int = GameSettings.cell_size
@onready var map_size: Vector2 = GameSettings.game_settings["map_size"]

@onready var GameStats: Control = %GameStats

@onready var border_px: float = 32.0


func _ready() -> void:
	get_viewport().size_changed.connect(update_camera)
	GameStats.resized.connect(update_camera)
	update_camera()
	

func update_camera() -> void:
	var viewport_size: Vector2 = get_viewport_rect().size

	var zoom_x: float = (viewport_size.x - (border_px * 2)) / (map_size.x * cell_size)
	var zoom_y: float = (viewport_size.y - (GameStats.position.y + GameStats.size.y) - (border_px * 2)) / (map_size.y * cell_size)

	zoom = Vector2(min(zoom_x, zoom_y), min(zoom_x, zoom_y))

	position = Vector2((map_size * cell_size) / 2.0) - Vector2(0, ((GameStats.position.y + GameStats.size.y) / 2.0) / min(zoom_x, zoom_y))
