package ship.weapon {
	import bullet.Bullet;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.events.IEvent;
	import org.osflash.signals.Signal;
	import ship.Ship;
	public class Weapon extends Sprite {
		protected var delay:int = 30;
		protected var counter:int = 0;
		protected var cooling:Boolean = false;
		protected var body:Sprite;
		private var _angle:Number;
		public var shot:DeluxeSignal = new DeluxeSignal(this, IEvent, Bullet);
		public function Weapon(delay:Number = NaN):void {
			if (!isNaN(delay)) this.delay = delay; else delay = this.delay;
			
			body = new Sprite();
			addChild(body);
		}
		public function weaponReady():void {}
		public function shoot():void {}
		public function update():void {
			if (cooling) {
				counter++;
				if (counter >= delay) {
					counter = 0;
					cooling = false;
					weaponReady();
				}
			}
		}
		public function upgrade():void {}
		
		public function get angle():Number { return _angle; }
		
		public function set angle(value:Number):void {
			_angle = value;
			rotation = angle/Math.PI*180;
		}
	}	
}