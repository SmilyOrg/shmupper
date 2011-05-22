package  {
	public class ControlState {
		public var up:Boolean = false;
		public var down:Boolean = false;
		public var left:Boolean = false;
		public var right:Boolean = false;
		public var shoot:Boolean = false;
		public var slowdown:Boolean = false;
		
		public function ControlState() {}
		
		public function copyTo(state:ControlState):void {
			state.up = up;
			state.down = down;
			state.left = left;
			state.right = right;
			state.shoot = shoot;
			state.slowdown = slowdown;
		}
		
	}

}