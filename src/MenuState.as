package
{
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		private var spacePressed:Boolean = false;
		private var menuCorpse:Corpse;
		private var fakePlayer:FakePlayer;
		private var fakeGuard:FakeGuard;
		
		private var timeSinceBlownUp:Number = 0;
		private var gibsEmitter:FlxEmitter;
		private var timeSinceMissile:Number = 100;
		private var guardHealth:Number = 7;
		
		[Embed(source = "mp3/corpse_explosion.mp3")] private var ce_mp3_1:Class;
		[Embed(source = "mp3/magic_missile_normal.mp3")] private var mm_mp3_1:Class;
		[Embed(source = "mp3/magic_missile_hi.mp3")] private var mm_mp3_2:Class;
		[Embed(source = "mp3/magic_missile_low.mp3")] private var mm_mp3_3:Class;

		
		override public function create():void
		{
			FlxG.bgColor = 0xff131c1b;
			
			var textSize:Number = 32;
			var textWidth:Number = 300;
			var text:FlxText = new FlxText((FlxG.width / 2) - (textWidth / 2), (FlxG.height / 2) - (textSize * 3), textWidth, "CORPSE EXPLOSION")
			text.size = textSize;
			text.alignment = "center";
			add(text);
			
			
			textSize = 16;
			textWidth = 300;
			var startText:FlxText = new FlxText((FlxG.width / 2) - (textWidth / 2), (FlxG.height / 2) + (textSize), textWidth, "Hold SPACE to begin")
			startText.size = textSize;
			startText.alignment = "center";
			add(startText);
			
			//menuCorpse = new Corpse((FlxG.width * 0.75) - 8, FlxG.height - 64);
			//add(menuCorpse);
			
			fakePlayer = new FakePlayer((FlxG.width * 0.25) - 8, FlxG.height - 64);
			add(fakePlayer);
			
			fakeGuard = new FakeGuard((FlxG.width * 0.75) - 8, FlxG.height - 64);
			add(fakeGuard);
			
			
		}
		
		override public function update():void 
		{
			timeSinceMissile += FlxG.elapsed;
			
			if ((timeSinceMissile > 0.25) && FlxG.keys.SPACE && (guardHealth > 0)) {
				magicMissile();
				timeSinceMissile = 0;
				guardHealth -= 1;
				if (guardHealth <= 0) {
					fakeGuard.kill();
					menuCorpse = new Corpse((FlxG.width * 0.75) - 8, FlxG.height - 64);
					add(menuCorpse);
				}
			}
			
			if (menuCorpse != null) {
				menuCorpse.timeAlive = 0;
			}
			
			if ((menuCorpse != null) && FlxG.keys.justPressed("SPACE") && !spacePressed) {
				spacePressed = true;
				var radius:Number = 50;
				var explosion:Explosion = new Explosion(menuCorpse.x, menuCorpse.y, radius);
				add(explosion);
				add(explosion.gibsEmitter);
				menuCorpse.blowUp();
				FlxG.play(ce_mp3_1);
			}
			
			if (spacePressed) {
				timeSinceBlownUp += FlxG.elapsed;
			}
			
			if (timeSinceBlownUp >= 2) {
				FlxG.switchState(new PlayState());
			}
			
			//if (FlxG.keys.justPressed("SPACE") && (guardHealth <= 0)) {
				//spacePressed = true;
				//var radius:Number = 50;
				//var explosion:Explosion = new Explosion(menuCorpse.x, menuCorpse.y, radius);
				//add(explosion);
				//add(explosion.gibsEmitter);
				//menuCorpse.blowUp();
				//FlxG.play(ce_mp3_1);
			//}
			//
			//
			//
				//
			//if (guardHealth <= 0) {
				//timeSinceBlownUp += FlxG.elapsed;
			//}
						//
			//if (timeSinceBlownUp >= 1.5) {
				//FlxG.switchState(new PlayState());
			//}
			
			super.update();
		}
		
		private function magicMissile():void {
			add(new MagicMissile((FlxG.width * 0.25) - 8, FlxG.height - 64, new FlxPoint(fakeGuard.x, fakeGuard.y)));
				magicMissileSound();
		}
		
		private function magicMissileSound():void {
			var random:Number = Math.random();
			if (random <= 0.33) {
				FlxG.play(mm_mp3_1);
			}
			else if ((random > 0.33) && (random <= 0.66)) {
				FlxG.play(mm_mp3_2);
			}
			else {
				FlxG.play(mm_mp3_3);
			}
		}
	}
}