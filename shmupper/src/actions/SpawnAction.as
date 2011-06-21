package actions {
	import behavior.LinearBehavior;
	import flash.geom.Point;
	import ship.Ship;
	public class SpawnAction extends Action {
		public var x:Number;
		public function SpawnAction(t:Number, x:Number) {
			super(t);
			this.x = x;
		}
		override public function run(sim:Simulation, t:Number, dt:Number):void {
			super.run(sim, t, dt);
			
			var s:Ship = new Ship();
			s.addBehavior(new LinearBehavior(new Point(sim.enviromentWidth*x, 0), t, new Point(0, 0.3)));
			sim.addShip(s);
		}
	}

}