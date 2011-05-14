package ship {
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
	import ship.behavior.KeyboardControlBehavior;
	import ship.weapon.WeaponPlayerMachineGun;
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
			
			addWeapon(new WeaponPlayerMachineGun(10, 0, -Math.PI*0.1, 0, 50));
			addWeapon(new WeaponPlayerMachineGun(10, 0, Math.PI*0.1, 0, 50));
			
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
			
			//drag = 1.2;
			//drag = normalDrag;
			//speed = 5;
			
			//weapon1 = new Sprite();
			//body.addChild(weapon1);
			draw();
			
			addBehavior(new KeyboardControlBehavior(controlDispatcher));
			
			hitbox = new Rectangle(-5, -5, 10, 10);
			
			regenerateDelay = new Timer(3000, 1);
			regenerateDelay.addEventListener(TimerEvent.TIMER_COMPLETE, startRegenerationDelay);
			regeneration = new Timer(10, 0);
			regeneration.addEventListener(TimerEvent.TIMER, regenerate);
			
			//messages.show(p, "Hello world!");
		}
		public function moveUp():void {
			v.y = -speed;
		}
		public function moveDown():void {
			v.y = speed;
		}
		public function moveLeft():void {
			v.x = -speed;
		}
		public function moveRight():void {
			v.x = speed;
		}
		public function initRegeneration():void {
			regeneration.reset();
			regenerateDelay.reset();
			regenerateDelay.start();
		}
		private function startRegenerationDelay(event:TimerEvent):void {
			regeneration.start();
		}
		private function regenerate(event:TimerEvent):void {
			if (health >= maxHealth) {
				regeneration.stop();
			} else {
				damage(-1);
			}
		}
		override protected function draw():void {
			body.graphics.clear();
			//body.graphics.beginFill(0xD4D4D4);
			body.graphics.lineStyle(1, 0x0000FF);
			//body.graphics.drawCircle(0, 0, 10);
			body.graphics.drawRect(-20, -10, 40, 20);
			//body.graphics.endFill();
			body.filters = [new GlowFilter(0x0000FF, 1, 6, 6, 2, 1)];
			//trace(health/maxHealth);
			//transform.colorTransform = new ColorTransform(1, health/maxHealth, health/maxHealth, 1, 0, 0, 0, 0);
			//body.transform.colorTransform = new ColorTransform(2, 1, 1, 1, 128, 0, 0, 0);
		}
		public function facePosition(p:Point):void {
			angle = Math.atan2(p.y-y, p.x-x);
		}
	}	
}