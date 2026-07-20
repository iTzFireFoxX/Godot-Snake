extends Control


# FullScreen Buttons
@onready var FSYes: Button = %FSYes
@onready var FSNo: Button = %FSNo


func _on_fs_no_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)


func _on_fs_yes_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
