extends RichTextLabel

onready var init_text = bbcode_text

func _ready():
	bbcode_text = tr(init_text)
	connect('meta_clicked', self, '_on_meta_clicked')


func _on_meta_clicked(value):
	OS.shell_open(value)


func _on_AboutL_transition_started():
	bbcode_text = tr(init_text)
