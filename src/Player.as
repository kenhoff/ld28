package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = "img/Necromancer.png")] private var playerGraphic:Class;
		private var playerSpeed:Number = 50;
		private var maxHealth:Number = 70;
		public var healthBar:HealthBar;
		public function Player(X:int, Y:int)
		{
			super(X, Y);
			loadGraphic(playerGraphic);
			healthBar = new HealthBar(X, Y);
			health = maxHealth;
			width = width * 0.9;
			height = height * 0.9;
			offset.x = 1;
			offset.y = 1;
			
		}
		override public function update():void
		{
			if (health <= 0) {
				FlxG.switchState(new LossState());
			}
			health += FlxG.elapsed;
			if (health > maxHealth) {
				health = maxHealth;
			}
			velocity = new FlxPoint(0, 0);
			
			if ((FlxG.mouse.x - x) > 0) {
				velocity.x = playerSpeed;
			}
			else {
				velocity.x = -playerSpeed;
			}
			
			if ((FlxG.mouse.y - y) > 0) {
				velocity.y = playerSpeed;
			}
			else {
				velocity.y = -playerSpeed;
			}
			
			healthBar.x = x;
			healthBar.y = y;
			
			var percentHealthLeft:Number = health / maxHealth;
			if (percentHealthLeft < 0) {
				percentHealthLeft = 0;
			}
			healthBar.updateHealthBar(percentHealthLeft);
			
		}
		
		override public function kill():void
		{
			healthBar.kill();
			super.kill();
		}
		
	}
}