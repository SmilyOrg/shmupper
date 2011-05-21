package  {
	import flash.geom.Point;
	public interface IElement {
		function get position():Point;
		function nextState():void;
		function applyMergedState(merged:ElementState, alpha:Number):void;
		function update(t:Number, dt:Number):void;
	}
	
}