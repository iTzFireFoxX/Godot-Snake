extends Control

@onready var VersionLabel = %VersionLabel # Nodo label para mostrar la versión actual
@onready var MainMenuControl = %MainMenuControl # Main menu
@onready var PlayMenuControl = %PlayMenuControl # Play menu
@onready var OptionsMenuControl = %OptionsMenuControl # Options menu
@onready var GameTabButton = %GameTabButton
@onready var AppearanceTabButton = %AppearanceTabButton


func _ready():
	VersionLabel.text = "v" + str(ProjectSettings.get("application/config/version")) # Obtener la versión actual del proyecto

func _on_play_config_pressed() -> void: # Menu de jugar
	MainMenuControl.hide()
	VersionLabel.hide()
	PlayMenuControl.show()

	GameTabButton.button_pressed = true


func _on_options_pressed() -> void: # Menu de opciones
	MainMenuControl.hide()
	VersionLabel.hide()
	OptionsMenuControl.show()


func _on_exit_pressed() -> void: # Salir
	get_tree().quit()


func _on_back_button_pressed() -> void: # Boton de volver
	OptionsMenuControl.hide()
	PlayMenuControl.hide()
	MainMenuControl.show()
	VersionLabel.show()


func _on_play_button_pressed() -> void: # Boton de jugar

	self.hide()
	get_tree().change_scene_to_file("res://scenes/Game.tscn")
