package 
{
	import org.flixel.*;
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	
	public class Main extends FlxGame 
	{
		
		public function Main():void 
		{
			super(640/2, 480/2, MenuState, 2);
		}
	}
	
}