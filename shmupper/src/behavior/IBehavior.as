package behavior {
	import ship.Ship;
	public interface IBehavior {
		function init(e:Element):void;
		function update(e:Element, t:Number, dt:Number):void;
	}
}