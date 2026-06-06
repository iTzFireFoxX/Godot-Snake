extends Control


signal game_settings_updated()


# FoodAmount Input
@onready var FoodAmountInput: LineEdit = %FoodAmountInput


func set_food_amount(food_amount: String) -> void:
	GameSettings.set_food_amount(food_amount.to_int())
	game_settings_updated.emit()


func _on_food_amount_input_focus_exited() -> void:
	set_food_amount(FoodAmountInput.text)


func _on_food_amount_input_text_submitted(new_text: String) -> void:
	set_food_amount(new_text)
