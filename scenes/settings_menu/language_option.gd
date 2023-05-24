extends Node

onready var target = get_parent() # OptionButton
var option_locales: PoolStringArray

func _ready():
	target.add_separator()
	_load_locales_as_options()
	target.add_separator()
	
	target.connect("item_selected", self, "_on_language_selected")


func _load_locales_as_options() -> void:
	var locales = TranslationServer.get_loaded_locales()
	
	for locale in locales:
		target.add_item(TranslationServer.get_locale_name(locale))
		option_locales.append(locale)


func _on_language_selected(id):
	if id == -1:
		return
	
	var locale = option_locales[id - 1]
	TranslationServer.set_locale(locale)
	print(TranslationServer.get_locale())
