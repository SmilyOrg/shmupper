package  {
	import behavior.IBehavior;
	import flash.geom.Point;
	public class BehavioralElement extends Element {
		
		protected var behaviors:Vector.<IBehavior> = new Vector.<IBehavior>();
		
		public function BehavioralElement(p:Point = null) {
			super(p);
		}
		
		public function addBehaviors(newBehaviors:Vector.<IBehavior>):void {
			for (var i:int = 0; i < newBehaviors.length; i++) {
				addBehavior(newBehaviors[i]);
			}
		}
		
		public function addBehavior(b:IBehavior):void {
			b.init(this);
			behaviors[behaviors.length] = b;
		}
		
		override public function update(t:Number, dt:Number):void {
			for each (var b:IBehavior in behaviors) {
				b.update(this, t, dt);
			}
			
			super.update(t, dt);
		}
		
	}

}