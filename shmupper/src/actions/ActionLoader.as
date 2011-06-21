package actions {
	import actions.ActionStream;
	import no.doomsday.console.ConsoleUtil;
	public class ActionLoader {
		
		public function ActionLoader() { }
		
		public function append(actionFile:XML, actionStream:ActionStream):void {
			for each (var spawn:XML in actionFile.actions.spawn) {
				actionStream.add(new SpawnAction(Number(spawn.@t)*1000, spawn.@x));
			}
		}
		
	}

}