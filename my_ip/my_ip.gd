extends Node

func _ready() -> void:
	for ip in IP.get_local_addresses():
		if ip != "127.0.0.1" and ip.split(".").size() == 4:
			
			var is_valid_string : String
			
			if ip.is_valid_ip_address():
				is_valid_string = "valid"
			else:
				is_valid_string = "invalid"
			
			print("your ip address: %s is %s" % [ip,is_valid_string])
