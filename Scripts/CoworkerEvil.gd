extends Coworker

@export var minStareDuration : float
@export var maxStareDuration : float
var stareDuration : float
var _player : Player
var stareRemaining : float
var hasStared : bool

func despawn():
	_coworkerSpawner.evilAvailable=true
	super.despawn()

func setup(coworkerSpawner, xPos, player):
	super.setup(coworkerSpawner,xPos,player)
	_coworkerSpawner.evilAvailable=false
	_player=player
	hasStared=false
	
func _physics_process(delta):
	#start stare
	if not hasStared:
		if walkDir > 0 and position.x > _coworkerSpawner.starePoint or walkDir < 0 and position.x < _coworkerSpawner.starePoint:
			stareRemaining=lerp(minStareDuration,maxStareDuration,randf())
			print("STARE")
			hasStared=true
	if stareRemaining > 0:
		_player.caughtCheck()
		stareRemaining-=delta
		if stareRemaining <= 0: # end stare
			pass
		return


	super._physics_process(delta)
