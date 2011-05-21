package  {
	import flash.geom.Point;
	public class ElementState {
		public var p:Point;
		
		public function ElementState(p:Point = null) {
			if (!p) p = new Point();
			this.p = p;
		}
		
	}

}