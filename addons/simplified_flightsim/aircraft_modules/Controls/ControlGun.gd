extends AircraftModule
class_name AircraftModule_ControlGun
# Called when the node enters the scene tree for the first time.
var gun_modules = []
@export var RestrictGunToTag: bool = false
@export var SearchTag: String = ""
@export var KeyShoot: KeyScancodes = KeyScancodes.KEY_X



func _ready():
	pass # Replace with function body.
	
	
func setup(aircraft_node):
	aircraft = aircraft_node
	if RestrictGunToTag:
		gun_modules = aircraft.find_modules_by_type_and_tag("gun", SearchTag)
	else:
		gun_modules = aircraft.find_modules_by_type("gun")
	print("gun found: %s" % str(gun_modules))

func receive_input(event):
	if (event is InputEventKey) and (not event.echo):
		if event.pressed:
			match event.keycode:
				KeyShoot:
					send_to_guns("engine_start")
				
				
func send_to_guns(method_name: String, arguments: Array = []):
	for gun in gun_modules:
		gun.callv(method_name, arguments)
