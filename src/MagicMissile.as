package
{
	import org.flixel.*;
	
	public class MagicMissile extends FlxSprite
	{
		[Embed(source = "img/Magic Missile.png")] private var mmGraphic:Class;
		private var speed:Number = 500;
		
		
		
		public function MagicMissile(X:int, Y:int, target:FlxPoint)
		{
			//make the speed all the same
			super(X, Y);
			loadGraphic(mmGraphic);
			
			var diff_x:Number = target.x - x;
			var diff_y:Number = target.y - y;
			var dist:Number = Math.sqrt(Math.pow(diff_x, 2) + Math.pow(diff_y, 2));	
			
			var normal_x:Number = diff_x / dist;
			var normal_y:Number = diff_y / dist;
			//trace(normal_x, normal_y);
			
			
			
			velocity = new FlxPoint(normal_x * speed, normal_y * speed);
			
			
			
			
			
			
			health = 1;
		}
		
		override public function update():void
		{
			hurt(FlxG.elapsed);
		}
	}
}