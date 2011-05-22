package behavior {
	import flash.display.InteractiveObject;
	import flash.events.IEventDispatcher;
	import ship.Player;
	import ship.Ship;
	public class KeyboardControlBehavior implements IBehavior {
		private var control:Control;
		public function KeyboardControlBehavior(dispatcher:InteractiveObject) {
			control = new Control(dispatcher);
		}
		public function init(e:Element):void {}
		public function update(e:Element, t:Number, dt:Number):void {
			var s:Ship = Ship(e);
			s.speed = control.slowdown ? 0.1 : 0.25;
			
			var amount:Number = s.speed*dt;
			
			if (control.left) {
				s.x -= amount;
			}
			if (control.right) {
				s.x += amount;
			}
			if (control.up) {
				s.y -= amount;
			}
			if (control.down) {
				s.y += amount;
			}
			
			if (control.shoot) {
				s.shoot();
			}
			
			control.actualize();
			
			//if (control.up) player.moveUp();
			//if (control.down) player.moveDown();
			//if (control.left) player.moveLeft();
			//if (control.right) player.moveRight();
			//if (control.shoot) player.shoot();
		}
	}
}