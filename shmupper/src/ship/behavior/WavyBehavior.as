package ship.behavior {
	import flash.geom.Point;
	import ship.Ship;
	public class WavyBehavior implements IBehavior {
		private var time:Number = Math.PI/2;
		public function WavyBehavior() {}
		public function update(s:Ship):void {
			var v:Point = s.velocity;
			v.x += Math.sin(time)*0.1;
			v.y += Math.sin(time*8)*0.1;
			time += 0.01;
		}
	}
}