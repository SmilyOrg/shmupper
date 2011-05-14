package messages {
	import flash.events.Event;
	import flash.geom.Point;
	public class MessageEvent extends Event {
		public static const SHOW:String = "show";
		
		public var position:Point;
		public var message:String;
		public var size:Number;
		public var speed:Number;
		public var duration:Number;
		public function MessageEvent(type:String, bubbles:Boolean, cancelable:Boolean, position:Point, message:String, size:Number = 12, speed:Number = 1, duration:Number = 1000):void {
			this.position = position;
			this.message = message;
			this.size = size;
			this.speed = speed;
			this.duration = duration;
			super(type, bubbles, cancelable);
		}
	}	
}