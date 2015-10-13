extends Node2D

var ispaused = false

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	get_tree().set_pause(true)
	ispaused = true 
	print("PAUSED")
	

func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON and event.is_pressed()):
		get_node("../player").add_action_to_queue(event.pos)
		
	if (event.is_action("pause") and event.is_pressed()):
		if (ispaused == false):
			get_node("../paused_sign").set_opacity(1)
			get_tree().set_pause(true)
			ispaused = true
			print("END TURN")
		elif (ispaused == true):
			get_node("../paused_sign").set_opacity(0)
			get_tree().set_pause(false)
			ispaused = false
			get_node("../turn_timer").start_turn_timer()
			print("START TURN")

func end_of_turn_pause():
	if (ispaused == false):
			get_node("../paused_sign").set_opacity(1)
			get_tree().set_pause(true)
			ispaused = true
			print("END TURN")
	

func _on_turn_timer_timeout():
	print("TIME UP")
	get_node("../player").clear_queue()
	end_of_turn_pause()
	
	