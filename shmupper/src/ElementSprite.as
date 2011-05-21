package  {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getTimer;
	public class ElementSprite extends Sprite implements IElement {
		protected var p:Point = new Point();
		protected var v:Point = new Point();
		private var prevTime:Number;
		
		public function ElementSprite(p:Point = null, v:Point = null) {
			if (!p) p = new Point();
			if (!v) v = new Point();
			x = p.x;
			y = p.y;
			this.v = v;
			prevTime = getTimer();
		}
		override public function set x(v:Number):void {
			super.x = p.x = v;
		}
		override public function get x():Number {
			return p.x;
		}
		override public function set y(v:Number):void {
			super.y = p.y = v;
		}
		override public function get y():Number {
			return p.y;
		}
		public function get position():Point {
			return p;
		}
		public function get velocity():Point {
			return v;
		}
		public function applyMergedState(merged:ElementState, alpha:Number):void {
		}
		public function update(t:Number, dt:Number):void {
			//var time:Number = getTimer();
			//var dt:Number = time-prevTime;
			//prevTime = time;
			//x += v.x*dt;
			//y += v.y*dt;
		}
		
		/* INTERFACE IElement */
		
		public function nextState():void{
			
		}
	}
}