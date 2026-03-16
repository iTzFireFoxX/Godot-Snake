extends Control

@onready var version = $Version # Nodo label para mostrar la versión actual
@onready var main_menu_control = $MainMenuARContainer/MainMenuControl # Main menu
@onready var play_menu_control = $MainMenuARContainer/PlayMenuControl # Play menu
@onready var options_menu_control = $MainMenuARContainer/OptionsMenuControl # Options menu


func _ready():
	version.text = "v" + str(ProjectSettings.get("application/config/version")) # Obtener la versión actual del proyecto

func _on_play_pressed() -> void: # Reworkear menu de jugar
	self.visible = false
	get_tree().change_scene_to_file("res://scenes/Game.tscn")


func _on_options_pressed() -> void:
	main_menu_control.visible = false
	version.visible = false

	options_menu_control.visible = true


func _on_exit_pressed() -> void: # Salir
	get_tree().quit()
