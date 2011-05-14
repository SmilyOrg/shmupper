/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package inputserver;

import java.awt.MouseInfo;
import java.awt.Point;
import java.util.Locale;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import net.java.games.input.Component;
import net.java.games.input.Controller;
import net.java.games.input.ControllerEnvironment;
import net.java.games.input.Event;
import net.java.games.input.EventQueue;
import net.java.games.input.Rumbler;

/**
 *
 * @author Miha
 */
public class InputServer {

	private Controller c;
	private Controller mouse;

	public InputServer() {
        Controller[] controllers = ControllerEnvironment.getDefaultEnvironment().getControllers();
		System.out.println("Controllers: "+controllers.length);
		
		for (int i = 0; i < controllers.length; i++) {
			Controller controller = controllers[i];
			System.out.println(i+" "+controller.getName()+" "+controller.getControllers().length+" "+controller.getComponents().length+" "+controller.getType());
			if (controller.getType() == Controller.Type.GAMEPAD) {
				c = controller;
			}
		}

		mouse = controllers[2];

		Rumbler[] rumblers = c.getRumblers();
		System.out.println("Rumblers: "+rumblers.length);
		Locale.setDefault(Locale.ENGLISH);
		Scanner s = new Scanner(System.in);

		//EventQueue meq = mouse.getEventQueue();
		EventQueue eq = c.getEventQueue();
		Event event = new Event();

		while (true) {
			Point p = MouseInfo.getPointerInfo().getLocation();
			float tx = (float) p.x / 1680;
			float ty = (float) p.y / 1050;
			rumblers[2].rumble(tx);
			rumblers[3].rumble(ty);
			System.out.println(tx+" "+ty);

			//System.out.println("Mouse: "+mouse.getName()+" "+mouse.poll());
			/*
			Component[] components = mouse.getComponents();
			for (int i = 0; i < components.length; i++) {
				Component component = components[i];
				System.out.println(component.getName()+" "+component.getPollData());
			}
			//*/
			/*
			while (meq.getNextEvent(event)) {
				System.out.println(event.getNanos()+"\t"+event.getComponent().getName()+"\t"+event.getValue());
			}
			//*/
			/*
			int r = s.nextInt();
			if (r < 0) break;
			if (r >= rumblers.length) continue;
			float f = s.nextFloat();
			rumblers[r].rumble(f);
			 */
			/*
			int r = s.nextInt();
			if (r < 0) break;
			if (r >= rumblers.length) continue;
			float f = s.nextFloat();
			rumblers[r].rumble(f);
			 */

			/*
			c.poll();
			while (eq.getNextEvent(event)) {
				System.out.println(event.getNanos()+"\t"+event.getComponent().getName()+"\t"+event.getValue());
			}
			//*/

			try {
				Thread.sleep(30);
			} catch (InterruptedException ex) {
				Logger.getLogger(InputServer.class.getName()).log(Level.SEVERE, null, ex);
			}
		}
		
		/*
		Component[] components = c.getComponents();
		for (int i = 0; i < components.length; i++) {
			Component component = components[i];
			System.out.println(component.getName()+" "+component.isAnalog());
		}
		*/
	}

}
