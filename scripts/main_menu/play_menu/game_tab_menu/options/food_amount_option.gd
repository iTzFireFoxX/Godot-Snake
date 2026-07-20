extends Control


signal game_settings_updated()


@onready var MapSizeOption: Control = %MapSizeOption
@onready var InitialSizeOption: Control = %InitialSizeOption

# FoodAmount Input
@onready var FoodAmountInput: LineEdit = %FoodAmountInput


func _ready() -> void:
	MapSizeOption.game_settings_updated.connect(_on_game_settings_updated)
	InitialSizeOption.game_settings_updated.connect(_on_game_settings_updated)


func _on_game_settings_updated() -> void:
	_set_food_amount(FoodAmountInput.text)


func _set_food_amount(food_amount: String) -> void:
	if food_amount.to_int() < 1:
		FoodAmountInput.text = "1"

	if food_amount.to_int() > ((GameSettings.game_settings["map_size"].x * GameSettings.game_settings["map_size"].y) - GameSettings.game_settings["initial_size"]):
		FoodAmountInput.text = str((GameSettings.game_settings["map_size"].x * GameSettings.game_settings["map_size"].y) - GameSettings.game_settings["initial_size"])

	GameSettings.set_food_amount(FoodAmountInput.text.to_int())
	game_settings_updated.emit()


func _on_food_amount_input_text_submitted(new_text: String) -> void:
	_set_food_amount(new_text)
	

func _on_food_amount_input_focus_exited() -> void:
	_set_food_amount(FoodAmountInput.text)
