class_name ShotGunGeneric extends WeaponBase

@onready var timer: Timer = $Timer
var bullet: PackedScene = preload("res://Scenes/Weapons/bullet.tscn")

@export_category("Atributes")
@export_group("Bullets") #TODO maybe hacer otra clase para solo armas con balas y timer
@export var max_bullets: int = 0 # 0 -> infinito
@export var cooldown_reload: float = 0 # 0 -> No reload
@export var amount_bullets_on_reload:int = 1
@export var available_bullets: int

@export_group("Shot")
@export var shot_cooldown: float = 0.25
@export var damage: int
var can_shot:bool = true
# Called when the node enters the scene tree for the first time.
#region events
func start() -> void:
	print(1)
	timer.timeout.connect(reload_bullets)
	if available_bullets < max_bullets:
		timer.start(cooldown_reload)
		
func on_process(_delta) -> void:
	#region look at mouse
	var global_position_mouse: Vector2 = get_global_mouse_position()
	var direccion: Vector2 = global_position_mouse - global_position
	var angle = atan2(direccion.y,direccion.x)
	global_rotation = angle 
	#endregion
	if Input.is_action_pressed("shot"):
		shot()

#endregion
#region Useful methods
func reload_bullets() -> void:
	available_bullets = min(available_bullets+amount_bullets_on_reload, max_bullets)
	prints(self.name,"Reload, available bullets", available_bullets)
	if available_bullets < max_bullets:
		timer.start(cooldown_reload)
		
func shot() -> void:
	if can_shot and available_bullets > 0:
		can_shot = false
		anims.play("shot")
		var new_bullet: Bullet = bullet.instantiate()
		get_tree().current_scene.add_child(new_bullet)
		new_bullet.global_position = global_position
		new_bullet.start(get_global_mouse_position(), controlled_node, damage)
		
		available_bullets -= 1
		prints("Shot, Avaiable ", available_bullets, "Timer", timer.time_left)
		if timer.is_stopped():
			timer.start(cooldown_reload)
		await get_tree().create_timer(shot_cooldown).timeout
		can_shot = true

#endregion
