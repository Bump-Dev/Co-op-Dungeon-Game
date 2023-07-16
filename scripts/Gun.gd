extends Sprite2D

@export var speed:int
@export var spread:float
@export var damage:int
@export var cooldown:float
@export var bullet_lifetime:float
@export var bullet_scene:PackedScene

func fire():
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	
	bullet.global_position = get_parent().get_node("BulletPosition").global_position
	bullet.direction = global_transform.basis_xform(Vector2.RIGHT+Vector2(0,randf_range(-spread,spread)))
	bullet.rotation = bullet.direction.angle()
	
	bullet.speed = speed
	bullet.damage = damage
	bullet.Lifetime.wait_time = bullet_lifetime
	bullet.Lifetime.start()
