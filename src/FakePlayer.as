package
{
	import org.flixel.*;
	
	public class FakePlayer extends FlxSprite
	{
		[Embed(source = "img/Necromancer.png")] private var playerGraphic:Class;

		public function FakePlayer(X:int, Y:int)
		{
			super(X, Y);
			loadGraphic(playerGraphic);

			
		}

		
	}
}