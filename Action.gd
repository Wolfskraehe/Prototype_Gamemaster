extends Control

var instant:bool
var action_name:String

func dummy_action():
	print("dummy_action: ",action_name, " executed")

func print_event_text():
	return action_name + " was executed \n"
