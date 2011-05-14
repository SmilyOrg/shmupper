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
	public class Enviroment extends Sprite implements IParticleContainer {
		private var w:Number = 800;
		private var h:Number = 600;
		
		private var player:Player;
		private var ships:Vector.<Ship>;
		private var shipDisplay:Sprite;
		
		private var buffer:BitmapData;
		private var bufferDisplay:Bitmap;
		
		/** Ship hitbox collision detection */
		private var enemyColl:BitmapData;
		private var enemyCollDisplay:Bitmap;
		
		/** Bullet collision detection */
		private var bulletColl:BitmapData;
		private var bulletCollDisplay:Bitmap;
		
		private var debugData:BitmapData;
		private var debugDisplay:Bitmap;
		
		private var frames:int = 0;
		
		private var start:Particle = null;
		/** Particle addition queue */
		private var queue:Particle = null;
		private var queueSize:int = 0;
		//private var playerParticles:Vector.<Particle>;
		
		private var info:TextField;
		
		private var hitbox:Rectangle = new Rectangle();
		private var hitboxPlayer:Rectangle = new Rectangle();
		
		public function Enviroment() {
			addEventListener(Event.ADDED_TO_STAGE, initStage);
			addEventListener(Event.ENTER_FRAME, run);
		}
		
		private function initStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, initStage);
			
			buffer = new BitmapData(w, h, true, 0x00000000);
			addChild(bufferDisplay = new Bitmap(buffer));
			
			enemyColl = new BitmapData(w, h, true, 0x00000000);
			addChild(enemyCollDisplay = new Bitmap(enemyColl));
			
			bulletColl = new BitmapData(w, h, true, 0x00000000);
			addChild(bulletCollDisplay = new Bitmap(bulletColl));
			
			debugData = new BitmapData(w, h, true, 0x00000000);
			addChild(debugDisplay = new Bitmap(debugData));
			
			//bufferDisplay.alpha = 0.1;
			bulletCollDisplay.alpha = enemyCollDisplay.alpha = debugDisplay.alpha = 0.5;
			
			addChild(shipDisplay = new Sprite());
			
			ships = new Vector.<Ship>();
			
			
			//playerParticles = new Vector.<Particle>();
			
			player = addShip(new Player(stage, new Point(w/2, h/2))) as Player;
			//player.particleAdded.add(addPlayerParticle);
			player.particleAdded.add(addParticle);
			
			//addShip(new EnemyWavy(new Point(w/2, 40)));
			
			addChild(info = new TextField());
			info.defaultTextFormat = new TextFormat("Arial", 10);
			info.autoSize = TextFieldAutoSize.LEFT;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			
			addChild(ConsoleUtil.getInstance());
			//ConsoleUtil.show();
		}
		
		private function keyDown(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.SPACE:
					bulletCollDisplay.alpha = enemyCollDisplay.alpha = debugDisplay.alpha = debugDisplay.alpha == 0.5 ? 0 : 0.5;
			}
		}
		
		private function addShip(s:Ship):Ship {
			s.particleAdded.add(addParticle);
			ships.push(s);
			shipDisplay.addChild(s);
			return s;
		}
		private function removeShip(s:Ship):void {
			ships.splice(ships.indexOf(s), 1);
			shipDisplay.removeChild(s);
		}
		
		public function addParticle(p:Particle):Particle {
			/*
			p.next = start;
			start = p;
			return p;
			*/
			p.next = queue;
			queue = p;
			queueSize++;
			return p;
		}
		/*
		private function addPlayerParticle(p:Particle):Particle {
			playerParticles.push(p);
			return p;
		}
		*/
		
		private function run(e:Event):void {
			var totalTime:int = getTimer();
			
			frames++;
			if (frames%5 == 0) {
				//addShip(new EnemyLinear(new Point(Math.random()*w, 20)));
				addShip(new MediumEnemy(new Point(Math.random()*w, 20)).addBehavior(new LinearBehavior()));
				//addShip(new Enemy(new Point(Math.random()*w, 20), new Point(0, 10)));
			}
			
			enemyColl.fillRect(buffer.rect, 0x00000000);
			bulletColl.fillRect(bulletColl.rect, 0x00000000);
			buffer.fillRect(buffer.rect, 0x00000000);
			debugData.fillRect(buffer.rect, 0x00000000);
			
			var pb:PlayerBullet;
			
			var op:Particle = null;
			var p:Particle = start;
			var particleNum:int = 0;
			var particleTime:int = getTimer();
			while (p) {
				if (p.remove) {
					if (op) {
						p = op.next = p.next;
					} else {
						p = start = p.next;
					}
					continue;
				}
				p.update();
				var image:BitmapData = p.image;
				var imagePos:Point = p.position.add(p.imageOffset);
				buffer.copyPixels(image, image.rect, imagePos, null, null, true);
				pb = p as PlayerBullet;
				if (pb) {
					//drawCollisionLine(p.x, p.y, p.x-p.velocity.x, p.y-p.velocity.y);
					
					var ca:Point = new Point(-p.velocity.y, p.velocity.x);
					ca.normalize(p.radius);
					ca.offset(p.x, p.y);
					
					var cb:Point = new Point(p.velocity.y, -p.velocity.x);
					cb.normalize(p.radius);
					cb.offset(p.x, p.y);
					
					pb.ca.a = ca;
					pb.ca.b = ca.subtract(p.velocity);
					pb.cb.a = cb;
					pb.cb.b = cb.subtract(p.velocity);
					
					drawLine(bulletColl, pb.ca.a.x, pb.ca.a.y, pb.ca.b.x, pb.ca.b.y);
					drawLine(bulletColl, pb.cb.a.x, pb.cb.a.y, pb.cb.b.x, pb.cb.b.y);
					
					//drawCollisionLine(p.x, p.y, p.x-p.velocity.x, p.y-p.velocity.y);
					//drawCollisionLine(ca.x, ca.y, ca.x-p.velocity.x, ca.y-p.velocity.y);
					//drawCollisionLine(cb.x, cb.y, cb.x-p.velocity.x, cb.y-p.velocity.y);
				} else {
					enemyColl.copyPixels(image, image.rect, imagePos, null, null, true);
				}
				//if (p.x >= 0 && p.y >= 0 && p.x < w && p.y < h) {
				if (!(p.x >= 0 && p.y >= 0 && p.x < w && p.y < h)) {
					// Mark the particle for removal the next frame, since e.g. bullets can still hurt when going off screen, but not when they are off screen
					p.remove = true;
					/*
					if (pb) {
						playerParticles.splice(playerParticles.indexOf(p), 1);
					}
					*/
				}
				op = p;
				p = p.next;
				particleNum++;
			}
			particleTime = getTimer()-particleTime;
			
			//player.velocity.x = player.velocity.y = 0;
			//player.speed = control.slowdown ? 1 : 4;
			//player.speed = control.slowdown ? 1 : 20;
			
			//player.drag = control.slowdown ? player.slowdownDrag : player.normalDrag;
			//player.angle += 0.1;
			//player.shoot();
			//player.facePosition(new Point(mouseX, mouseY));
			
			var shipTime:int = getTimer();
			//for (var i:int = 0; i < ships.length; i++) {
			for (var i:int = ships.length-1; i >= 0; i--) {
				var s:Ship = ships[i];
				//s.x = mouseX;
				//s.y = mouseY;
				s.update();
				if (s is Enemy) {
					var m:Enemy = s as Enemy;
					m.ai(player);
					if (m.y > h) {
						removeShip(m);
						//i--;
						//i++;
						//if (ships.length == 0) break;
						continue;
					}
				}
				
				hitbox.x = s.x+s.hitbox.x;
				hitbox.y = s.y+s.hitbox.y;
				hitbox.width = s.hitbox.width;
				hitbox.height = s.hitbox.height;
				
				var hit:Boolean;
				if (s is Player) {
					hitboxPlayer.x = hitbox.x;
					hitboxPlayer.y = hitbox.y;
					hitboxPlayer.width = hitbox.width;
					hitboxPlayer.height = hitbox.height;
					
					//hit = buffer.hitTest(buffer.rect.topLeft, 0xFF, hitbox);
					//buffer.fillRect(hitbox, hit ? 0xFF000000 : 0xFF00FF00);
					//bulletColl.fillRect(hitbox, 0xFFFF0000);
					//if (hit) buffer.fillRect(buffer.rect, 0xFFFF0000);
					
					
					hit = enemyColl.hitTest(enemyColl.rect.topLeft, 127, hitbox);
					//hitboxColl.fillRect(hitbox, hit ? 0xFF000000 : 0xFF00FF00);
					debugData.fillRect(hitbox, hit ? 0xFF000000 : 0xFF00FF00);
					//if (hit) hitboxColl.fillRect(buffer.rect, 0xFFFF0000);
					if (hit) debugData.fillRect(debugData.rect, 0xFFFF0000);
				} else {
					//buffer.fillRect(hitbox, removeCollidedBullet(s) ? 0xFF000000 : 0xFF00FF00);
					
					///*
					//buffer.fillRect(hitbox, hit ? 0xFF000000 : 0xFF00FF00);
					
					hit = bulletColl.hitTest(bulletColl.rect.topLeft, 127, hitbox);
					enemyColl.fillRect(hitbox, hit ? 0xFF000000 : 0xFF00FF00);
					
					//if (hitbox.intersects(hitboxPlayer)) {
						//buffer.fillRect(buffer.rect, 0xFFFF0000);
						//hitboxColl.fillRect(buffer.rect, 0xFFFF0000);
						//debugData.fillRect(debugData.rect, 0xFFFF0000);
					//}
					if (hit) {
						if (!(s is EnemyWavy)) {
							pb = removeCollidedBullet(s);
							if (pb) {
								removeShip(s);
								//i--;
								//i++;
								//if (ships.length == 0) break;
							} else {
								debugData.fillRect(hitbox, 0xFFFF0000);
							}
						}
					}
					//*/
				}
			}
			shipTime = getTimer()-shipTime;
			
			totalTime = getTimer()-totalTime;
			
			///*
			info.text = 
				"Particles: "+particleNum
				//+"\nPlayer particles: "+playerParticles.length
				+"\n"+Math.round(particleNum/particleTime)
				+"\nShips: "+ships.length
				+"\nParticles in queue: "+queueSize
				+"\n"
				+"\nParticles\t"+particleTime+"ms"
				+"\nShips\t\t"+shipTime+"ms"
				+"\nTotal\t\t"+totalTime+"ms"
			;
			//*/
			
			flushParticleQueue();
		}
		private function flushParticleQueue():void {
			var p:Particle = queue;
			var t:Particle = null;
			while (p) {
				t = p.next;
				p.next = start;
				start = p;
				p = t;
			}
			queue = null;
			queueSize = 0;
		}
		private function removeCollidedBullet(s:Ship):PlayerBullet {
			var r:Rectangle = s.hitbox.clone();
			r.offsetPoint(s.position);
			
			var op:Particle = null;
			var p:Particle = start;
			while (p) {
				var pb:PlayerBullet = p as PlayerBullet;
				if (pb) {
					if (lineRectIntersection(pb.ca.a, pb.ca.b, r) || lineRectIntersection(pb.cb.a, pb.cb.b, r)) {
						// Remove particle
						if (op) {
							op.next = p.next;
						} else {
							start = p.next;
						}
						return pb;
					}
				}
				op = p;
				p = p.next;
			}
			
			return null;
		}
		private function lineRectIntersection(a:Point, b:Point, r:Rectangle):Boolean {
			if (lineIntersection(a.x, a.y, b.x, b.y, r.left, r.top, r.right, r.top)) return true;
			if (lineIntersection(a.x, a.y, b.x, b.y, r.right, r.top, r.right, r.bottom)) return true;
			if (lineIntersection(a.x, a.y, b.x, b.y, r.right, r.bottom, r.left, r.bottom)) return true;
			if (lineIntersection(a.x, a.y, b.x, b.y, r.left, r.bottom, r.left, r.top)) return true;
			return false;
		}
		private function lineIntersection(x1:Number, y1:Number, x2:Number, y2:Number, x3:Number, y3:Number, x4:Number, y4:Number):Boolean {
			//drawLine(debugData, x1, y1, x2, y2);
			//drawLine(debugData, x3, y3, x4, y4);
			var div:Number = ((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
			var ua:Number = ((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3))/div;
			var ub:Number = ((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3))/div;
			if (((ua >= 0) && (ua <= 1)) && ((ub >= 0) && (ub <= 1))) {
				return true;
			}
			return false;
		}
		private function drawLine(bd:BitmapData, x0:Number, y0:Number, x1:Number, y1:Number):void {
			var t:Number;
			var steep:Boolean = Math.abs(y1-y0) > Math.abs(x1-x0);
			if (steep) {
				t = x0; x0 = y0; y0 = t;
				t = x1; x1 = y1; y1 = t;
			}
			if (x0 > x1) {
				t = x0;	x0 = x1; x1 = t;
				t = y0;	y0 = y1; y1 = t;
			}
			var dx:int = x1-x0;
			var dy:int = Math.abs(y1-y0);
			var error:int = dx/2;
			var y:Number = y0;
			var ystep:int = y0 < y1 ? 1 : -1;
			for (var x:Number = x0; x <= x1; x++) {
				if (steep) bd.setPixel32(y, x, 0xFFFF0000); else bd.setPixel32(x, y, 0xFFFF0000);
				error -= dy;
				if (error < 0) {
					y += ystep;
					error += dx;
				}
			}
		}
		
		private function clamp(value:Number, min:Number, max:Number):Number {
			if (value <= min) return min;
			if (value >= max) return max;
			return value;
		}
		
	}

}