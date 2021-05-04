extends Control


var house_list=[]
var action_queue=[]
var turn_count:int
var event_log:String

#preloading main classes
var house=preload("res://House.tscn")
var character=preload("res://Character.tscn")
var action=preload("res://Action.tscn")

#initializing houses and leaders
func _init():
	var house_player=house.instance()
	var house_ai=house.instance()
	var player_leader=character.instance()
	var ai_leader=character.instance()

	
	player_leader.character_name="Drizzt"
	player_leader.character_race="Drow"
	ai_leader.character_name="Viconia"
	ai_leader.character_race="Drow"
	
	house_player.player=true
	house_player.house_name="DoUrden"
	house_player.house_leader=player_leader
	house_player.trade_power=1
	house_ai.player=false
	house_ai.house_name="Sisters"
	house_ai.house_leader=ai_leader
	
	house_list.append_array([house_player,house_ai])
	
#setting the text lables	
func _ready():
	turn_count=1
	get_node("TurnCounter").set_text("Turn: "+str(turn_count))
	get_node("InfoText").set_text("The game begins")
	for house in house_list:
		if house.player==true:
			get_node("HouseTradePower").set_text("Trade Power: "+str(house.trade_power))
	

#example for an instant action
func _on_InstantAction_pressed():
	var instant_action=action.instance()
	instant_action.instant=true
	instant_action.action_name="Instant Action"
	event_log+=instant_action.print_event_text()
	get_node("InfoText").set_text(event_log)


#queue for all actions that are resolved at the end of the turn
func _on_LongTermAction_pressed():
	var long_term_action=action.instance()
	long_term_action.instant=false
	long_term_action.action_name="Long Term Action"
	action_queue.append(long_term_action)

#function for resolving the turn
func _on_EndTurn_pressed():
	
	#resolving ai actions
	for house in house_list:
		#dummy long term action for ai, should be in house class later
		var ai_long_term_action=action.instance()
		ai_long_term_action.instant=false
		ai_long_term_action.action_name="AI Long Term Action"
		
		if house.player==false:
			event_log+=house.ai_house_event_text()
			action_queue.append(ai_long_term_action)
			get_node("InfoText").set_text(event_log)
			
	#resolving all queued actions
	if action_queue.empty():
		event_log+="Nothing else happend in this turn \n"
		get_node("InfoText").set_text(event_log)
	for item in action_queue:
		item.dummy_action()
		event_log+=item.print_event_text()
		get_node("InfoText").set_text(event_log)
	action_queue.clear()
	turn_count+=1
	get_node("TurnCounter").set_text("Turn: "+str(turn_count))
	
