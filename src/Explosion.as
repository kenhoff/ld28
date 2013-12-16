package
{
	import org.flixel.*;
	
	public class Explosion extends FlxSprite
	{
		[Embed(source = "img/Explosion.png")] private var image:Class;
		
		private var timeToLive:Number = .2;
		private var timeAlive:Number = 0;
		
		public var gibsEmitter:FlxEmitter;
		[Embed(source = "img/Gibs.png")] private var giblets:Class;

		
		public function Explosion(X:Number, Y:Number, radius:Number) {
			super(X, Y);
			loadGraphic(image);
			scale = new FlxPoint(radius / 16, radius / 16);
			
			gibsEmitter = new FlxEmitter(x + 8, y + 8);
			gibsEmitter.makeParticles(giblets, 50, 16, true);
			gibsEmitter.setXSpeed( -radius, radius);
			gibsEmitter.setYSpeed( -radius * 5, 0);
			gibsEmitter.gravity = 100;
			gibsEmitter.lifespan = 0.1;
			gibsEmitter.start();
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