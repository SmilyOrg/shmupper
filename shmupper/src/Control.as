package  {
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	public class Control extends ControlState {
		private var actual:ControlState = new ControlState();
		
		public function Control(dispatcher:InteractiveObject) {
			dispatcher.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			dispatcher.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			dispatcher.addEventListener(MouseEvent.MOUSE_DOWN, shootDown);
			dispatcher.addEventListener(MouseEvent.MOUSE_UP, shootUp);
		}
		
		public function actualize():void {
			actual.copyTo(this);
		}
		
		private function shootDown(e:MouseEvent):void {
			actual.shoot = shoot = true;
		}
		private function shootUp(e:MouseEvent):void {
			actual.shoot = false;
		}
		private function keyDown(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.UP:		case 87:	actual.up		= up		= true; break; // W
				case Keyboard.DOWN:		case 83:	actual.down		= down		= true; break; // S
				case Keyboard.LEFT:		case 65:	actual.left		= left		= true; break; // A
				case Keyboard.RIGHT:	case 68:	actual.right	= right		= true; break; // D
				case Keyboard.SPACE:
				case Keyboard.CONTROL:				actual.shoot	= shoot	= true; break;
				case Keyboard.SHIFT:				actual.slowdown	= slowdown	= true; break;
			}
		}
		private function keyUp(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.UP:		case 87:	actual.up		= false; break; // W
				case Keyboard.DOWN:		case 83:	actual.down		= false; break; // S
				case Keyboard.LEFT:		case 65:	actual.left		= false; break; // A
				case Keyboard.RIGHT:	case 68:	actual.right	= false; break; // D
				case Keyboard.SPACE:
				case Keyboard.CONTROL:				actual.shoot	= false; break;
				case Keyboard.SHIFT:				actual.slowdown	= false; break;
			}
		}
	}
}