package 
{
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.filters.DisplacementMapFilter;
    import flash.geom.*;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Andrew Reynolds
	 */
	public class Main extends Sprite 
	{
        protected const ORIGIN:Point = new Point(0,0);
		
        [Embed(source="earth.jpg")]
        protected var Earth:Class;
        
        protected var earth:Bitmap = new Earth();
		
		protected var mX:Number = 0;
		protected var mY:Number = 0;
		protected var mouseDisplay:TextField = new TextField();
		
		protected var aY:Number = 0;
		protected var asteroid:Sprite = new Sprite();
		
		protected var points:ByteArray;
		
		protected var spinner:Spinner = new Spinner(earth);
		protected var screen:GameScreen = new GameScreen();
		
		public function Main():void 
		{   
			if (!stage)
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
			else 
			{
				//init(stage);
			}
		}
		
		private function init(event:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//spinner.x = 185;
			//spinner.y = 15;
			
			addChild(screen);
			addChild(spinner);
            addEventListener(Event.ENTER_FRAME, update);
			addEventListener(Event.ENTER_FRAME, spinner.update);
			
			stage.frameRate = 60;
            stage.scaleMode = "noScale";
			
			mouseDisplay.x = 0;
			mouseDisplay.y = 310;
			mouseDisplay.text = "(" + mX + "," + mY + ")";
			
			addChild(mouseDisplay);
			//stage.addEventListener(MouseEvent.CLICK, click);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, moveAsteroid);
			stage.addEventListener(KeyboardEvent.KEY_UP, stopAsteroid);
			
			asteroid.graphics.lineStyle(2, 0xFF0000);
			asteroid.graphics.drawCircle(0, 0, 20);
			asteroid.x = 185 + 135;
			asteroid.y = 15 + 135;
			addChild(asteroid);
		}
        
		private function click(event:MouseEvent):void
		{
			mX = mouseX;
			mY = mouseY;
		}
		
		private function moveAsteroid(event:KeyboardEvent):void
		{
         	if (event.keyCode == 87 || event.keyCode == Keyboard.UP)
      		{
         		aY = -1;
      		}
      		else if (event.keyCode == 83 || event.keyCode == Keyboard.DOWN)
      		{
         		aY = 1;
      		}
			else if (event.keyCode == Keyboard.SPACE)
			{	
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, moveAsteroid);
				throwAsteroid();
			}
		}
		
		private function throwAsteroid():void
		{
			var asteroidTravelTimer:Timer = new Timer(3000,1);
			asteroidTravelTimer.addEventListener(TimerEvent.TIMER, getRGB);
			asteroidTravelTimer.start();
		}
		
		private function stopAsteroid(event:KeyboardEvent):void
		{
			aY = 0;
		}
		
		private function getRGB(event:TimerEvent):void
		{
			var sumColourR:Number = 0;
			var sumColourG:Number = 0;
			var sumColourB:Number = 0;
			var count:Number = 0;
				
			for(var h:Number = asteroid.y; h < (asteroid.y + asteroid.height); h++)
			{
				for(var w:Number = asteroid.x; w < (asteroid.x + asteroid.width); w++)
				{
					var pixel:Number = spinner.getScoreBitmap().bitmapData.getPixel(w - 185, h - (15 + asteroid.height/2));
					sumColourR += pixel >> 16 & 0xFF;
					sumColourG += pixel >> 8 & 0xFF;
					sumColourB += pixel & 0xFF;
					count++;
				}
			}
			
			score((sumColourR + sumColourG + sumColourB)/count);
			
			mX = count;
			mY = sumColourR/count + sumColourG/count + sumColourB/count;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, moveAsteroid);
		}
		
        private function update(event:Event):void
        {
			mouseDisplay.text = "(" + mX + "," + mY + ")";

			if (asteroid.y < (15 + asteroid.height/2))
			{
				asteroid.y = 15 + asteroid.height/2;
			}
			else if ( asteroid.y > (15 + (spinner.height - asteroid.height/2)))
			{
				asteroid.y = 15+ (spinner.height - asteroid.height / 2);
			}
			else
			{
				asteroid.y += aY;
			}
        }
		
		private function score(score:int):void
		{
			trace("Score: " + score);
		}
	}
}