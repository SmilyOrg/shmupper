package ship.weapon {
	import ship.Ship;
	public interface IWeapon {
		function shoot():void;
		function update(s:Ship, t:Number, dt:Number):Vector.<IElement>;
	}
	
}