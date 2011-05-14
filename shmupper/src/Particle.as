package  {
	import flash.display.BitmapData;
	import flash.geom.Point;
	public class Particle extends Element {
		
		public var next:Particle = null;
		public var image:BitmapData;
		public var imageOffset:Point;
		
		public var radius:Number = 0;
		
		/** Marked for removal the next frame */
		public var remove:Boolean = false;
		
		public function Particle(p:Point, v:Point, image:BitmapData, imageOffset:Point = null) {
			this.image = image;
			if (!imageOffset) imageOffset = new Point();
			this.imageOffset = imageOffset;
			
			this.p = p;
			this.v = v;
		}
	}
}