extends CharacterBody2D

@onready var WeaponSlot := $WeaponSlot
@onready var Cooldown := $WeaponSlot/Cooldown
@onready var ShootSFX := $SFX/Shoot

const SPEED = 100.0

var weapons = []
var current_weapon

func _ready():
	for i in WeaponSlot.get_children():
		if i.has_method("fire"):
			weapons.append(i)
			select_weapon(weapons[0])

func select_weapon(weapon:Sprite2D):
	current_weapon = weapon
	Cooldown.wait_time = current_weapon.cooldown
	current_weapon.show()
	for i in WeaponSlot.get_children():
		if i != current_weapon && i.has_method("fire"):
			i.hide()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		select_weapon(weapons.pick_random())

func _process(delta):
	if Input.is_action_pressed("fire") && Cooldown.is_stopped():
		current_weapon.fire()
		Cooldown.start()
		ShootSFX.play()
	WeaponSlot.rotation = get_angle_to(get_global_mouse_position())
	if WeaponSlot.global_position.x < get_global_mouse_position().x:
		WeaponSlot.scale.y = 1
	elif WeaponSlot.global_position.x > get_global_mouse_position().x:
		WeaponSlot.scale.y = -1

func _physics_process(delta):
	var direction = Input.get_vector("left","right","up","down")
	if direction:
		velocity = velocity.move_toward(direction * SPEED,SPEED/10)
		$Sprite.play("move")
		if direction.x:
			$Sprite.flip_h = sign(direction.x) == -1
	else:
		velocity = velocity.move_toward(Vector2.ZERO,SPEED/2)
		$Sprite.play("idle")
	move_and_slide()
