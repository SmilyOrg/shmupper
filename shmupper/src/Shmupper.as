package {
	import bullet.Bullet;
	import elements.LinearElement;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import no.doomsday.console.ConsoleUtil;
	
	public class Shmupper extends Sprite {
		
		private var sim:Simulation;
		private var renderer:Renderer;
		
		private var time:Number = 0;
		
		public function Shmupper():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			renderer = new Renderer(800, 600);
			addChild(renderer);
			
			sim = new Simulation();
			addChild(sim);
			
			addChild(ConsoleUtil.getInstance());
			
			
			//sim.addParticle(new Bullet(new LinearElement(new Point(400, 100), 0, new Point(Math.sin(time*0.1)*10, 50))));
			
			//for (var i:int = 0; i < 10; i++) {
				//sim.addParticle(new Bullet(new LinearElement(new Point(100+i*20, 100), i/2-2, new Point(Math.sin(time*0.1)*10, 50+i*10))));
			//}
			
			addEventListener(Event.ENTER_FRAME, run);
		}
		
		private function run(e:Event):void {
			//sim.addParticle(new Bullet(new Point(400, 500), new Point((Math.random()-0.5)*0.1, -0.05)));
			//sim.addParticle(new Bullet(new Point(400, 500), new Point(0, -50)));
			//sim.addParticle(new Bullet(new Point(mouseX, mouseY), new Point((Math.random()-0.5)*50, -50)));
			//sim.addParticle(new Bullet(new Point(mouseX, mouseY), new Point(Math.sin(time*0.1)*10, 50)));
			//sim.addParticle(new Bullet(new SimpleElement(new Point(mouseX, mouseY), new Point(Math.sin(time*0.1)*10, 50))));
			
			var currentTime:Number = getTimer()/1000;
			
			sim.addParticle(new Bullet(new LinearElement(new Point(mouseX, mouseY), currentTime+Math.random(), new Point(Math.sin(time*0.1)*10, 50))));
			
			//for (var i:int = 0; i < 20; i++) {
				//sim.addParticle(new Bullet(new LinearElement(new Point(mouseX+(Math.random()-0.5)*20, mouseY+(Math.random()-0.5)*20), currentTime+Math.random(), new Point(Math.sin(time*0.2)*50, 50))));
				//sim.addParticle(new Bullet(new LinearElement(new Point(mouseX+(Math.random()-0.5)*20, mouseY+(Math.random()-0.5)*20), currentTime+Math.random(), new Point((Math.random()-0.5)*40, 50))));
			//}
			
			sim.run();
			renderer.render(sim);
			
			time++;
		}
	}
}