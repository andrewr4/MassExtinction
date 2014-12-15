package au.com.aggressivelypassive.mass_extinction.menus
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.text.TextField;
	import flash.display.Bitmap;
	import au.com.aggressivelypassive.mass_extinction.*;
	
	/**
	 * ...
	 * @author Andrew Reynolds
	 */
	public class MainMenu extends Sprite
	{
		public var startGame:TextField = new TextField();
		public var startStats:TextField = new TextField();
				
		private var main:Main;
		/*adds fields to main menu to allow options to be selected*/
		public function MainMenu(m:Main)
		{
			main = m;
			
			startGame.text = "Start Game";
			startGame.x = main.SCREEN_WIDTH * 8/10;
			startGame.y = main.SCREEN_HEIGHT/2;
			startGame.height = 25;
			startGame.width = 150;
			addChild(startGame);
			
			startStats.text = "Open Stats";
			startStats.x = main.SCREEN_WIDTH/2;
			startStats.y = main.SCREEN_HEIGHT * 8/10;
			startStats.height = 25;
			startStats.width = 150;
			//addChild(startStats);
			
			//main.addEventListener(Event.ENTER_FRAME, updateMenu);
			main.addEventListener(MouseEvent.CLICK, onMouseDown);
		}
		/*updates to allow menu option to be selected with ship*/
		private function updateMenu(event:Event):void
   		{
			if (startGame.hitTestPoint(mouseX, mouseY))
			{
				trace("MainMenu startgame");
				main.removeEventListener(Event.ENTER_FRAME, updateMenu);
				main.startGame();
			}
			else if (startStats.hitTestPoint(mouseX, mouseY))
			{
				//removeEventListener(Event.ENTER_FRAME, updateMenu);
				trace("MainMenu startstats");
			}
   		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			if (startGame.hitTestPoint(mouseX, mouseY))
			{
				trace("MainMenu startgame");
				main.removeEventListener(Event.ENTER_FRAME, updateMenu);
				main.startGame();
			}
		}
	}
}