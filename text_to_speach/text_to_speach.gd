extends Node

var voices = DisplayServer.tts_get_voices_for_language("pt")
var voice_id = voices[0]

func _ready() -> void:
	
	DisplayServer.tts_speak("o que é que voce pensa que esta fazendo ?", voice_id)
	DisplayServer.tts_speak("hakear o kernel não vai ajudar a resolver esse problema", voice_id)
	DisplayServer.tts_speak("voce esta se vazendo de idiota ou ibecil ?", voice_id)
