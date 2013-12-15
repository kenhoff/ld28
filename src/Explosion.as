package
{
	import org.flixel.*;
	
	public class Explosion extends FlxSprite
	{
		[Embed(source = "img/Explosion.png")] private var image:Class;
		
		private var timeToLive:Number = .2;
		private var timeAlive:Number = 0;
		
		public function Explosion(X:Number, Y:Number, radius:Number) {
			super(X, Y);
			loadGraphic(image);
			scale = new FlxPoint(radius/16, radius/16);
		}
		
		override public function update():void
		{
			timeAlive += FlxG.elapsed;
			if (timeAlive > timeToLive) {
				kill();
			}
		}
		
	}
}