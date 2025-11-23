class_name Game
extends Node2D

enum GameState{Start,ZoomUp,Game,Expired,GunFlash,Ended,Restart}
var gameState : GameState
@export var endings : Endings
@export var camera : Camera2D

@export var startPosition : Vector2
@export var colors : Array[Color]
@export var colorRect : ColorRect

@export var gameCrosshairSpeed : float = 100

@export var zoomUpPosition : Vector2
@export var zoomUpCurve : Curve
@export var zoomUpDuration : float

@export var gunFlashColor : Color
@export var gunFlashCurve : Curve
@export var gunFlashDuration : float

@export var expiredColor : Color
@export var expiredCurve : Curve
@export var expiredDuration : float

@export var restartColor : Color
@export var restartCurve : Curve
@export var restartDuration : float

var moveAxis : Vector2
func _enter_tree():
	position=startPosition

func _ready():
	endings.visible=false
	endings.resetEndingFlags()

func _process(delta):

	moveAxis=Vector2.ZERO
	if Input.is_action_pressed("MoveUp"):
		moveAxis+=Vector2.UP
	if Input.is_action_pressed("MoveRight"):
		moveAxis+=Vector2.RIGHT
	if Input.is_action_pressed("MoveDown"):
		moveAxis+=Vector2.DOWN
	if Input.is_action_pressed("MoveLeft"):
		moveAxis+=Vector2.LEFT
	moveAxis=moveAxis.normalized()


	print("Game State : " + str(gameState))
	match gameState:
		GameState.Start:
			if Input.is_action_just_pressed("Shoot"):
				_newState(GameState.ZoomUp)
		GameState.ZoomUp:
			position = startPosition.lerp(zoomUpPosition, zoomUpCurve.sample(MathS.Clamp01(_t/zoomUpDuration)))
			if _t>=zoomUpDuration:
				_newState(GameState.Game)
		GameState.Game:
			if Input.is_action_just_pressed("Shoot"):
				shoot()
			if _t>=20:
				_newState(GameState.Expired)
				colorRect.color=expiredColor
				colorRect.color.a=0
		GameState.GunFlash:
			colorRect.color.a = gunFlashCurve.sample(MathS.Clamp01(_t/gunFlashDuration))
			if _t>=gunFlashDuration:
				_newState(GameState.Ended)
		GameState.Expired:
			var aOld = colorRect.color.a
			colorRect.color.a = expiredCurve.sample(MathS.Clamp01(_t/expiredDuration))
			if aOld!=1 and colorRect.color.a==1:
				endings.loadEndingVisuals()
	
			if _t>=expiredDuration:
				_newState(GameState.Ended)
		GameState.Ended:
			if Input.is_action_just_pressed("Shoot"):
				_newState(GameState.Restart)
				colorRect.color=restartColor
				colorRect.color.a=0
				endings.resetEndingFlags()
		GameState.Restart:
			var aOld = colorRect.color.a
			colorRect.color.a = restartCurve.sample(MathS.Clamp01(_t/restartDuration))
			if aOld!=1 and colorRect.color.a==1:
				position=startPosition
				endings.visible=false
			if _t>=restartDuration:
				_newState(GameState.Start)
	_t+=delta
func _physics_process(delta):
	match gameState:
		GameState.Start:
			pass
		GameState.ZoomUp:
			pass
		GameState.Game:
			position+=moveAxis*delta*gameCrosshairSpeed
		GameState.GunFlash:
			pass
		GameState.Expired:
			pass
		GameState.Ended:
			pass
		GameState.Restart:
			pass
	_tPhys+=delta
var _t : float = 0
var _tPhys : float = 0

func _newState(newState : GameState):
	gameState=newState
	_t=0
	_tPhys=0


func shoot():
	endings.flagGunFired=true

	var spaceState = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position=camera.global_position
	query.collide_with_areas=true
	query.collide_with_bodies=false
	query.collision_mask=1
	var result : Array[Dictionary] = spaceState.intersect_point(query,32)
	for d in result:
		print("HIT")
		d["collider"].hit(endings)


	_newState(GameState.GunFlash)
	colorRect.color=gunFlashColor
	colorRect.color.a=1
	endings.loadEndingVisuals()
