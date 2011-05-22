package rendering {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import no.doomsday.console.ConsoleUtil;
	import ship.Ship;
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
			var mergedPos:Point = merged.p;
			
			var alpha:Number = sim.stepProgress;
			//var alpha:Number = 0;
			
			//ConsoleUtil.print("alpha: "+alpha);
			var p:Particle = sim.particles;
			var rendered:int = 0;
			while (p) {
				if (!p.visible) {
					p = p.next;
					continue;
				}
				
				//var prev:ElementState = p.previousState;
				//var cur:ElementState = p.currentState;
				
				//pos.x = cur.p.x*alpha+prev.p.x*(1-alpha)+p.imageOffset.x;
				//pos.y = cur.p.y*alpha+prev.p.y*(1-alpha)+p.imageOffset.y;
				
				//pos.x = p.x+p.imageOffset.x;
				//pos.y = p.y+p.imageOffset.y;
				
				p.applyMergedState(merged, alpha);
				mergedPos.x = Math.round(mergedPos.x+p.imageOffset.x);
				mergedPos.y = Math.round(mergedPos.y+p.imageOffset.y);
				
				//pos.x = merged.p.x+p.imageOffset.x;
				//pos.y = merged.p.y+p.imageOffset.y;
				
				//pos.x = p.x+p.imageOffset.x;
				//pos.y = p.y+p.imageOffset.y;
				
				//if (!merged.p.equals(p.currentState.p)) {
					//ConsoleUtil.print("alpha "+alpha+"\ncur "+p.currentState.p+"\npre "+p.previousState.p+"\nmer "+merged.p+"\n");
				//}
				
				buffer.copyPixels(p.image, p.image.rect, mergedPos, null, null, true);
				
				//buffer.copyPixels(p.image, p.image.rect, new Point(p.currentState.p.x+p.imageOffset.x, p.currentState.p.y+p.imageOffset.y), null, null, true);
				//buffer.copyPixels(p.image, p.image.rect, new Point(p.previousState.p.x+p.imageOffset.x, p.previousState.p.y+p.imageOffset.y), null, null, true);
				
				p = p.next;
				
				rendered++;
			}
			
			var ships:Vector.<Ship> = sim.ships;
			for (var i:int = 0; i < ships.length; i++) {
				var s:Ship = ships[i];
				if (!s.visible) continue;
				s.applyMergedState(merged, alpha);
				s.renderer.render(buffer, s, merged);
			}
			
			//ConsoleUtil.print("Rendered: "+rendered+" particles");
		}
		
	}

}