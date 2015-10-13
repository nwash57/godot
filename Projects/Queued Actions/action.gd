extends Node2D

var action_type
var action_complete = false

func _ready():
	pass

func create_action_parameters(type, par1):
	return [type, par1]

func do_action(action):
	action_type = action[0]
	if (action_type == "ACTION.MOVE"):
		get_node("action_move").start_move(action[1])

func get_action_complete():
	return action_complete
	
func set_action_complete(bool_var):
	action_complete = bool_var

func cancel_action():
	if (action_type == "ACTION.MOVE"):
		get_node("action_move").end_move()
		
func complete_action():
	get_node("../player").complete_current_action()
	
func set_action_type(type):
	action_type = type

func get_action_types():
	return ACTION_TYPES

const ACTION_TYPES = ["ACTION.MOVE"]

func _on_turn_timer_timeout():
	print(action_type)
	cancel_action()


