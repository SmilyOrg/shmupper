package  {
	import flash.geom.Point;
	public interface IElement {
		function get position():Point;
		function get velocity():Point;
		function update():void;
	}
	
}