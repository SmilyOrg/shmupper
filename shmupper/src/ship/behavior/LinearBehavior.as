package ship.behavior {
	import flash.geom.Point;
	import no.doomsday.console.ConsoleUtil;
	import ship.Ship;
	public class LinearBehavior implements IBehavior {
		public function LinearBehavior() {
		}
		public function update(s:Ship):void {
			var v:Point = s.velocity;
			v.y += 0.1;
		}
	}
}