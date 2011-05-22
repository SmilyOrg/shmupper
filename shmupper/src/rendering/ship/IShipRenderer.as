package rendering.ship {
	import flash.display.BitmapData;
	import ship.Ship;
	public interface IShipRenderer {
		function render(data:BitmapData, s:Ship, merged:ElementState):void;
	}
	
}