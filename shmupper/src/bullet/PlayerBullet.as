package bullet {
	import flash.geom.Point;
	public class PlayerBullet extends Bullet {
		/** Cached offset collision lines */
		public var ca:Line = new Line();
		public var cb:Line = new Line();
		public function PlayerBullet(p:Point, v:Point) {
			super(p, v);
		}
	}
}