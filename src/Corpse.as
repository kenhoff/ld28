package
{
	import org.flixel.*;
	
	public class Corpse extends FlxSprite
	{
		[Embed(source = "img/Guard Corpse.png")] private var corpseGraphic:Class;
		[Embed(source = "img/Guard Skeleton.png")] private var skeletonGraphic:Class;
		
		public var blownUp:Boolean = false;
		private var decayTime:Number = 10;
		public var timeAlive:Number = 0;
		
		public function Corpse(X:Number, Y:Number)
		{
			super(X, Y);
			loadGraphic(corpseGraphic);
		}
		
		public function blowUp():void 
		{
			loadGraphic(skeletonGraphic);
			blownUp = true;
		}
		
		override public function update():void
		{
			timeAlive += FlxG.elapsed;
			if (timeAlive >= decayTime) {
				blowUp();
			}
		}
	}
}