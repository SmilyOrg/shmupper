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
	import ship.behavior.IBehavior;
	import ship.weapon.Weapon;
	//import gs.TweenLite;
	public class Ship extends ElementSprite {
		private static const boundBounce:Number = 1;
		
		//protected var pc:IParticleContainer;
		
		protected var body:Sprite;
		protected var healthBar:Sprite;
		
		public var speed:Number = 1;
		public var maxHealth:Number = 0;
		public var health:Number = 0;
		public var targeted:Boolean = false;
		
		private var _angle:Number = 0;
		private var angleCos:Number = 0;
		private var angleSin:Number = 0;
		
		public var particleAdded:Signal = new Signal(Particle);
		
		protected var weapons:Vector.<Weapon> = new Vector.<Weapon>();
		protected var weaponDisplay:Sprite = new Sprite();
		
		public var hitbox:Rectangle = new Rectangle();
		
		private var behaviors:Vector.<IBehavior> = new Vector.<IBehavior>();
		
		public function Ship(p:Point = null) {
			maxHealth = health;
			
			//this.pc = pc;
			
			super(p);
			
			body = new Sprite();
			body.addChild(weaponDisplay);
			addChild(body);
			
			healthBar = new Sprite();
			healthBar.alpha = 0;
			addChild(healthBar);
			
			//angle = -Math.PI/2;
		}
		public function addBehaviors(b:Vector.<IBehavior>):Ship {
			behaviors = behaviors.concat(b);
			return this;
		}
		public function addBehavior(b:IBehavior):Ship {
			behaviors.push(b);
			return this;
		}
		private function addBullet(e:GenericEvent, b:Bullet):void {
			b.source = this;
			
			var w:Weapon = e.target as Weapon;
			//b.forcePoint(velocity);
			//b.force(velocity.x, velocity.y);
			//b.force(10, 0);
			//b.velocity.offset(10*velocity.x, velocity.y);
			particleAdded.dispatch(b);
		}
		protected function addWeapon(w:Weapon):Weapon {
			//w.rotation = w.angle/Math.PI*180;
			w.angle -= Math.PI/2;
			w.shot.add(addBullet);
			
			weapons.push(w);
			weaponDisplay.addChild(w);
			return w;
		}
		public function shoot():void {
			for (var i:Number = 0; i < weapons.length; i++) {
				var w:Weapon = weapons[i];
				w.shoot();
			}
		}
		public function getDistance(x:Number, y:Number):Number {
			return Math.sqrt(Math.pow(p.x-x, 2)+Math.pow(p.y-y, 2));
		}
		override public function get width():Number {
			return body.width;
		}
		
		public function get angle():Number { return _angle; }
		
		public function set angle(v:Number):void {
			_angle = v;
			body.rotation = v/Math.PI*180;
			angleCos = Math.cos(v);
			angleSin = Math.sin(v);
		}
		override public function update():void {
			v.x = v.y = 0;
			for each (var b:IBehavior in behaviors) {
				b.update(this);
			}
			
			super.update();
			
			for each (var w:Weapon in weapons) {
				w.update();
			}
			
			//body.x = p.x;
			//body.y = p.y;
			healthBar.x = p.x;
			healthBar.y = p.y-body.height/2-15;
		}
		public function damage(delta:Number):void {
			health -= delta;
			draw();
			drawHealthBar();
			TweenNano.to(healthBar, 1, {"alpha": 1, "onComplete": hideHealthBar});
		}
		public function hideHealthBar():void {
			TweenNano.to(healthBar, 1, {"delay": 2, "alpha": 0});
		}
		protected function draw():void {}
		protected function drawHealthBar():void {
			healthBar.graphics.clear();
			healthBar.graphics.lineStyle(1, 0xFFFFFF, 0.2);
			healthBar.graphics.beginFill(0xFFFFFF, 0.1);
			healthBar.graphics.drawRect(-15, -1, 30, 2);
			healthBar.graphics.endFill();
			healthBar.graphics.beginFill(0xFFFFFF, 1);
			healthBar.graphics.drawRect(-15, -1, 30*health/maxHealth, 2);
			healthBar.graphics.endFill();
		}
	}	
}