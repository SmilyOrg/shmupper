package {
	import actions.ActionLoader;
	import behavior.IBehavior;
	import behavior.LinearBehavior;
	import bullet.Bullet;
	import elements.LinearElement;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import no.doomsday.console.ConsoleUtil;
	import rendering.Renderer;
	
	public class Shmupper extends Sprite {
		[Embed(source='assets/level.xml', mimeType='application/octet-stream')]
		private var LevelFile:Class;
		private var levelFile:XML;
		
		private var sim:Simulation;
		private var renderer:Renderer;
		
		private var actionLoader:ActionLoader = new ActionLoader();
		
		private var time:Number = 0;
		
		private var slowdownSimulator:Timer = new Timer(3000);
		private var slowdownFrameRate:Number = 15;
		private var originalFrameRate:Number;
		
		public function Shmupper():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var levelBytes:ByteArray = new LevelFile();
			levelFile = XML(levelBytes.readUTFBytes(levelBytes.length));
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			renderer = new Renderer(800, 600);
			addChild(renderer);
			
			sim = new Simulation();
			addChild(sim);
			
			actionLoader.append(levelFile, sim.actionStream);
			
			addChild(ConsoleUtil.getInstance());
			
			
			//sim.addParticle(new Bullet(new LinearElement(new Point(400, 100), 0, new Point(Math.sin(time*0.1)*10, 50))));
			
			//for (var i:int = 0; i < 10; i++) {
				//sim.addParticle(new Bullet(new LinearElement(new Point(100+i*20, 100), i/2-2, new Point(Math.sin(time*0.1)*10, 50+i*10))));
			//}
			
			//for (var i:int = 0; i < 50; i++) {
				//sim.addParticle(new Bullet(new <IBehavior>[new LinearBehavior(new Point(100+i*10, 500), i, new Point(0, 0))]));
			//}
			
			addEventListener(Event.ENTER_FRAME, run);
			
			slowdownSimulator.addEventListener(TimerEvent.TIMER, toggleSlowdown);
			originalFrameRate = stage.frameRate;
			
			ConsoleUtil.createCommand("slowdown", toggleSlowdownSimulation);
			ConsoleUtil.createCommand("deltaTime", changeDeltaTime);
			
			//setTimeout(function():void { removeEventListener(Event.ENTER_FRAME, run); }, 1000);
		}
		
		private function changeDeltaTime(dt:Number):void {
			sim.dt = dt;
		}
		
		private function toggleSlowdown(e:TimerEvent):void {
			stage.frameRate = stage.frameRate == originalFrameRate ? slowdownFrameRate : originalFrameRate;
		}
		
		private function toggleSlowdownSimulation():void {
			if (slowdownSimulator.running) {
				slowdownSimulator.stop();
				stage.frameRate = originalFrameRate;
				ConsoleUtil.print("Slowdown simulation stopped");
			} else {
				slowdownSimulator.start();
				ConsoleUtil.print("Slowdown simulation started");
			}
		}
		
		private function run(e:Event):void {
			//sim.addParticle(new Bullet(new Point(400, 500), new Point((Math.random()-0.5)*0.1, -0.05)));
			//sim.addParticle(new Bullet(new Point(400, 500), new Point(0, -50)));
			//sim.addParticle(new Bullet(new Point(mouseX, mouseY), new Point((Math.random()-0.5)*50, -50)));
			//sim.addParticle(new Bullet(new Point(mouseX, mouseY), new Point(Math.sin(time*0.1)*10, 50)));
			//sim.addParticle(new Bullet(new SimpleElement(new Point(mouseX, mouseY), new Point(Math.sin(time*0.1)*10, 50))));
			
			var currentTime:Number = getTimer();
			
			//sim.addParticle(new Bullet(new LinearElement(new Point(mouseX, mouseY), currentTime+Math.random(), new Point(Math.sin(time*0.1)*10, 50))));
			
			//sim.addParticle(new Bullet(new <IBehavior>[new LinearBehavior(new Point(mouseX, mouseY), currentTime+Math.random(), new Point(Math.sin(time*0.1)*10, 50))]));
			
			//if (time%60 == 0) sim.addParticle(new Bullet(new <IBehavior>[new LinearBehavior(new Point(mouseX, mouseY), currentTime, new Point(0, 0))]));
			//sim.addParticle(new Bullet(new <IBehavior>[new LinearBehavior(new Point(mouseX, mouseY), currentTime, new Point(0, -0.2))]));
			
			//sim.addParticle(new Bullet());
			
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