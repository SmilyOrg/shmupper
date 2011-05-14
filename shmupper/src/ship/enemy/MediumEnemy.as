package ship.enemy {
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ship.Player;
	import ship.weapon.Weapon;
	public class MediumEnemy extends Enemy {
		public function MediumEnemy(p:Point) {
			super(p, new Point());
			draw();
			hitbox = new Rectangle(-8, -14, 16, 24);
		}
		override protected function draw():void {
			body.graphics.clear();
			body.graphics.lineStyle(1, 0xFF0000);
			body.graphics.drawRect(-8, -14, 16, 24);
			body.filters = [new GlowFilter(0xFF0000, 1, 6, 6, 2, 1)];
		}
	}
}