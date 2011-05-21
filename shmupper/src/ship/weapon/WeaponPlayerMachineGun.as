package ship.weapon {
	import bullet.Bullet;
	import bullet.PlayerBullet;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import org.osflash.signals.events.GenericEvent;
	import ship.Ship;
	import no.doomsday.console.ConsoleUtil;
	public class WeaponPlayerMachineGun extends Weapon {
		//private var pc:IParticleContainer;
		private var speed:Number = 5;
		private var position:Number;
		public function WeaponPlayerMachineGun(x:Number = 0, y:Number = 0, angle:Number = 0, delay:Number = NaN, speed:Number = NaN):void {
			super(delay);
			if (!isNaN(speed)) this.speed = speed; else speed = this.speed;
			
			//this.pc = pc;
			//this.ship = ship;
			this.angle = angle;
			
			position = x;
			body.x = x;
			body.y = y;
			
			//position = x;
			//this.y = y;
			draw();
		}
		private function draw():void {
			//body.graphics.beginFill(0xD4D4D4);
			body.graphics.lineStyle(1, 0x000000, 0.5);
			body.graphics.drawRect(0, -3, 7, 6);
			//body.graphics.moveTo(0, -2);
			//body.graphics.lineTo(7, -1);
			//body.graphics.lineTo(7, 1);
			//body.graphics.lineTo(0, 2);
		}
		/*
		override public function update():void {
			super.update();
			
			body.x += (position-body.x)/2;
		}
		*/
		override public function upgrade():void {
			if (delay > 20) {
				delay -= 20;
			} else if (speed < 100) {
				speed *= 1.1;
			}
		}
		override public function shoot():void {
			if (!cooling) {
				var spawnPoint:Point = body.localToGlobal(new Point());
				var offsetPoint:Point = body.localToGlobal(new Point(speed, 0));
				//var b:Bullet = new PlayerBullet(spawnPoint, offsetPoint.subtract(spawnPoint));
				var b:Bullet = new PlayerBullet(new SimpleElement(spawnPoint, offsetPoint.subtract(spawnPoint)));
				//var b:Bullet = new Bullet(new Point(), new Point(1, 0));
				//var b:Bullet = new Bullet(new Point(body.x, body.y), new Point(1, 0));
				shot.dispatch(new GenericEvent(), b);
				//ship.addBullet(b);
				//pc.addParticle(b);
				cooling = true;
				//body.x -= 20;
			}
		}
	}	
}