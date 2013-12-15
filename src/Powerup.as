package
{
	import org.flixel.*;
	
	public class Powerup extends FlxSprite
	{
		public var pickedUp:Boolean = false;
		[Embed(source = "img/Magic Missile.png")] private var graphic:Class;
		public function Powerup(X:Number, Y:Number)
		{
			super(X, Y);
			loadGraphic(graphic);
		}
		
		override public function update():void 
		{
			if (pickedUp) {
				kill();
			}
		}
	}
}