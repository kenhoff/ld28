package 
{
	import org.flixel.*;
	
	public class HealthBar extends FlxSprite
	{
		public function HealthBar(X:int, Y:int)
		{
			super(X, Y);
			makeGraphic(16, 2, 0xff00ff00);
		}
		public function updateHealthBar(percent:Number):void
		{
			var barPixelSize:uint = percent * 16;
			if (barPixelSize < 0) {
				barPixelSize = 0;
			}
			//trace("bar pixel size: ", barPixelSize);
			//trace(x);
			makeGraphic(barPixelSize, 2, 0xff00ff00);
		}
		
	}
}
	