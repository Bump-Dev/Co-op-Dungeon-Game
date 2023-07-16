extends CharacterBody2D

@export var smoke_scene:PackedScene
@export var impact_scene:PackedScene

@onready var Lifetime := $Lifetime

var speed:int
var damage:int

var direction:Vector2

func _physics_process(delta):
	$Sprite2D.scale = lerp($Sprite2D.scale,Vector2(1,1),0.5)
	var collision_result = move_and_collide(direction * speed * delta)
	if collision_result != null:
		var smoke = smoke_scene.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = collision_result.get_position()
		smoke.rotation = collision_result.get_normal().angle()
		
		var impact = impact_scene.instantiate()
		get_parent().add_child(impact)
		impact.global_position = collision_result.get_position()
		impact.rotation = collision_result.get_normal().angle()
		
		if collision_result.get_collider().is_in_group("Enemy"):
			collision_result.get_collider().hurt()
		
		queue_free()

func _on_lifetime_timeout():
	var smoke = smoke_scene.instantiate()
	smoke.global_position = global_position
	smoke.rotation = rotation
	get_parent().add_child(smoke)
	
	var impact = impact_scene.instantiate()
	impact.global_position = global_position
	impact.rotation = rotation
	get_parent().add_child(impact)
	
	queue_free()
