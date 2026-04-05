extends Control


# Main Menu Items
@onready var MainMenuARContainer: AspectRatioContainer = %MainMenuARContainer
@onready var Version: Label = %Version


# Sub Menus Controls
@onready var PlayMenu: Control = %PlayMenu
@onready var OptionsMenu: Control = %OptionsMenu


func _ready() -> void:
	Version.text = "v" + str(ProjectSettings.get("application/config/version")) # Obtener la versión actual del proyecto


func _on_play_menu_pressed() -> void:
	MainMenuARContainer.hide()
	Version.hide()
	PlayMenu.show()


func _on_options_menu_pressed() -> void:
	MainMenuARContainer.hide()
	Version.hide()
	OptionsMenu.show()


func _on_sub_menu_hidden() -> void:
	MainMenuARContainer.show()
	Version.show()


func _on_exit_pressed() -> void:
	get_tree().quit()
