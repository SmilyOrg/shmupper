package ship {
	import behavior.KeyboardControlBehavior;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.utils.Timer;
	import messages.MessageEvent;
	public class Player extends Ship {
		//private var weapon1:Sprite;
		
		public var experience:Number = 0;
		public var nextUpgrade:Number = 10;
		private var regenerateDelay:Timer;
		private var regeneration:Timer;
		public var normalDrag:Number = 0.75;
		public var slowdownDrag:Number = 0.9;
		public function Player(controlDispatcher:InteractiveObject, p:Point):void {
			health = 100;
			
			super(p);
			
			//addWeapon(new WeaponPlayerMachineGun(10, 0, 0, 0, 200));
			//addWeapon(new WeaponPlayerMachineGun(10, 20, 0, 0, 200));
			//addWeapon(new WeaponPlayerMachineGun(10, -20, 0, 0, 200));
			
			//addWeapon(new WeaponPlayerMachineGun(10, 0, 0, 0, 400));
			//addWeapon(new WeaponPlayerMachineGun(10, 20, 0, 0, 400));
			//addWeapon(new WeaponPlayerMachineGun(10, -20, 0, 0, 400));
			
			//addWeapon(new WeaponPlayerMachineGun(10, 0, -Math.PI*0.1, 0, 50));
			//addWeapon(new WeaponPlayerMachineGun(10, 0, Math.PI*0.1, 0, 50));
			
			//addWeapon(new WeaponPlayerMachineGun(10, 0, 0, 0, 1));
			//addWeapon(new WeaponPlayerMachineGun(10, 0, 0, 0, 200));
			//addWeapon(new WeaponPlayerMachineGun(10, 0, 0, 5, 100));
			
			//addWeapon(new WeaponPlayerMachineGun(10, 0, 0, 10, 20));
			//addWeapon(new WeaponPlayerMachineGun(10, 0, -Math.PI*0.1, 10, 50));
			//addWeapon(new WeaponPlayerMachineGun(10, 0, Math.PI*0.1, 10, 50));
			
			//addWeapon(new WeaponPlayerMachineGun(10, 0, -Math.PI*0.1));
			//addWeapon(new WeaponPlayerMachineGun(10, 0, Math.PI*0.1));
			//addWeapon(new WeaponPlayerMachineGun(10, 0, -Math.PI*0.2));
			//addWeapon(new WeaponPlayerMachineGun(10, 0, Math.PI*0.2));
			//addWeapon(new WeaponMachineGun(10, 10));
			//addWeapon(new WeaponMachineGun(10, -10));
			//addWeapon(new WeaponMachineGun(10, 15));
			//addWeapon(new WeaponMachineGun(10, -15));
			
			addBehavior(new KeyboardControlBehavior(controlDispatcher));
			
			hitbox = new Rectangle(-5, -5, 10, 10);
		}
		
	}	
}