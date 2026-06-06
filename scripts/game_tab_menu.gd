extends ScrollContainer


@onready var DifficultyOption: Control = %DifficultyOption
@onready var MapSizeOption: Control = %MapSizeOption
@onready var GameVelOption: Control = %GameVelOption
@onready var FoodAmountOption: Control = %FoodAmountOption
@onready var InitialSizeOption: Control = %InitialSizeOption
@onready var PassableWallsOption: Control = %PassableWallsOption


func _ready() -> void:
	DifficultyOption.game_settings_updated.connect(_on_game_settings_updated)
	MapSizeOption.game_settings_updated.connect(_on_game_settings_updated)
	GameVelOption.game_settings_updated.connect(_on_game_settings_updated)
	FoodAmountOption.game_settings_updated.connect(_on_game_settings_updated)
	InitialSizeOption.game_settings_updated.connect(_on_game_settings_updated)
	PassableWallsOption.game_settings_updated.connect(_on_game_settings_updated)


func _on_play_menu_draw() -> void:
	update_options()


func _on_game_settings_updated() -> void:
	update_options()


func update_options() -> void:
	if GameSettings.game_settings == GameSettings.very_easy_diff:
		DifficultyOption.VeryEasyDiff.button_pressed = true
		MapSizeOption.WidthInput.text = str(GameSettings.very_easy_diff["map_size"].x)
		MapSizeOption.HeightInput.text = str(GameSettings.very_easy_diff["map_size"].y)
		GameVelOption.VerySlowVel.button_pressed = true
		GameVelOption.GameVelInput.text = str(GameSettings.game_vels["very_slow"])
		FoodAmountOption.FoodAmountInput.text = str(GameSettings.very_easy_diff["food_amount"])
		InitialSizeOption.InitialSizeInput.text = str(GameSettings.very_easy_diff["initial_size"])
		PassableWallsOption.PWYes.button_pressed = true

	elif GameSettings.game_settings == GameSettings.easy_diff:
		DifficultyOption.EasyDiff.button_pressed = true
		MapSizeOption.WidthInput.text = str(GameSettings.easy_diff["map_size"].x)
		MapSizeOption.HeightInput.text = str(GameSettings.easy_diff["map_size"].y)
		GameVelOption.SlowVel.button_pressed = true
		GameVelOption.GameVelInput.text = str(GameSettings.game_vels["slow"])
		FoodAmountOption.FoodAmountInput.text = str(GameSettings.easy_diff["food_amount"])
		InitialSizeOption.InitialSizeInput.text = str(GameSettings.easy_diff["initial_size"])
		PassableWallsOption.PWYes.button_pressed = true

	elif GameSettings.game_settings == GameSettings.normal_diff:
		DifficultyOption.NormalDiff.button_pressed = true
		MapSizeOption.WidthInput.text = str(GameSettings.normal_diff["map_size"].x)
		MapSizeOption.HeightInput.text = str(GameSettings.normal_diff["map_size"].y)
		GameVelOption.NormalVel.button_pressed = true
		GameVelOption.GameVelInput.text = str(GameSettings.game_vels["normal"])
		FoodAmountOption.FoodAmountInput.text = str(GameSettings.normal_diff["food_amount"])
		InitialSizeOption.InitialSizeInput.text = str(GameSettings.normal_diff["initial_size"])
		PassableWallsOption.PWNo.button_pressed = true

	elif GameSettings.game_settings == GameSettings.hard_diff:
		DifficultyOption.HardDiff.button_pressed = true
		MapSizeOption.WidthInput.text = str(GameSettings.hard_diff["map_size"].x)
		MapSizeOption.HeightInput.text = str(GameSettings.hard_diff["map_size"].y)
		GameVelOption.FastVel.button_pressed = true
		GameVelOption.GameVelInput.text = str(GameSettings.game_vels["fast"])
		FoodAmountOption.FoodAmountInput.text = str(GameSettings.hard_diff["food_amount"])
		InitialSizeOption.InitialSizeInput.text = str(GameSettings.hard_diff["initial_size"])
		PassableWallsOption.PWNo.button_pressed = true


	elif GameSettings.game_settings == GameSettings.very_hard_diff:
		DifficultyOption.VeryHardDiff.button_pressed = true
		MapSizeOption.WidthInput.text = str(GameSettings.very_hard_diff["map_size"].x)
		MapSizeOption.HeightInput.text = str(GameSettings.very_hard_diff["map_size"].y)
		GameVelOption.VeryFastVel.button_pressed = true
		GameVelOption.GameVelInput.text = str(GameSettings.game_vels["very_fast"])
		FoodAmountOption.FoodAmountInput.text = str(GameSettings.very_hard_diff["food_amount"])
		InitialSizeOption.InitialSizeInput.text = str(GameSettings.very_hard_diff["initial_size"])
		PassableWallsOption.PWNo.button_pressed = true

	else:
		if DifficultyOption.DifficultyButtonGroup.get_pressed_button() != null:
			DifficultyOption.DifficultyButtonGroup.get_pressed_button().button_pressed = false
	
		MapSizeOption.WidthInput.text = str(GameSettings.game_settings["map_size"].x)
		MapSizeOption.HeightInput.text = str(GameSettings.game_settings["map_size"].y)

		if GameSettings.game_settings["game_vel"] == GameSettings.game_vels["very_slow"]:
			GameVelOption.VerySlowVel.button_pressed = true
			GameVelOption.GameVelInput.text = str(GameSettings.game_vels["very_slow"])

		elif GameSettings.game_settings["game_vel"] == GameSettings.game_vels["slow"]:
			GameVelOption.SlowVel.button_pressed = true
			GameVelOption.GameVelInput.text = str(GameSettings.game_vels["slow"])

		elif GameSettings.game_settings["game_vel"] == GameSettings.game_vels["normal"]:
			GameVelOption.NormalVel.button_pressed = true
			GameVelOption.GameVelInput.text = str(GameSettings.game_vels["normal"])

		elif GameSettings.game_settings["game_vel"] == GameSettings.game_vels["fast"]:
			GameVelOption.FastVel.button_pressed = true
			GameVelOption.GameVelInput.text = str(GameSettings.game_vels["fast"])

		elif GameSettings.game_settings["game_vel"] == GameSettings.game_vels["very_fast"]:
			GameVelOption.VeryFastVel.button_pressed = true
			GameVelOption.GameVelInput.text = str(GameSettings.game_vels["very_fast"])

		else:
			if GameVelOption.GameVelButtonGroup.get_pressed_button() != null:
				GameVelOption.GameVelButtonGroup.get_pressed_button().button_pressed = false
			GameVelOption.GameVelInput.text = str(GameSettings.game_settings["game_vel"])


		FoodAmountOption.FoodAmountInput.text = str(GameSettings.game_settings["food_amount"])
		InitialSizeOption.InitialSizeInput.text = str(GameSettings.game_settings["initial_size"])

		if GameSettings.game_settings["passable_walls"] == true:
			PassableWallsOption.PWYes.button_pressed = true
		else:
			PassableWallsOption.PWNo.button_pressed = true
