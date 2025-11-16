class_name CoworkerSpawner
extends Node2D

@export var player : Player
@export var coworkerPacked : PackedScene
@export var evilCoworkerPacked : PackedScene
@export var minSpawnDelay : float
@export var maxSpawnDelay : float
var spawnDelay : float
@export var starePoint : float
@export var despawnThreshold : float = 900

var evilAvailable : bool

func _enter_tree():
	pass

func _ready():
	evilAvailable=true
	spawnCoworker()
	spawnCoworker()
	spawnCoworker()
	spawnCoworker()
	

func _physics_process(delta: float):
	spawnDelay-=delta
	if spawnDelay <=0:
		spawnCoworker()

func spawnCoworker():
	spawnDelay=lerp(minSpawnDelay,maxSpawnDelay,randf())
	var coworker : Coworker
	var xPos : float = 900 + randf()*200
	
	if randf()>0.5:
		xPos*=-1

	if evilAvailable:
		coworker=evilCoworkerPacked.instantiate()
	else:
		coworker=coworkerPacked.instantiate()
	coworker.setup(self,xPos,player)
	add_child(coworker)
