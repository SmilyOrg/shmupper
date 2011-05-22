package ship.weapon {
	import behavior.IBehavior;
	import behavior.LinearBehavior;
	import bullet.Bullet;
	import flash.geom.Point;
	import no.doomsday.console.ConsoleUtil;
	import ship.Ship;
	public class Cannon implements IWeapon {
		
		private var lastTime:Number = 0;
		private var delay:Number;
		private var shootNextUpdate:Boolean = false;
		
		private var accumulator:Number = 0;
		private var velocity:Point;
		
		public function Cannon(delay:Number, velocity:Point) {
			this.delay = delay;
			this.velocity = velocity;
		}
		
		public function shoot():void {
			shootNextUpdate = true;
		}
		
		public function update(s:Ship, t:Number, dt:Number):Vector.<IElement> {
			var timeOffset:Number = -accumulator;
			
			accumulator += dt;
			
			if (!shootNextUpdate) {
				if (accumulator > 0) accumulator = 0;
			} else {
				shootNextUpdate = false;
				
				var elements:Vector.<IElement> = new Vector.<IElement>();
				while (accumulator > 0) {
					var b:Bullet = new Bullet(new <IBehavior>[new LinearBehavior(s.getMergedState(timeOffset/dt).p, t+timeOffset, velocity)]);
					elements[elements.length] = b;
					
					accumulator -= delay;
					timeOffset += delay;
				}
				return elements;
				
				/*if (lastTime+delay <= t) {
					lastTime = t;
					
					var b:Bullet = new Bullet(new <IBehavior>[new LinearBehavior(s.position.clone(), t, new Point(0, -0.1))]);
					
					var elements:Vector.<IElement> = new Vector.<IElement>();
					elements[0] = b;
					return elements;
				}
				*/
			}
			return null;
		}
	}
}