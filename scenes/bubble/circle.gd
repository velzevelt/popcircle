tool
extends Node2D

signal tasks_completed
signal tasks_failed

onready var collision_shape = $Area2D/CollisionShape2D as CollisionShape2D
onready var area2d = $Area2D as Area2D
onready var life_timer = $LifeTimer as Timer
onready var click_sfx = $ClickSfx as AudioStreamPlayer


export var draw_outline := true
export var albedo: Color = Color.yellow
export var outline_color: Color = Color.black
export var fade_out_color: Color = Color.yellowgreen
export var init_radius := 100
export var init_outline_thickness := 10

export var fade_in_duration := 0.8
export var fade_out_duration := 0.1
export var is_static := false

var outline_thickness := init_outline_thickness
var radius := init_radius

var _mouse_entered := false
var _handled := false

func _draw():
	if draw_outline:
		draw_circle(position, radius + outline_thickness, outline_color)
	
	draw_circle(position, radius, albedo)
	
	

func _input(event):
	if Engine.is_editor_hint() or is_static:
		return
	
	if event is InputEventScreenTouch:
		if event.pressed and _mouse_entered and not _handled:
			_handle_click()
	elif Input.is_action_just_pressed("click") and _mouse_entered and not _handled:
		_handle_click()


func _handle_click():
	click_sfx.play()
	_handled = true
	_fade_out()


func _process(_delta):
	update()
	
	if not Engine.is_editor_hint():
		collision_shape.shape.radius = radius
		area2d.position = position
	
	

func _ready():
	if not Engine.is_editor_hint():
		radius = 0
		outline_thickness = 0
		_fade_in()
	


func start_life_timer():
	_wait_to_out(life_timer.wait_time)
	life_timer.start()
	

func _wait_to_out(wait_time):
	var tween = create_tween()
	tween.tween_property(self, 'albedo', fade_out_color, wait_time)


func _fade_out(duration=fade_out_duration, transparency = true):
	var tween = create_tween()
	tween.connect("finished", self, '_on_tasks_completed')
	
	tween.set_parallel()
	tween.tween_property(self, 'radius', 0, duration)
	tween.tween_property(self, 'outline_thickness', 0, duration)
	if transparency:
		var new_albedo = albedo
		new_albedo.a = 0
		var new_outline_color = outline_color
		new_outline_color.a = 0
		
		tween.tween_property(self, 'albedo', new_albedo, duration)
		tween.tween_property(self, 'outline_color', new_outline_color, duration)
	


func _fade_in(duration=fade_in_duration):
	var tween = create_tween()
	tween.connect("finished", self, 'start_life_timer')
	tween.set_parallel()
	tween.tween_property(self, 'radius', init_radius, duration)
	tween.tween_property(self, 'outline_thickness', init_outline_thickness, duration)
	


func _on_tasks_completed():
	if _handled:
		emit_signal('tasks_completed')
	else:
		emit_signal('tasks_failed')
	
	_safe_destroy()
	
#	if not click_sfx.playing:
#		_safe_destroy()
#	else:
#		yield(click_sfx, "finished")
#		_safe_destroy()


func _safe_destroy():
	call_deferred('free')


func _on_Area2D_mouse_entered():
	_mouse_entered = true


func _on_Area2D_mouse_exited():
	_mouse_entered = false


func _on_LifeTimer_timeout():
	_fade_out()
