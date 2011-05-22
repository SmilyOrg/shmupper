package bullet {
	import behavior.IBehavior;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import ship.Ship;
	public class Bullet extends Particle {
		[Embed(source='../assets/bullets/12px-blue-round.png')]
		private static var BulletImage:Class;
		private static var bulletImage:Bitmap;
		
		[Embed(source='../assets/sfx/Shoot.mp3')]
		private static var ShootSound:Class;
		
		private var shootSound:Sound;
		//private var trans:SoundTransform = new SoundTransform(0.25);
		
		public var source:Ship;
		
		public function Bullet(behaviors:Vector.<IBehavior> = null) {
			if (!bulletImage) bulletImage = new BulletImage();
			radius = 6;
			
			super(bulletImage.bitmapData, new Point(-bulletImage.width/2, -bulletImage.height/2));
			
			if (behaviors) addBehaviors(behaviors);
			
		}
		
	}

}