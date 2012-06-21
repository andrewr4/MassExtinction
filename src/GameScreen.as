package  
{
	import flash.display.*;
	/**
	 * ...
	 * @author Andrew Reynolds
	 */
	public class GameScreen extends Sprite
	{
		//background
		[Embed(source="GameScreen.jpg")]
        protected var GS:Class;
		
		//height and width of screen
		protected const SCREEN_WIDTH:int = 640;
        protected const SCREEN_HEIGHT:int = 480;
		
		protected var gs:Bitmap = new GS();
		
		public function GameScreen() 
		{
			graphics.lineStyle(1, 0x000000);
			graphics.beginFill(0x000000, 1);
            graphics.drawRect(0, 0, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1);
			
			graphics.drawRect(0, 300, SCREEN_WIDTH - 1, 180 - 1);
			
			addChild(gs);
		}
		
	}

}