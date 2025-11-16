extends RichTextLabel

@export var player : Player

func _process(delta: float):
	text=""
	displayEntry("remainingT",MathS.Truncate(player.timeRemaining,2))
	displayEntry("explodeT", MathS.Truncate(player.explodeT,2))
	displayEntry("Inhaling", player.inhaling)
	displayEntry("inhaleT", MathS.Truncate(player.inhaleT,2))
	displayEntry("Stored", MathS.Truncate(player.storedBreath,2))

func displayEntry(name : String, val):
	text+=name + " : " + str(val) +"\n"
