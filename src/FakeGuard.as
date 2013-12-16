package
{
	import org.flixel.*;
	
	public class FakeGuard extends FlxSprite
	{
		
		[Embed(source = "img/Guard.png")] private var guardGraphic:Class;
		
		public function FakeGuard(X:int, Y:int)
		{
			super(X, Y);
			loadGraphic(guardGraphic);

		}
		

		

	}
}