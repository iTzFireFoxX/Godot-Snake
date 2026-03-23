extends Control

@onready var VersionLabel = %VersionLabel # Nodo label para mostrar la versión actual
@onready var MainMenuControl = %MainMenuControl # Main menu
@onready var PlayMenuControl = %PlayMenuControl # Play menu
@onready var OptionsMenuControl = %OptionsMenuControl # Options menu

@onready var GameTabButton = %GameTabButton
@onready var AppearanceTabButton = %AppearanceTabButton

@onready var GameTabScroll = %GameTabScroll
@onready var AppearanceTabScroll = %AppearanceTabScroll

@onready var VeryEasyDiffButton = %VeryEasyDiffButton
@onready var EasyDiffButton = %EasyDiffButton
@onready var NormalDiffButton = %NormalDiffButton
@onready var HardDiffButton = %HardDiffButton
@onready var CustomDiffButton = %CustomDiffButton

@onready var SlowVelButton = %SlowVelButton
@onready var NormalVelButton = %NormalVelButton
@onready var FastVelButton = %FastVelButton
@onready var VeryFastVelButton = %VeryFastVelButton
@onready var CustomVelButton = %CustomVelButton

@onready var PWYesButton = %PWYesButton
@onready var PWNoButton = %PWNoButton

@onready var WidhtInput = %WidthInput
@onready var HeightInput = %HeightInput
@onready var CustomVelInput = %CustomVelInput


func _ready():
	VersionLabel.text = "v" + str(ProjectSettings.get("application/config/version")) # Obtener la versión actual del proyecto


func _on_play_config_pressed() -> void: # Menu de jugar
	MainMenuControl.hide()
	VersionLabel.hide()
	PlayMenuControl.show()

	GameTabButton.button_pressed = true
	_on_game_tab_button_pressed()

	NormalDiffButton.button_pressed = true
	_on_normal_diff_button_pressed()
	
	toggleEditablePlayConfig(false)
	CustomVelInput.editable = false


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

	GameSettings.map_size = Vector2i(WidhtInput.text.to_int(), HeightInput.text.to_int())
	GameSettings.game_vel = CustomVelInput.text.to_float()

	get_tree().change_scene_to_file("res://scenes/Game.tscn")


func _on_game_tab_button_pressed() -> void:
	AppearanceTabScroll.hide()
	GameTabScroll.show()


func _on_appearance_tab_button_pressed() -> void:
	GameTabScroll.hide()
	AppearanceTabScroll.show()


func _on_very_easy_diff_button_pressed() -> void:
	toggleEditablePlayConfig(false)
	WidhtInput.text = "5"
	HeightInput.text = "5"
	SlowVelButton.button_pressed = true
	_on_slow_vel_button_pressed()
	PWYesButton.button_pressed = true


func _on_easy_diff_button_pressed() -> void:
	toggleEditablePlayConfig(false)
	WidhtInput.text = "10"
	HeightInput.text = "10"
	NormalVelButton.button_pressed = true
	_on_normal_vel_button_pressed()
	PWYesButton.button_pressed = true


func _on_normal_diff_button_pressed() -> void:
	toggleEditablePlayConfig(false)
	WidhtInput.text = "15"
	HeightInput.text = "15"
	FastVelButton.button_pressed = true
	_on_fast_vel_button_pressed()
	PWNoButton.button_pressed = true


func _on_hard_diff_button_pressed() -> void:
	toggleEditablePlayConfig(false)
	WidhtInput.text = "20"
	HeightInput.text = "20"
	VeryFastVelButton.button_pressed = true
	_on_very_fast_vel_button_pressed()
	PWNoButton.button_pressed = true

func toggleEditablePlayConfig(toggle: bool) -> void:
	WidhtInput.editable = toggle
	HeightInput.editable = toggle

	var mouse_mode = Control.MOUSE_FILTER_STOP if toggle else Control.MOUSE_FILTER_IGNORE
	var opacity = 1.0 if toggle else 0.6

	SlowVelButton.mouse_filter = mouse_mode
	SlowVelButton.modulate.a = opacity
	NormalVelButton.mouse_filter = mouse_mode
	NormalVelButton.modulate.a = opacity
	FastVelButton.mouse_filter = mouse_mode
	FastVelButton.modulate.a = opacity
	VeryFastVelButton.mouse_filter = mouse_mode
	VeryFastVelButton.modulate.a = opacity
	CustomVelButton.mouse_filter = mouse_mode
	CustomVelButton.modulate.a = opacity
	PWYesButton.mouse_filter = mouse_mode
	PWYesButton.modulate.a = opacity
	PWNoButton.mouse_filter = mouse_mode
	PWNoButton.modulate.a = opacity


func _on_custom_diff_button_pressed() -> void:
	toggleEditablePlayConfig(true)


func _on_slow_vel_button_pressed() -> void:
	CustomVelInput.editable = false
	CustomVelInput.text = "1"

func _on_normal_vel_button_pressed() -> void:
	CustomVelInput.editable = false
	CustomVelInput.text = "0.5"

func _on_fast_vel_button_pressed() -> void:
	CustomVelInput.editable = false
	CustomVelInput.text = "0.25"

func _on_very_fast_vel_button_pressed() -> void:
	CustomVelInput.editable = false
	CustomVelInput.text = "0.1"

func _on_custom_vel_button_pressed() -> void:
	CustomVelInput.editable = true
