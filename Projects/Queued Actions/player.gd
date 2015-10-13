#asdfasdfas;ljka;jha;jg
extends Node2D

var points = []
var action_queue = []
var _action

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
#	if (moving):
#		move(delta, target_pos)
#	if (abs(get_global_pos().x - target_pos.x) < 5 && abs(get_global_pos().y - target_pos.y) < 5):
#		moving = false
	
	if (action_queue.size() >= 2):
		for i in range(1,action_queue.size()-1):
			if (action_queue[i-1] == action_queue[i]):
				action_queue.remove(i)
	if (!action_queue.empty()):
		get_node("action").do_action(action_queue[0])
	if (get_node("action").get_action_complete()):
		action_queue.remove(0)
		get_node("action").set_action_complete(false)
#	print(action_queue.size())
	
func add_action_to_queue(action_location):
	action_queue.insert(action_queue.size(), get_node("action").create_action_parameters(get_node("action").get_action_types()[0], action_location))
#	for i in range(0, action_queue.size()):
#		print(action_queue.size())

func clear_queue():
	get_node("action").cancel_action()
	action_queue.clear()

func _draw():
	if points.size() > 1:
		for p in points:
			draw_circle(p - get_global_pos(), 8, Color(1, 0, 0))

#		moving = true
#		target_pos = ev.pos

func complete_current_action():
	if (!action_queue.empty()):
		action_queue.remove(0)

#func move(delta, target_pos):
#	points = get_node("../Navigation2D").get_simple_path(get_global_pos(), target_pos, false)
#	if points.size() > 1:
#		var impulse = (points[1] - get_global_pos()).normalized()
#		apply_impulse(Vector2(), impulse * 5000 * delta)
#		update()
