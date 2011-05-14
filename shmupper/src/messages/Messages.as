package messages {
	import flash.display.Sprite;
	import flash.geom.Point;
	public class Messages extends Sprite {
		public function Messages():void {
			
		}
		public function show(position:Point, message:String, size:Number = 12, speed:Number = 1, duration:Number = 1000):void {
			var m:Message = new Message(position, message, size, speed, duration);
			addChild(m);
		}
		public function update():void {
			for (var i:Number = 0; i < numChildren; i++) {
				var m:Message = getChildAt(i) as Message;
				m.update();
			}
		}
	}	
}