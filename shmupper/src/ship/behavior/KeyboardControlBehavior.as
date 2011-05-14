package ship.behavior {
	import flash.display.InteractiveObject;
	import flash.events.IEventDispatcher;
	import ship.Player;
	import ship.Ship;
	public class KeyboardControlBehavior implements IBehavior {
		private var control:Control;
		public function KeyboardControlBehavior(dispatcher:InteractiveObject) {
			control = new Control(dispatcher);
		}
		public function update(s:Ship):void {
			var player:Player = Player(s);
			player.speed = control.slowdown ? 0.05 : 0.3;
			if (control.up) player.moveUp();
			if (control.down) player.moveDown();
			if (control.left) player.moveLeft();
			if (control.right) player.moveRight();
			if (control.shoot) player.shoot();
		}
	}
}