package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		private var player:FlxSprite;
		private var playerSpeed:Number = 50;
		private var grassTiles:FlxTileblock;
		private var wallTiles:FlxTilemap;
		
		private var guard:FlxSprite;
		
		[Embed(source = "img/Grass.png")] var GrassTiles:Class;
		[Embed(source = "img/Necromancer.png")] var playerGraphic:Class;
		[Embed(source = "img/Walls.png")] var WallGraphic:Class;
		
		override public function create():void
		{
			grassTiles = new FlxTileblock(0, 0, FlxG.width, FlxG.height);
			grassTiles.loadTiles(GrassTiles);
			add(grassTiles);
			
			wallTiles = new FlxTilemap();
			var mapData:Array = new Array(
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,
				1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,
				1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,
				1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,
				1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1,
				1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,
				1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,
				1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,
				1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			);
			
			
			wallTiles.loadMap(FlxTilemap.arrayToCSV(mapData, 20), WallGraphic);
			add(wallTiles);
			
			//guard = new FlxSprite
			
			player = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
			player.loadGraphic(playerGraphic);
			add(player);
		}
		
		override public function update():void
		{
			player.velocity = new FlxPoint(0, 0);
			if (FlxG.keys.LEFT) {
				player.velocity.x = -playerSpeed;
			}
			if (FlxG.keys.RIGHT) {
				player.velocity.x = playerSpeed;
			}
			if (FlxG.keys.UP) {
				player.velocity.y = -playerSpeed;
			}
			if (FlxG.keys.DOWN) {
				player.velocity.y = playerSpeed;
			}
			
			FlxG.collide(player, wallTiles);
			
			super.update();
		}
	}
}