class_name Password

var display_name: String = ""
var username: String = ""
var password: String = ""


func _init(initial_display_name: String, initial_username: String, initial_password: String) -> void:
	display_name = initial_display_name
	username = initial_username
	password = initial_password
