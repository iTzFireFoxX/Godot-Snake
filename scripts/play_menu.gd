extends Control


# Tab Buttons
@onready var GameTab: Button = %GameTab
@onready var AppearanceTab: Button = %AppearanceTab


# Tab Scroll Containers
@onready var GameTabScroll: ScrollContainer = %GameTabScroll
@onready var AppearanceTabScroll: ScrollContainer = %AppearanceTabScroll


func _on_draw() -> void:
	GameTab.pressed.emit()
	GameTab.button_pressed = true


func _on_game_tab_pressed() -> void:
	AppearanceTabScroll.hide()
	GameTabScroll.show()


func _on_appearance_tab_pressed() -> void:
	GameTabScroll.hide()
	AppearanceTabScroll.show()
	

func _on_back_pressed() -> void:
	self.hide()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Game.tscn")
