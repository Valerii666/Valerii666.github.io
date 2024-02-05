extends PhysicsBody3D
var target:Vector3
var  velocty:Vector3
var speed = 0.5
var kill=null
var template_explosion = preload("res://example/scenes/Explosion/Explosion.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if kill!=null:
		target = kill.global_position
		velocty=(target-self.global_position).normalized()
		look_at(target)
		self.move_and_collide(velocty*speed)




func _on_area_3d_body_entered(body):
	if body is Aircraft:
		kill=body
		


func _on_area_3d_body_exited(body):
	if body is Aircraft:
		kill=null
		var new_explosion = template_explosion.instantiate()
		add_child(new_explosion)
		new_explosion.global_transform.origin = self.global_transform.origin
		new_explosion.explode()
		await get_tree().create_timer(1.0).timeout
		self.queue_free()


func _on_area_3d_2_body_entered(body):
	if body is Aircraft:
		body.crash(0.0)
		
