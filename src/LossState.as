package
{
	import org.flixel.*;
	
	public class LossState extends FlxState 
	{
		private var spacePressed:Boolean = false;
		private var menuCorpse:Corpse;
		
		private var timeSinceLoad:Number = 0;
		private var timeToWait:Number = 1;
		
		private var timeSinceSpacePressed:Number = 0;
		
		[Embed(source = "mp3/corpse_explosion.mp3")] private var ce_mp3_1:Class;

		
		override public function create():void
		{
			var textSize:Number = 32;
			var textWidth:Number = 300;
			var text:FlxText = new FlxText((FlxG.width / 2) - (textWidth / 2), (FlxG.height / 2) - (textSize * 3), textWidth, "YOU DIED")
			text.size = textSize;
			text.alignment = "center";
			add(text);
			
			
			textSize = 16;
			textWidth = 300;
			var startText:FlxText = new FlxText((FlxG.width / 2) - (textWidth / 2), (FlxG.height / 2) + (textSize), textWidth, "Press SPACE to try again")
			startText.size = textSize;
			startText.alignment = "center";
			add(startText);
			
			menuCorpse = new Corpse((FlxG.width/2) - 8, FlxG.height - 64);
			add(menuCorpse);
		}
		
		override public function update():void 
		{
			menuCorpse.timeAlive = 0;
			timeSinceLoad += FlxG.elapsed;
			
			if (FlxG.keys.justPressed("SPACE") && (timeSinceLoad >= timeToWait) && !spacePressed) {
				spacePressed = true;
				var radius:Number = 50;
				var explosion:Explosion = new Explosion(menuCorpse.x, menuCorpse.y, radius);
				add(explosion);
				add(explosion.gibsEmitter);
				menuCorpse.blowUp();
				FlxG.play(ce_mp3_1);
			}
			
			if (spacePressed) {
				timeSinceSpacePressed += FlxG.elapsed;
			}
						
			if (timeSinceSpacePressed >= 1.5) {
				FlxG.switchState(new PlayState());
			}
			
			super.update();
		}
	}
}