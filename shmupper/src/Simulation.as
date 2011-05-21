package  {
	import bullet.Bullet;
	import bullet.PlayerBullet;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import no.doomsday.console.ConsoleUtil;
	import ship.behavior.LinearBehavior;
	import ship.enemy.Enemy;
	import ship.enemy.EnemyLinear;
	import ship.enemy.EnemyWavy;
	import ship.enemy.MediumEnemy;
	import ship.Player;
	import ship.Ship;
	public class Simulation extends Sprite implements IParticleContainer {
		private var w:Number = 800;
		private var h:Number = 600;
		
		private var t:Number = 0;
		public var dt:Number = 1/16;
		//public var dt:Number = 1/2;
		
		private var player:Player;
		private var ships:Vector.<Ship>;
		
		public var particles:Particle = null;
		/** Particle addition queue */
		private var queue:Particle = null;
		private var queueSize:int = 0;
		
		private var frames:int = 0;
		
		private var info:TextField;
		
		private var currentTime:Number;
		private var accumulator:Number;
		
		public function Simulation() {
			addEventListener(Event.ADDED_TO_STAGE, initStage);
			reset();
		}
		
		private function initStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, initStage);
			
			ships = new Vector.<Ship>();
			
			player = addShip(new Player(stage, new Point(w/2, h/2))) as Player;
			//player.particleAdded.add(addParticle);
			
			//addShip(new EnemyWavy(new Point(w/2, 40)));
			
			addChild(info = new TextField());
			info.defaultTextFormat = new TextFormat("Arial", 10);
			info.autoSize = TextFieldAutoSize.LEFT;
			
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			
			//addParticle(new Bullet(new Point(400, 500), new Point(0, -0.01)));
			
			//ConsoleUtil.show();
		}
		
		public function get stepProgress():Number {
			return accumulator/dt;
		}
		
		private function reset():void {
			currentTime = getTimer()/1000;
			accumulator = 0;
		}
		
		private function addShip(s:Ship):Ship {
			ships.push(s);
			return s;
		}
		private function removeShip(s:Ship):void {
			ships.splice(ships.indexOf(s), 1);
		}
		
		public function addParticle(p:Particle):Particle {
			p.next = queue;
			queue = p;
			queueSize++;
			return p;
		}
		private function flushParticleQueue():void {
			var p:Particle = queue;
			var t:Particle = null;
			while (p) {
				t = p.next;
				p.next = particles;
				particles = p;
				p = t;
			}
			queue = null;
			queueSize = 0;
		}
		
		public function run():void {
			var newTime:Number = getTimer()/1000;
			var frameTime:Number = newTime-currentTime;
			currentTime = newTime;
			
			accumulator += frameTime;
			
			flushParticleQueue();
			
			//nextState();
			
			while (accumulator > dt) {
				step(t, dt);
				accumulator -= dt;
				t += dt;
			}
			
		}
		
		private function nextState():void {
			var p:Particle = particles;
			while (p) {
				p.nextState();
				p = p.next;
			}
		}
		
		private function step(t:Number, dt:Number):void {
			var op:Particle = null;
			var p:Particle = particles;
			while (p) {
				if (p.remove) {
					if (op) {
						p = op.next = p.next;
					} else {
						p = particles = p.next;
					}
					continue;
				}
				p.nextState();
				p.update(t, dt);
				
				var pos:Point = p.position;
				if (!(pos.x >= 0 && pos.y >= 0 && pos.x < w && pos.y < h)) {
					// Mark the particle for removal the next frame, since e.g. bullets can still hurt when going off screen, but not when they are off screen
					p.remove = true;
				}
				
				op = p;
				p = p.next;
			}
		}
		
	}

}