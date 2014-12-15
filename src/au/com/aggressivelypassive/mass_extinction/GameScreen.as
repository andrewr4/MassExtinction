package  au.com.aggressivelypassive.mass_extinction
{
	import flash.display.*;
	import au.com.aggressivelypassive.mass_extinction.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
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
		
		[Embed(source="earth.jpg")]
        protected var Earth:Class;
		
		//[Embed(source="asteroid.jpg")]
        //protected var Asteroid:Class;
		
        protected var earth:Bitmap = new Earth();
		private var spinner:Spinner = new Spinner(earth);
		protected var aY:Number = 0;
		protected var aimer:Sprite = new Sprite();
		
		public var leftArrow:Sprite = new Sprite();
		public var rightArrow:Sprite = new Sprite();
		
		private var main:Main;
		
		//protected var asteroid:Bitmap = new Asteroid();
		private var asteroidSpinner:Asteroid = new Asteroid();
		
		private var aimerTravelTimer:Timer;
		
		public function GameScreen(m:Main) 
		{
			main = m;
			
			graphics.lineStyle(1, 0x000000);
			graphics.beginFill(0x000000, 1);
            graphics.drawRect(0, 0, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1);
			
			graphics.drawRect(0, 300, SCREEN_WIDTH - 1, 180 - 1);
			graphics.endFill();
			spinner.setSpeed(main.getUserInfo().getRotateSpeed());
			addChild(spinner);
			drawArrows();
			
			aimer.graphics.lineStyle(2, 0xFF0000);
			aimer.graphics.drawCircle(0, 0, 20);
			aimer.x = 185 + 135;
			aimer.y = 15 + 135;
			addChild(aimer);
			
			main.addEventListener(Event.ENTER_FRAME, updateGS);
			main.addEventListener(Event.ENTER_FRAME, spinner.update);
			main.stage.addEventListener(KeyboardEvent.KEY_DOWN, moveAimer);
			main.stage.addEventListener(KeyboardEvent.KEY_UP, stopAimer);
		}
		
		public function moveAimer(event:KeyboardEvent):void
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
				main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, moveAimer);
				//main.removeEventListener(Event.ENTER_FRAME, updateGS);
				throwAimer();
			}
		}
		
		public function stopAimer(event:KeyboardEvent):void
		{
			aY = 0;
		}
		
		public function throwAimer():void
		{
			trace("throwing");
			asteroidSpinner.width = aimer.width + 91;
			asteroidSpinner.height = aimer.height + 91;
			asteroidSpinner.x = aimer.x;
			asteroidSpinner.y = aimer.y;
			addChild(asteroidSpinner);
			
			aimerTravelTimer = new Timer(3000,1);
			aimerTravelTimer.addEventListener(TimerEvent.TIMER, getRGB);
			aimerTravelTimer.start();
		}
		
		public function getRGB(event:TimerEvent):void
		{
			var sumColourR:Number = 0;
			var sumColourG:Number = 0;
			var sumColourB:Number = 0;
			var count:Number = 0;

			for(var h:Number = aimer.y; h < (aimer.y + aimer.height); h++)
			{
				for(var w:Number = aimer.x; w < (aimer.x + aimer.width); w++)
				{
					var pixel:Number = spinner.getScoreBitmap().bitmapData.getPixel(w - 185, h - (15 + aimer.height/2));
					sumColourR += pixel >> 16 & 0xFF;
					sumColourG += pixel >> 8 & 0xFF;
					sumColourB += pixel & 0xFF;
					count++;
				}
			}
			
			//score((sumColourR + sumColourG + sumColourB)/count);
			
			//mX = count;
			//mY = sumColourR/count + sumColourG/count + sumColourB/count;
			
			this.removeChild(asteroidSpinner);
			
			trace("asteroidSpinner.width~" + asteroidSpinner.width);
			trace("asteroidSpinner.height~" + asteroidSpinner.height);
			
			
			main.addEventListener(Event.ENTER_FRAME, updateGS);
			main.stage.addEventListener(KeyboardEvent.KEY_DOWN, moveAimer);
			trace("score~" + (sumColourR / count + sumColourG / count + sumColourB / count));
		}
		
		private function drawArrows():void
		{
			leftArrow.graphics.beginFill(0xFF0000, 1);
			
			//left arrow
			leftArrow.graphics.drawRect(65, 120, 40, 40);
			leftArrow.graphics.lineStyle(2, 0xFF0000);
			leftArrow.graphics.moveTo(20, 140);
			leftArrow.graphics.lineTo(65, 110);
			leftArrow.graphics.lineTo(65, 170);
			leftArrow.graphics.lineTo(20, 140);
			addChild(leftArrow);

			//right arrow
			rightArrow.graphics.beginFill(0xFF0000, 1);
			rightArrow.graphics.drawRect(525, 120, 40, 40);
			rightArrow.graphics.lineStyle(2, 0xFF0000);
			rightArrow.graphics.moveTo(610, 140);
			rightArrow.graphics.lineTo(565, 110);
			rightArrow.graphics.lineTo(565, 170);
			rightArrow.graphics.lineTo(610, 140);
			addChild(rightArrow);
		}
		
		private function updateGS(event:Event):void 
		{
			if (aimerTravelTimer != null && aimerTravelTimer.running)
			{
				asteroidSpinner.width--;
				asteroidSpinner.height--;
			}
			else
			{
				if (leftArrow.hitTestPoint(mouseX, mouseY))
				{
					spinner.setDirection(0);
				}
				else if (rightArrow.hitTestPoint(mouseX, mouseY))
				{
					spinner.setDirection(1);
				}
				
				if (aimer.y < (15 + aimer.height/2))
				{
					aimer.y = 15 + aimer.height/2;
				}
				else if ( aimer.y > (15 + (spinner.height - aimer.height/2)))
				{
					aimer.y = 15+ (spinner.height - aimer.height / 2);
				}
				else
				{
					aimer.y += aY;
				}	
			}
		}
	}
}