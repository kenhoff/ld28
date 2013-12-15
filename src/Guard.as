package
{
	import org.flixel.*;
	
	public class Guard extends FlxSprite
	{
		
		[Embed(source = "img/Guard.png")] private var guardGraphic:Class;
		
		public var targetSprite:FlxSprite;
		private var guardSpeed:Number = 25;
		private var maxHealth:Number = 70;
		public var healthBar:HealthBar;
		public var timeSinceAttack:Number;
		
		public function Guard(X:int, Y:int)
		{
			super(X, Y);
			loadGraphic(guardGraphic);
			healthBar = new HealthBar(X, Y);
			health = maxHealth;
			timeSinceAttack = 100;
		}
		
		override public function update():void
		{
			if (health < 0) {
				destroy();
			}
			
			velocity = new FlxPoint(0, 0);
			var diff:Number = (targetSprite.y - y);
			if (diff > 0) {
				velocity.y = guardSpeed;
			}
			else {
				velocity.y = -guardSpeed;
			}
			
			diff = (targetSprite.x - x);
			
			if (diff > 0) {
				velocity.x = guardSpeed;
			}
			else {
				velocity.x = -guardSpeed;
			}
			healthBar.x = x;
			healthBar.y = y;
			
			var percentHealthLeft:Number = health / maxHealth;
			if (percentHealthLeft < 0) {
				percentHealthLeft = 0;
			}
				
			healthBar.updateHealthBar(percentHealthLeft);
			
			timeSinceAttack += FlxG.elapsed;
			
		}	
		
		override public function kill():void
		{
			//trace("guard is dead!");
			healthBar.kill();
			super.kill();
		}
		
		public function swing():Boolean {
			if (timeSinceAttack >= 2) {
				return true;
			}
			else return false;
		}
	}
}