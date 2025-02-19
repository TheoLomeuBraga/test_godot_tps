extends Control

func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		TranslationServer.set_locale("en")
	elif index == 1:
		TranslationServer.set_locale("pt-BR")
