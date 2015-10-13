
extends Node2D

var points = []
var action_queue = []
var _action

func _ready():
	set_fixed_process(true)
	set_process_input(true)

func _fixed_process(delta):
#	if (moving):
#		move(delta, target_pos)
#	if (abs(get_global_pos().x - target_pos.x) < 5 && abs(get_global_pos().y - target_pos.y) < 5):
#		moving = false
	if (!action_queue.empty()):
		get_node("action").do_action(action_queue[0])
	if (get_node("action").get_action_complete()):
		action_queue.remove(0)
		get_node("action").set_action_complete(false)

#func _draw():
#	if points.size() > 1:
#		for p in points:
#			draw_circle(p - get_global_pos(), 8, Color(1, 0, 0))

func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON and event.is_pressed()):
		action_queue.insert(action_queue.size(), get_node("action").create_action_parameters(get_node("action").get_action_types()[0], event.pos))
		for i in range(0, action_queue.size()):
			print(action_queue[i])
		
#		moving = true
#		target_pos = ev.pos

func complete_current_action():
	action_queue.remove(0)

#func move(delta, target_pos):
#	points = get_node("../Navigation2D").get_simple_path(get_global_pos(), target_pos, false)
#	if points.size() > 1:
#		var impulse = (points[1] - get_global_pos()).normalized()
#		apply_impulse(Vector2(), impulse * 5000 * delta)
#		update()
