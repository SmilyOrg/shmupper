package actions {
	public class ActionStream {
		public var actionList:Vector.<Action> = new Vector.<Action>();
		public function ActionStream() {
		}
		public function add(action:Action):void {
			actionList.push(action);
		}
		public function update(sim:Simulation, t:Number, dt:Number):void {
			for (var i:int = 0; i < actionList.length; i++) {
				var a:Action = actionList[i];
				if (a.t <= t) {
					actionList.splice(i, 1);
					i--;
					
					a.run(sim, t, dt);
				}
			}
		}
	}

}