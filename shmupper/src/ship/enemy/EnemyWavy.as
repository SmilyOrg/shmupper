package ship.enemy {
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ship.behavior.WavyBehavior;
	import ship.Player;
	import ship.weapon.Weapon;
	import ship.weapon.WeaponEnemyMachineGun;
	public class EnemyWavy extends Enemy {
		private var time:Number = 0;
		public function EnemyWavy(p:Point) {
			super(p, new Point());
			draw();
			time = Math.PI/2;
			
			hitbox = new Rectangle(-20, -10, 40, 20);
			
			addBehavior(new WavyBehavior());
			
			var w:WeaponEnemyMachineGun = addWeapon(new WeaponEnemyMachineGun(22, 0, Math.PI, 15, 4)) as WeaponEnemyMachineGun;
		}
		override public function ai(player:Player):void {
			shoot();
		}
		override protected function draw():void {
			body.graphics.clear();
			//body.graphics.beginFill(0xD4D4D4);
			body.graphics.lineStyle(1, 0xFF0000);
			//body.graphics.drawCircle(0, 0, 10);
			body.graphics.drawRect(-20, -10, 40, 20);
			//body.graphics.endFill();
			body.filters = [new GlowFilter(0xFF0000, 1, 6, 6, 2, 1)];
			//trace(health/maxHealth);
			//transform.colorTransform = new ColorTransform(1, health/maxHealth, health/maxHealth, 1, 0, 0, 0, 0);
			//body.transform.colorTransform = new ColorTransform(2, 1, 1, 1, 128, 0, 0, 0);
		}
	}
}