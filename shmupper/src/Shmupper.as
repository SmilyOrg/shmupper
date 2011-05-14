package {
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Shmupper extends Sprite {
		
		private var env:Enviroment;
		
		public function Shmupper():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			env = new Enviroment();
			addChild(env);
		}
	}
}