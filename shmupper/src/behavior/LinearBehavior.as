package behavior {
	import flash.geom.Point;
	import ship.Ship;
	public class LinearBehavior implements IBehavior {
		
		private var origin:Point;
		private var startTime:Number;
		private var velocity:Point;
		
		public function LinearBehavior(origin:Point, startTime:Number, velocity:Point) {
			this.origin = origin;
			this.startTime = startTime;
			this.velocity = velocity;
		}
		
		public function init(e:Element):void {
			e.visible = false;
			e.x = origin.x;
			e.y = origin.y;
			e.nextState();
		}
		public function update(e:Element, t:Number, dt:Number):void {
			if (t < startTime) {
				e.visible = false;
				//e.x = origin.x;
				//e.y = origin.y;
			} else {
				e.visible = true;
				var time:Number = t-startTime;
				e.x = origin.x+velocity.x*time;
				e.y = origin.y+velocity.y*time;
			}
		}
	}
}