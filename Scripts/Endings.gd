class_name Endings
extends Node2D

var flagHitHare : bool
var flagHitCiv : bool
var flagHitBottle : bool
var flagHitMoon : bool
var flagGunFired : bool

@export var sprite : Sprite2D
@export var title : RichTextLabel
@export var comment : RichTextLabel

@export var hare : Target
@export var nearMissThreshold : float = 300

func resetEndingFlags():
	flagHitCiv=false
	flagHitHare=false
	flagHitBottle=false
	flagHitMoon=false
	flagGunFired=false
func loadEndingVisuals():
	visible=true
	if not flagGunFired:
		_endingExpired()
		return
	
	if flagHitCiv:
		_endingCiv()
		return
	if flagHitHare:
		_endingHare()
		return
	if flagHitBottle:
		_endingBottle()
		return
	if flagHitMoon:
		_endingMoon()
		return

	if global_position.distance_to(hare.global_position)<=nearMissThreshold:
		_endingNearMiss()
	else:
		_endingMiss()


@export var _civTex : Array[Texture2D]
func _endingCiv():
	_displayEnding(_civTex.pick_random(),"CIVILIAN SHOT", "WHY WOULD YOU DO THAT?")

@export var _hareTex : Array[Texture2D]
func _endingHare():
	_displayEnding(_hareTex.pick_random(), "YOU WIN!?", "GOOD JOB")


@export var _nearMissTex : Texture2D
func _endingNearMiss():
	_displayEnding(_nearMissTex, "NEAR MISS", "SO CLOSE...")

@export var _missTex : Texture2D
func _endingMiss():
	_displayEnding(_missTex, "MISS", "WHAT DO WE EVEN PAY YOU FOR?")

@export var _bottleTex : Texture2D
func _endingBottle():
	_displayEnding(_bottleTex, "BOTTLE", "VERY IMPRESSIVE, CAN YOU SHOOT HARE NOW?")

@export var _moonTex : Texture2D
func _endingMoon():
	_displayEnding(_moonTex, "SHOOT FOR THE MOON", "???")

@export var _expiredTex : Texture2D
func _endingExpired():
	_displayEnding(_expiredTex, "TOO LATE!", "HOW DID YOU NOT SEE HIM? HE WAS RIGHT THERE!")

func _displayEnding(_tex : Texture2D, _title : String, _comment : String):
	sprite.texture=_tex
	title.text="[center]"+_title
	comment.text=_comment
