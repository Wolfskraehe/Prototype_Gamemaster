extends Control

var player:bool
var house_name:String
var house_leader
var trade_power:float

func ai_house_event_text():
	return "House "+house_name+" finished its turn \n"
