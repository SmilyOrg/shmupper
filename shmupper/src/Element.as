package  {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	public class Element implements IElement {
		protected var p:Point;
		protected var v:Point;
		
		public function Element(p:Point = null, v:Point = null) {
			if (!p) p = new Point();
			if (!v) v = new Point();
			this.p = p;
			this.v = v;
		}
		public function set x(v:Number):void {
			p.x = v;
		}
		public function get x():Number {
			return p.x;
		}
		public function set y(v:Number):void {
			p.y = v;
		}
		public function get y():Number {
			return p.y;
		}
		public function get position():Point {
			return p;
		}
		public function get velocity():Point {
			return v;
		}
		public function force(dx:Number, dy:Number):void {
			v.x += dx;
			v.y += dy;
		}
		public function update():void {
			p.x += v.x;
			p.y += v.y;
		}
	}
}