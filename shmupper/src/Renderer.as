package  {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import no.doomsday.console.ConsoleUtil;
	public class Renderer extends Sprite {
		
		private var w:Number;
		private var h:Number;
		
		private var buffer:BitmapData;
		private var display:Bitmap;
		
		public function Renderer(w:Number, h:Number) {
			this.w = w;
			this.h = h;
			
			buffer = new BitmapData(w, h);
			display = new Bitmap(buffer);
			addChild(display);
		}
		
		public function render(sim:Simulation):void {
			buffer.fillRect(buffer.rect, 0xFFFFFFFF);
			
			//var pos:Point = new Point();
			var merged:ElementState = new ElementState();
			var pos:Point = merged.p;
			var p:Particle = sim.particles;
			var alpha:Number = sim.stepProgress;
			var rendered:int = 0;
			while (p) {
				//var prev:ElementState = p.previousState;
				//var cur:ElementState = p.currentState;
				
				//pos.x = cur.p.x*alpha+prev.p.x*(1-alpha)+p.imageOffset.x;
				//pos.y = cur.p.y*alpha+prev.p.y*(1-alpha)+p.imageOffset.y;
				
				//pos.x = p.x+p.imageOffset.x;
				//pos.y = p.y+p.imageOffset.y;
				
				p.applyMergedState(merged, alpha);
				
				pos.x += p.imageOffset.x;
				pos.y += p.imageOffset.y;
				
				buffer.copyPixels(p.image, p.image.rect, merged.p, null, null, true);
				
				p = p.next;
				
				rendered++;
			}
			
			ConsoleUtil.print("Rendered: "+rendered+" particles");
		}
		
	}

}