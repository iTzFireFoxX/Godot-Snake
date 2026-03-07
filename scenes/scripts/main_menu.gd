extends Control


@onready var title = $Title
@onready var main_buttons = $MainButtons
@onready var version = $Version
@onready var play_menu = $PlayMenu
@onready var options_menu = $OptionsMenu


func _ready():
	version.text = "v" + str(ProjectSettings.get("application/config/version"))

func _on_play_pressed() -> void:
	self.visible = false
	get_tree().change_scene_to_file("res://scenes/Game.tscn")

func _on_options_pressed() -> void:
	title.visible = false
	version.visible = false

	main_buttons.visible = false
	options_menu.visible = true

func _on_exit_pressed() -> void:
	get_tree().quit()
