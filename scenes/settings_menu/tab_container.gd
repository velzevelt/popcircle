extends TabContainer

export(NodePath) var settings_group_label

func _ready():
	settings_group_label = get_node_or_null(settings_group_label)

func update_settings_group_label_text() -> void:
	if is_instance_valid(settings_group_label):
		settings_group_label.text = get_current_tab_control().name


func _on_PreviousTab_pressed():
	var prev_tab = current_tab - 1
	if prev_tab < 0:
		prev_tab = 0
	
	current_tab = prev_tab
	update_settings_group_label_text()


func _on_NextTab_pressed():
	var next_tab = current_tab + 1
	if next_tab >= get_tab_count():
		next_tab -= 1
	
	current_tab = next_tab
	update_settings_group_label_text()
