extends Camera2D


@onready var cell_size: int = GameSettings.cell_size
@onready var map_size: Vector2 = GameSettings.game_settings["map_size"]

@onready var ui_top_px: float = 128.0
@onready var border_px: float = 0.5 * cell_size 


func _ready() -> void:
	get_viewport().size_changed.connect(_on_viewport_size_changed)
	update_camera()


func _on_viewport_size_changed() -> void:
	update_camera()


func update_camera() -> void:
	var viewport_size: Vector2 = get_viewport_rect().size
	
	var zoom_x: float = (viewport_size.y - ui_top_px) / ((map_size.x * cell_size) + (border_px * 2))
	var zoom_y: float = viewport_size.x / ((map_size.y * cell_size) + (border_px * 2))
	
	zoom = Vector2(min(zoom_x, zoom_y), min(zoom_x, zoom_y))

	position = Vector2((map_size.x * cell_size) / 2.0, (map_size.y * cell_size) / 2.0) - Vector2(0, (ui_top_px / 2.0) / min(zoom_x, zoom_y))
