package behavior {
	import flash.geom.Point;
	import ship.Ship;
	public class WavyBehavior implements IBehavior {
		
		private var origin:Point;
		private var startTime:Number;
		private var amplitudeH:Number;
		private var amplitudeV:Number;
		private var frequencyH:Number;
		private var frequencyV:Number;
		
		public function WavyBehavior(origin:Point, startTime:Number, amplitudeH:Number, amplitudeV:Number, frequencyH:Number, frequencyV:Number) {
			this.origin = origin;
			this.startTime = startTime;
			this.amplitudeH = amplitudeH;
			this.amplitudeV = amplitudeV;
			this.frequencyH = frequencyH;
			this.frequencyV = frequencyV;
		}
		
		public function init(e:Element):void {}
		
		public function update(e:Element, t:Number, dt:Number):void {
			var s:Number = (t-startTime)/(Math.PI*2);
			e.x = origin.x+Math.sin(s*frequencyH)*amplitudeH;
			e.y = origin.y+Math.sin(s*frequencyV)*amplitudeV;
		}
	}
}