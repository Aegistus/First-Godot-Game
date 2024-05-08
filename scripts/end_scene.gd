extends CanvasLayer

func _on_restart_pressed():
	GameManager.reset_scene()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
