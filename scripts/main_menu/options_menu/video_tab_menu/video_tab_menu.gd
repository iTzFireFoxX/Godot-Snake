extends ScrollContainer


@onready var FullScreenOption = %FullScreenOption


func _on_options_menu_draw() -> void:
    if DisplayServer.window_get_mode() != 3:
        FullScreenOption.FSNo.button_pressed = true
    else:
        FullScreenOption.FSYes.button_pressed = true
