package ship.enemy {
	import ship.Player;
	import ship.Ship;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	public class Enemy extends Ship {
		public var level:Number = 0;
		public function Enemy(p:Point, v:Point):void {
			super(p);
			//angle += Math.PI;
		}
		public function ai(player:Player):void {}
	}	
}