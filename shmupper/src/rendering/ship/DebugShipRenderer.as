package rendering.ship {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import ship.Ship;
	public class DebugShipRenderer implements IShipRenderer {
		
		public function DebugShipRenderer() {}
		
		public function render(data:BitmapData, s:Ship, merged:ElementState):void {
			var hit:Rectangle = s.hitbox.clone();
			hit.offset(merged.p.x, merged.p.y);
			data.fillRect(hit, 0xFFFF0000);
		}
		
	}

}