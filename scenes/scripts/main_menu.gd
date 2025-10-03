extends Control


@onready var version = $Version

func _ready():
	version.text = "v" + str(ProjectSettings.get("application/config/version"))

func _on_play_pressed() -> void:
	self.visible = false
	get_tree().change_scene_to_file("res://scenes/Game.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
