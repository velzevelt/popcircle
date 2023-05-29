extends RichTextLabel


func _ready():
	bbcode_text = tr(bbcode_text)
	connect('meta_clicked', self, '_on_meta_clicked')


func _on_meta_clicked(value):
	OS.shell_open(value)
