extends Node

onready var target = get_parent() # OptionButton

var sizes: Array = [
	CursorSize.new('Small', Vector2(16, 16)),
	CursorSize.new('Medium', Vector2(32, 32)),
	CursorSize.new('Big', Vector2(48, 48)),
	CursorSize.new('Huge', Vector2(64, 64)),
]


class CursorSize:
	var alias: String
	var size: Vector2
	func _init(alias: String, size: Vector2):
		self.alias = alias
		self.size = size


func _ready():
	target.add_separator()
	_add_options()
	target.add_separator()
	
	target.connect("item_selected", self, "_on_option_selected")

func _add_options():
	for size in sizes:
		target.add_item(size.alias)


func _on_option_selected(id):
	if id == -1:
		return
	
	var size = sizes[id - 1]
	Cursor.size = size.size
