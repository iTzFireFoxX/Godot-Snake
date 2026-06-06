extends Control


# Tab Buttons
@onready var GameTab: Button = %GameTab
@onready var AppearanceTab: Button = %AppearanceTab


# Tab Scroll Containers
@onready var GameTabMenu: ScrollContainer = %GameTabMenu
@onready var AppearanceTabMenu: ScrollContainer = %AppearanceTabMenu


func _on_draw() -> void:
	GameTab.pressed.emit()
	GameTab.button_pressed = true


func _on_game_tab_pressed() -> void:
	AppearanceTabMenu.hide()
	GameTabMenu.show()


func _on_appearance_tab_pressed() -> void:
	GameTabMenu.hide()
	AppearanceTabMenu.show()
	

func _on_back_pressed() -> void:
	self.hide()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
