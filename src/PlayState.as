package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		private var player:Player;
		private var grassTiles:FlxTileblock;
		private var wallTiles:FlxTilemap;
		private var guardGroup:FlxGroup;
		private var guardHealthBarGroup:FlxGroup;
		private var guard:Guard;
		private var timeSinceMissile:Number = 10000000;
		private var corpseGroup:FlxGroup;
		private var timeSinceGuardSpawn:Number = 0;
		private var guardSpawnsEveryXSeconds:Number = 5;
		private var timeSinceGameStart:Number = 0;
		
		private var radiusText:FlxText;
		private var scoreText:FlxText;
		
		private var scoreCount:int = 0;
		private var targetScore:int = 60;
		
		private var explodeRadius:Number = 30;
		private var powerupIncrease:Number = 10;
		private var powerupFrequency:Number = 7;
		
		private var guardCount:int = 5;
		
		private var powerups:FlxGroup;
		
		[Embed(source = "img/Grass.png")] private var GrassTiles:Class;
		[Embed(source = "img/Walls.png")] private var WallGraphic:Class;
		[Embed(source = "mp3/magic_missile_normal.mp3")] private var mm_mp3_1:Class;
		[Embed(source = "mp3/magic_missile_hi.mp3")] private var mm_mp3_2:Class;
		[Embed(source = "mp3/magic_missile_low.mp3")] private var mm_mp3_3:Class;
		[Embed(source = "mp3/corpse_explosion.mp3")] private var ce_mp3_1:Class;
		[Embed(source = "mp3/corpse_explosion_hi.mp3")] private var ce_mp3_2:Class;
		[Embed(source = "mp3/corpse_explosion_low.mp3")] private var ce_mp3_3:Class;
		
		[Embed(source = "img/Gibs.png")] private var giblets:Class;
		
		
		private function updateRadiusText():String
		{
			var str1:String = "Explosion Radius: " + explodeRadius + " pixels";
			return str1;
		}
		
		
		override public function create():void
		{
			radiusText = new FlxText(0, 0, 200, updateRadiusText());
			scoreText = new FlxText(FlxG.width - 100, 0, 100);
			scoreText.alignment = "right";
			grassTiles = new FlxTileblock(0, 0, FlxG.width, FlxG.height);
			grassTiles.loadTiles(GrassTiles);
			add(grassTiles);
			
			wallTiles = new FlxTilemap();
			var mapData:Array = new Array(
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
				0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
				0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
				0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
				0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
			);
			
			for (var i:int = 0; i < mapData.length; i++) {
				if (Math.random() <= 0.10) {
					mapData[i] = int(Math.random() * 8);
				}
				else {
					mapData[i] = 0;
				}
			}
			
			
			
			
			
			wallTiles.loadMap(FlxTilemap.arrayToCSV(mapData, 20), WallGraphic);
			add(wallTiles);
			player = new Player(FlxG.width / 2, FlxG.height / 2);
			add(player);
			add(player.healthBar);
			
			guardGroup = new FlxGroup();
			guardHealthBarGroup = new FlxGroup();
			corpseGroup = new FlxGroup();
			add(radiusText);
			add(scoreText);
			powerups = new FlxGroup();
		}
		
		private function createGuard():void 
		{
			var newGuard:Guard;
			var _x:Number; 
			var _y:Number;
			
			var rand:Number = Math.random();
			
			if (rand <= 0.25) {
				//up
				_x = Math.random() * FlxG.width;
				_y = -16;
			}
			else if (rand <= 0.5) {
				//down
				_x = Math.random() * FlxG.width;
				_y = FlxG.height;
			}
			else if (rand <= 0.75) {
				//left
				_x = -16;
				_y = FlxG.height * Math.random();
			}
			else {
				//right
				_x = FlxG.width;
				_y = FlxG.height * Math.random();
			}
			
			
			
			
			newGuard = new Guard(_x, _y);
			
			newGuard.targetSprite = player;
			guardGroup.add(newGuard);
			guardHealthBarGroup.add(newGuard.healthBar);
			add(guardGroup);
			add(guardHealthBarGroup);

		}
		
		private function createCorpse(X:Number, Y:Number):void 
		{
			var corpse:Corpse = new Corpse(X, Y);
			corpseGroup.add(corpse);
			add(corpseGroup);
		}
		
		override public function update():void
		{
			if (player.health <= 0) {
				FlxG.switchState(new LossState());
			}
			
			if (scoreCount >= targetScore) {
				FlxG.switchState(new WinState());
			}
			
			adjustSpawnRate();
			timeSinceGuardSpawn += FlxG.elapsed;
			timeSinceGameStart += FlxG.elapsed;
			
			if (timeSinceGuardSpawn >= guardSpawnsEveryXSeconds) {
				createGuard();
				timeSinceGuardSpawn = 0;
			}
			
			radiusText.text = updateRadiusText();
			scoreText.text = "Score: " + scoreCount + " / " + targetScore;
			
			timeSinceMissile += FlxG.elapsed;
			FlxG.mouse.show();
			
			if (FlxG.keys.justPressed("SPACE")) {
				blowUpNearestCorpse();
			}
			
			else if (FlxG.keys.SPACE) { 				
				if (timeSinceMissile > 0.25) {
					magicMissile();
					timeSinceMissile = 0;
				}
			}
			
			if (FlxG.keys.justPressed("N")) {
				createGuard();
			}
			var i:int;
			//FlxG.collide(player, guardGroup);
			for (i = 0; i < guardGroup.length; i++) {
				FlxG.overlap(player, guardGroup.members[i], hurtPlayer);
			}
			FlxG.collide(player, wallTiles);
			FlxG.collide(guardGroup, wallTiles);
			FlxG.collide(guardGroup, guardGroup);
			
			for (i = 0; i < powerups.length; i++) {
				FlxG.overlap(player, powerups.members[i], pickUpPowerup);
			}
			
			add(corpseGroup);
			add(powerups);
			add(guardGroup);
			add(guardHealthBarGroup);
			add(player);
			add(player.healthBar);

			
			super.update();
		}
		
		private function hurtPlayer(player:Player, guard:Guard):void
		{
			FlxObject.separate(player, guard);
			
			if (guard.swing()) {
				//trace("hit!");
				player.hurt(10);
				guard.timeSinceAttack = 0;
			}
		}
		
		private function blowUpNearestCorpse():Boolean 
		{
			var closestCorpse:Corpse = null;
			var closestDist:Number = 100000000000000;
			var i:int;
			for (i = 0; i < corpseGroup.length; i++) {
				if (corpseGroup.members[i].blownUp) {
					continue;
				}
				var diff_x:Number = player.x - corpseGroup.members[i].x;
				var diff_y:Number = player.y - corpseGroup.members[i].y;
				var dist:Number = Math.sqrt(Math.pow(diff_x, 2) + Math.pow(diff_y, 2));
				if (dist < closestDist) {
					closestDist = dist;
					closestCorpse = corpseGroup.members[i];
				}
			}
		
			if (closestCorpse != null) {
				closestCorpse.blowUp();
				corpseExplosionSound();
				var explosion:Explosion = new Explosion(closestCorpse.x, closestCorpse.y, explodeRadius);
				add(explosion);
				add(explosion.gibsEmitter);
				var damagedGuards:FlxGroup = new FlxGroup();
				for (i = 0; i < guardGroup.length; i++) {
					if (guardGroup.members[i].health <= 0) {
						continue;
					}
					diff_x = player.x - guardGroup.members[i].x;
					diff_y = player.y - guardGroup.members[i].y;
					dist = Math.sqrt(Math.pow(diff_x, 2) + Math.pow(diff_y, 2));
					
					if (dist <= explodeRadius) {
						damagedGuards.add(guardGroup.members[i]);
					}
				}
				
				for (i = 0; i < damagedGuards.length; i++) {
					damagedGuards.members[i].hurt(50);
					if (damagedGuards.members[i].health <= 0) {
						createCorpse(damagedGuards.members[i].x, damagedGuards.members[i].y);
						scoreCount += 1;
						chanceToDropPowerup(damagedGuards.members[i].x, damagedGuards.members[i].y);
					}
				return true;
				}
			}
			return false;
		}
		
		
		private function magicMissile():void
		{
			
			// find nearest guard
			
			var closestGuard:Guard = null;
			var closestDist:Number = 10000000000000;
			for (var i:int = 0; i < guardGroup.length; i++) {
				if (guardGroup.members[i].health <= 0) {
					continue;
				}
				var diff_x:Number = player.x - guardGroup.members[i].x;
				var diff_y:Number = player.y - guardGroup.members[i].y;
				var dist:Number = Math.sqrt(Math.pow(diff_x, 2) + Math.pow(diff_y, 2));
				if (dist < closestDist) {
					closestDist = dist;
					closestGuard = guardGroup.members[i];
				}
			}
			
			if (closestGuard != null) {
				//hurt nearest guard
				closestGuard.hurt(10);
				
				// if nearest guard dies from that, remove him from the guardGroup
				
				add(new MagicMissile(player.x, player.y, new FlxPoint(closestGuard.x, closestGuard.y)));
				magicMissileSound();
				
				
				
				if (closestGuard.health <= 0) {
					//trace("guard killed");
					createCorpse(closestGuard.x, closestGuard.y);
					scoreCount += 1;
					chanceToDropPowerup(closestGuard.x, closestGuard.y);
				}
			
			}
			
			
		}
		
		
		private function chanceToDropPowerup(x:Number, y:Number):void {
			if ((scoreCount % powerupFrequency) == 0) {
				powerups.add(new Powerup(x, y));
			}
		}
		
		private function pickUpPowerup(player:Player, powerup:Powerup):void {
			if (!powerup.pickedUp) {
				powerup.pickedUp = true;
				explodeRadius += powerupIncrease;
			}
		}
		
		private function adjustSpawnRate():void {
			
			//var _score:Number = scoreCount;
			//var _maxRate:Number = 0;
			//var _minRate:Number = 5;
			//var _goalScore:Number = targetScore;
			//
			//var _currentRate:Number = (- (1 /(_goalScore / _minRate)) * _score ) + _minRate;
			//
			//guardSpawnsEveryXSeconds = _currentRate;
			//guardSpawnsEveryXSeconds = -0.00005(Math.pow(scoreCount, 2.5)) + 5;
			//trace(guardSpawnsEveryXSeconds);
			
			
			var rateMap:Array = new Array(
				10, 3,
				20, 2,
				30, 1,
				40, 0.5
				
			);
			
			for (var i:int = 0; i < rateMap.length; i += 2) {
				if (timeSinceGameStart > rateMap[i]) {
					guardSpawnsEveryXSeconds = rateMap[i + 1];
				}
				else {
					break;
				}
			}
			trace(guardSpawnsEveryXSeconds);
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
		
		private function corpseExplosionSound():void {
			var random:Number = Math.random();
			if (random <= 0.33) {
				FlxG.play(ce_mp3_1);
			}
			else if ((random > 0.33) && (random <= 0.66)) {
				FlxG.play(ce_mp3_2);
			}
			else {
				FlxG.play(ce_mp3_3);
			}
		}
		
	}
}