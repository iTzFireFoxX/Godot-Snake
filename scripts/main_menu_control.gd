extends Control


@onready var Version: Label = %Version
@onready var PlayMenuControl: Control = %PlayMenuControl
@onready var OptionsMenuControl: Control = %OptionsMenuControl


func _ready() -> void:
	Version.text = "v" + str(ProjectSettings.get("application/config/version")) # Obtener la versión actual del proyecto


func _on_play_menu_pressed() -> void:
	self.hide()
	Version.hide()
	PlayMenuControl.show()


func _on_options_menu_pressed() -> void:
	self.hide()
	Version.hide()
	OptionsMenuControl.show()


func _on_back_pressed() -> void:
	self.show()
	Version.show()
