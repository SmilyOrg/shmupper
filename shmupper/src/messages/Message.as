package messages {
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	public class Message extends Sprite {
		[Embed(source="C:/WINDOWS/Fonts/Arial.ttf", fontFamily="Arial", unicodeRange="U+0020-U+007E")]
		private var fontString:String;
		
		private var p:Point;
		private var format:TextFormat;
		private var text:TextField;
		private var size:Number;
		private var speed:Number;
		private var duration:Number;
		private var endTime:Number;
		public function Message(position:Point, message:String, size:Number = 12, speed:Number = 1, duration:Number = 1000):void {
			p = position.clone();
			this.size = size;
			this.speed = speed;
			this.duration = duration;
			
			format = new TextFormat("Arial", size, 0xFFFFFF);
			text = new TextField();
			text.defaultTextFormat = format;
			text.autoSize = TextFieldAutoSize.LEFT;
			text.embedFonts = true;
			text.text = message;
			text.selectable = false;
			addChild(text);
			
			endTime = getTimer()+duration*9/10;
		}
		public function update():void {
			p.y -= speed;
			text.x = p.x-text.width/2;
			text.y = p.y-text.height/2;
			alpha = 1-Math.max(0, (getTimer()-endTime)/(duration/10));
			if (alpha < 0.1) {
				parent.removeChild(this);
			}
		}
	}	
}