package  {
	import flash.display.BitmapData;
	import flash.geom.Point;
	public class Particle implements IElement {
		
		public var next:Particle = null;
		public var image:BitmapData;
		public var imageOffset:Point;
		
		public var element:Element;
		
		public var radius:Number = 0;
		
		/** Marked for removal the next frame */
		public var remove:Boolean = false;
		
		public function Particle(baseElement:Element, image:BitmapData, imageOffset:Point = null) {
			element = baseElement;
			
			this.image = image;
			if (!imageOffset) imageOffset = new Point();
			this.imageOffset = imageOffset;
		}
		
		public function get position():Point {
			return element.position;
		}
		
		public function nextState():void {
			element.nextState();
		}
		public function applyMergedState(merged:ElementState, alpha:Number):void {
			element.applyMergedState(merged, alpha);
		}
		
		public function update(t:Number, dt:Number):void {
			element.update(t, dt);
		}
		
	}
}