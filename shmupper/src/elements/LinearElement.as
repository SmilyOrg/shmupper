package elements {
	import flash.geom.Point;
	public class LinearElement extends Element {
		
		private var origin:Point;
		private var startTime:Number;
		private var velocity:Point;
		
		public function LinearElement(origin:Point, startTime:Number, velocity:Point) {
			super(origin.clone());
			
			this.origin = origin;
			this.startTime = startTime;
			this.velocity = velocity;
			
		}
		
		override public function update(t:Number, dt:Number):void {
			
			if (t < startTime) {
				x = origin.x;
				y = origin.y;
			} else {
				var time:Number = t-startTime;
				x = origin.x+velocity.x*time;
				y = origin.y+velocity.y*time;
			}
			
		}
		
	}

}