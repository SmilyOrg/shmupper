package  {
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	public class Control {
		public var up:Boolean = false;
		public var down:Boolean = false;
		public var left:Boolean = false;
		public var right:Boolean = false;
		public var shoot:Boolean = false;
		public var slowdown:Boolean = false;
		
		public function Control(dispatcher:InteractiveObject) {
			dispatcher.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			dispatcher.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			dispatcher.addEventListener(MouseEvent.MOUSE_DOWN, shootDown);
			dispatcher.addEventListener(MouseEvent.MOUSE_UP, shootUp);
		}
		
		private function shootDown(e:MouseEvent):void {
			shoot = true;
		}
		private function shootUp(e:MouseEvent):void {
			shoot = false;
		}
		private function keyDown(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.UP:		case 87:	up			= true; break; // W
				case Keyboard.DOWN:		case 83:	down		= true; break; // S
				case Keyboard.LEFT:		case 65:	left		= true; break; // A
				case Keyboard.RIGHT:	case 68:	right		= true; break; // D
				case Keyboard.CONTROL:				shoot		= true; break;
				case Keyboard.SHIFT:				slowdown	= true; break;
			}
		}
		private function keyUp(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.UP:		case 87:	up			= false; break; // W
				case Keyboard.DOWN:		case 83:	down		= false; break; // S
				case Keyboard.LEFT:		case 65:	left		= false; break; // A
				case Keyboard.RIGHT:	case 68:	right		= false; break; // D
				case Keyboard.CONTROL:				shoot		= false; break;
				case Keyboard.SHIFT:				slowdown	= false; break;
			}
		}
	}
}