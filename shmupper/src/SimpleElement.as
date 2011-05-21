package  {
	import flash.geom.Point;
	public class SimpleElement extends Element {
		
		
		private var v:Point;
		
		public function SimpleElement(p:Point = null, v:Point = null) {
			if (!v) v = new Point();
			this.v = v;
			
			super(p);
		}
		
		public function get velocity():Point {
			return v;
		}
		
		public function force(dx:Number, dy:Number):void {
			v.x += dx;
			v.y += dy;
		}
		
		
		override public function update(t:Number, dt:Number):void {
			cur.p.x += v.x*dt;
			cur.p.y += v.y*dt;
		}
		
	}

}