package actions {
	public class Action {
		public var t:Number;
		public function Action(t:Number) {
			this.t = t;
		}
		
		public function run(sim:Simulation, t:Number, dt:Number):void {}
		
	}

}