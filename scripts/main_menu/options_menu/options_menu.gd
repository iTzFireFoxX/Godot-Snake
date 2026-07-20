extends Control


@onready var VideoTab: Button = %VideoTab
@onready var AudioTab: Button = %AudioTab


@onready var VideoTabMenu: ScrollContainer = %VideoTabMenu
@onready var AudioTabMenu: ScrollContainer = %AudioTabMenu


func _on_draw() -> void:
	VideoTab.pressed.emit()
	VideoTab.button_pressed = true


func _on_video_tab_pressed() -> void:
	AudioTabMenu.hide()
	VideoTabMenu.show()


func _on_audio_tab_pressed() -> void:
	VideoTabMenu.hide()
	AudioTabMenu.show()


func _on_back_pressed() -> void:
	self.hide()