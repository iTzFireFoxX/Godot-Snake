extends ScrollContainer


# Diff Buttons
@onready var VeryEasyDiff: Button = %VeryEasyDiff
@onready var EasyDiff: Button = %EasyDiff
@onready var NormalDiff: Button = %NormalDiff
@onready var HardDiff: Button = %HardDiff
@onready var CustomDiff: Button = %CustomDiff


# Map Size Inputs
@onready var WidthInput: LineEdit = %WidthInput
@onready var HeightInput: LineEdit = %HeightInput


# GameVel Buttons
@onready var SlowVel: Button = %SlowVel
@onready var NormalVel: Button = %NormalVel
@onready var FastVel: Button = %FastVel
@onready var VeryFastVel: Button = %VeryFastVel
@onready var CustomVel: Button = %CustomVel

@onready var CustomVelInput: LineEdit = %CustomVelInput


# PassableWalls Buttons
@onready var PWYes: Button = %PWYes
@onready var PWNo: Button = %PWNo


func _on_play_menu_draw() -> void:
	NormalDiff.pressed.emit()
	NormalDiff.button_pressed = true


func _on_very_easy_diff_pressed() -> void:
	_toggleEditablePlayConfig(false)

	WidthInput.text = "5"
	HeightInput.text = "5"

	GameSettings.map_size = Vector2i(5, 5)

	SlowVel.emit_signal("pressed")
	SlowVel.button_pressed = true

	PWYes.emit_signal("pressed")
	PWYes.button_pressed = true


func _on_easy_diff_pressed() -> void:
	_toggleEditablePlayConfig(false)

	WidthInput.text = "10"
	HeightInput.text = "10"

	GameSettings.map_size = Vector2i(10, 10)

	NormalVel.emit_signal("pressed")
	NormalVel.button_pressed = true

	PWYes.emit_signal("pressed")
	PWYes.button_pressed = true

func _on_normal_diff_pressed() -> void:
	_toggleEditablePlayConfig(false)

	WidthInput.text = "15"
	HeightInput.text = "15"

	GameSettings.map_size = Vector2i(15, 15)

	FastVel.emit_signal("pressed")
	FastVel.button_pressed = true
	
	PWNo.emit_signal("pressed")
	PWNo.button_pressed = true

func _on_hard_diff_pressed() -> void:
	_toggleEditablePlayConfig(false)

	WidthInput.text = "20"
	HeightInput.text = "20"

	GameSettings.map_size = Vector2i(20, 20)

	VeryFastVel.emit_signal("pressed")
	VeryFastVel.button_pressed = true

	PWNo.emit_signal("pressed")
	PWNo.button_pressed = true


func _on_custom_diff_pressed() -> void:
	_toggleEditablePlayConfig(true)


func _on_slow_vel_pressed() -> void:
	CustomVelInput.editable = false
	CustomVelInput.text = "1"

	GameSettings.game_vel = 1


func _on_normal_vel_pressed() -> void:
	CustomVelInput.editable = false
	CustomVelInput.text = "0.5"

	GameSettings.game_vel = 0.5

func _on_fast_vel_pressed() -> void:
	CustomVelInput.editable = false
	CustomVelInput.text = "0.25"

	GameSettings.game_vel = 0.25


func _on_very_fast_vel_pressed() -> void:
	CustomVelInput.editable = false
	CustomVelInput.text = "0.1"

	GameSettings.game_vel = 0.1

func _on_custom_vel_pressed() -> void:
	CustomVelInput.editable = true


func _on_pw_yes_pressed() -> void:
	GameSettings.passable_walls = true


func _on_pw_no_pressed() -> void:
	GameSettings.passable_walls = false


func _toggleEditablePlayConfig(toggle: bool) -> void:
	WidthInput.editable = toggle
	HeightInput.editable = toggle

	var mouse_mode = Control.MOUSE_FILTER_STOP if toggle else Control.MOUSE_FILTER_IGNORE
	var opacity = 1.0 if toggle else 0.6

	SlowVel.mouse_filter = mouse_mode
	SlowVel.modulate.a = opacity

	NormalVel.mouse_filter = mouse_mode
	NormalVel.modulate.a = opacity

	FastVel.mouse_filter = mouse_mode
	FastVel.modulate.a = opacity

	VeryFastVel.mouse_filter = mouse_mode
	VeryFastVel.modulate.a = opacity

	CustomVel.mouse_filter = mouse_mode
	CustomVel.modulate.a = opacity

	PWYes.mouse_filter = mouse_mode
	PWYes.modulate.a = opacity

	PWNo.mouse_filter = mouse_mode
	PWNo.modulate.a = opacity


func _on_width_input_text_changed(new_text: String) -> void:
	GameSettings.map_size.x = new_text.to_int()


func _on_height_input_text_changed(new_text: String) -> void:
	GameSettings.map_size.y = new_text.to_int()


func _on_custom_vel_input_text_changed(new_text: String) -> void:
	GameSettings.game_vel = new_text.to_float()
