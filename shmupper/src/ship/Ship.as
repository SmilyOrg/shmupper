package ship {
	import bullet.Bullet;
	import com.greensock.TweenNano;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import no.doomsday.console.ConsoleUtil;
	import org.osflash.signals.events.GenericEvent;
	import org.osflash.signals.Signal;
	import rendering.ship.DebugShipRenderer;
	import rendering.ship.IShipRenderer;
	import ship.weapon.IWeapon;
	public class Ship extends BehavioralElement {
		
		public var speed:Number = 1;
		
		public var maxHealth:Number = 0;
		public var health:Number = 0;
		
		public var elementsAdded:Signal = new Signal(Vector.<IElement>);
		
		public var hitbox:Rectangle = new Rectangle(-5, -5, 10, 10);
		
		public var renderer:IShipRenderer = new DebugShipRenderer();
		
		protected var weapons:Vector.<IWeapon> = new Vector.<IWeapon>();
		
		public function Ship(p:Point = null) {
			super(p);
		}
		
		public function addWeapon(w:IWeapon):IWeapon {
			weapons.push(w);
			return w;
		}
		
		public function shoot():void {
			for (var i:Number = 0; i < weapons.length; i++) {
				var w:IWeapon = weapons[i];
				w.shoot();
			}
		}
		
		override public function update(t:Number, dt:Number):void {
			
			super.update(t, dt);
			
			for each (var w:IWeapon in weapons) {
				var addedElements:Vector.<IElement> = w.update(this, t, dt);
				if (addedElements && addedElements.length > 0) {
					elementsAdded.dispatch(addedElements);
				}
			}
		}
		
		public function damage(delta:Number):void {
			health -= delta;
		}
	}	
}