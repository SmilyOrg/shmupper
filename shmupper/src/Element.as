package  {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	public class Element implements IElement {
		
		public var visible:Boolean = true;
		
		protected var prev:ElementState;
		protected var cur:ElementState;
		
		public function Element(p:Point = null) {
			prev = new ElementState();
			cur = new ElementState(p);
			nextState();
		}
		public function set x(v:Number):void {
			cur.p.x = v;
		}
		public function get x():Number {
			return cur.p.x;
		}
		public function set y(v:Number):void {
			cur.p.y = v;
		}
		public function get y():Number {
			return cur.p.y;
		}
		
		public function get position():Point {
			return cur.p;
		}
		public function get previousState():ElementState {
			return prev;
		}
		public function get currentState():ElementState {
			return cur;
		}
		
		
		public function getMergedState(alpha:Number):ElementState {
			return new ElementState(new Point(cur.p.x*alpha+prev.p.x*(1-alpha), cur.p.y*alpha+prev.p.y*(1-alpha)));
		}
		public function applyMergedState(merged:ElementState, alpha:Number):void {
			merged.p.x = cur.p.x*alpha+prev.p.x*(1-alpha);
			merged.p.y = cur.p.y*alpha+prev.p.y*(1-alpha);
		}
		
		public function nextState():void {
			prev.p.x = cur.p.x;
			prev.p.y = cur.p.y;
		}
		
		public function update(t:Number, dt:Number):void {};
	}
}