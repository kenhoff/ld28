package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		private var player:FlxSprite;
		
		override public function create():void
		{
			player = new FlxSprite(FlxG.width/2, FlxG.height/2);
			add(player);
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}