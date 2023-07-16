extends Sprite2D

@export var damage:int
@export var lifetime:float
@export var speed:int
@export var spread:int
@export var cooldown:float
@export var bullet_scene:PackedScene

func fire():
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = get_parent().get_node("BulletPosition").global_position
	bullet.direction = global_transform.basis_xform(Vector2.RIGHT)
	bullet.rotation = bullet.direction.angle()
	bullet.Lifetime.start()
