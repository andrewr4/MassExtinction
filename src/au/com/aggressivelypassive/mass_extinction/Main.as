package au.com.aggressivelypassive.mass_extinction
{
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	
	import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.filters.DisplacementMapFilter;
    import flash.geom.*;
	import flash.text.TextField;
	import au.com.aggressivelypassive.mass_extinction.menus.*;
	//import au.com.aggressivelypassive.mass_extinction.*;
	
	/**
	 * ...
	 * @author Andrew Reynolds
	 */
	public class Main extends Sprite 
	{
        protected const ORIGIN:Point = new Point(0,0);
		//height and width of screen
		public const SCREEN_WIDTH:int = 640;
   		public const SCREEN_HEIGHT:int = 480;
		
		protected var points:ByteArray;
		
		protected var userInfo:UserInfo = new UserInfo();
		protected var mainMenu:MainMenu;
		public var screen:GameScreen;
		
		public function Main():void 
		{   
			if (!stage)
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		//PAUSE MENU
		//graphics.clear();
		
		public function init(event:Event):void 
		{
			trace("init");
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			mainMenu = new MainMenu(this);
			addChild(mainMenu);
			
			stage.frameRate = 30;
            stage.scaleMode = "noScale";
			
			userInfo.init();
		}
		
		public function startGame():void
		{
			screen = new GameScreen(this);
			//addEventListener(Event.ENTER_FRAME, update);
			this.removeChild(mainMenu);
			addChild(screen);
		}
		
        public function update(event:Event):void
        {

        }

		public function pause(event:KeyboardEvent):void
		{
         	if (event.keyCode == Keyboard.CONTROL)//change to pause key
      		{
         		
      		}
		}
		
		public function score(score:int):void
		{
			trace("Score: " + score);
		}
		
		public function getUserInfo():UserInfo
		{
			return userInfo;
		}
	}
}