package  au.com.aggressivelypassive.mass_extinction
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
    import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.*;
	import au.com.aggressivelypassive.mass_extinction.*;
	/**
	 * ...
	 * @author Andrew Reynolds
	 */
	 
	public class Spinner extends Sprite
	{
		private const W:Number = 270;
        private const H:Number = 270;
		//private const H:Number = 548
		private const ORIGIN:Point = new Point(0, 0);
		private var sx:Number = 0;
		private var speed:Number = 4;
		private var dir:Number = 1; //0 = left, 1 = right
		
		private var disp:DisplacementMapFilter;
		private var myBitmap:Bitmap = new Bitmap();
		private var myScore:Bitmap = new Bitmap();
		
		private var planet:Bitmap;
		
		public function Spinner(bit:Bitmap):void
		{
			planet = bit;
			
			myBitmap.bitmapData = new BitmapData(W, H, false);
			myBitmap.x = 185;
			myBitmap.y = 15;
			
			myScore.bitmapData = new BitmapData(W, H, false);
			
            addChild(myBitmap);
            makeDisplacementMap();
		}

		public function getScoreBitmap():Bitmap
		{
			return myScore;
			//return myBitmap;
		}
		
		
		public function getBitmap():Bitmap
		{
			return myBitmap;
		}
		
		private function makeDisplacementMap():void
        {
            var map:BitmapData = new BitmapData(W, H, false);

            for (var y:Number = 0; y < H; ++y)
            {
                var yr:Number = y / H; // ratio of Y coordinate to image height
                var lat:Number = Math.asin(1 - yr * 2); // latitude
                var yd:Number = 0.5 - lat / Math.PI - yr; // difference between Y-coordinate ratios before and after transformation
                var yc:Number = Math.round(yd * 0x100) + 0x80 << 8; // map's Y component
                var ew:Number = Math.cos(lat); // length of parallel
                for (var x:Number = 0; x < W; ++x)
                {
                    var xc:Number;
                    var xr:Number = x / W; // ratio of X coordinate to image width
                    var lap:Number = Math.acos((0.5 - xr) / ew * 2); // longitude
                    if (isNaN(lap))
                    { // undefined longitude means outside the circle
                        xc = xr > 0.5 ? 0xFF : 0;// set the map's X component to a large number
                    }
                    else
                    {
                        var xd:Number = lap / Math.PI - xr; // difference between X-coordinate ratios before and after transformation
                        xc = Math.round(xd * 0x100) + 0x80; // map's X component
                    }
                    map.setPixel(x, y, yc | xc);
                }        
            }                
            disp = new DisplacementMapFilter(map, null, 4, 2, W, H, "color", 0x000000);
        }
		
		public function setSpeed(s:Number):void
		{
			speed = s;
		}
		
		public function setDirection(d:Number):void
		{
			dir = d;
		}
		
		public function update(event:Event):void
        {	
			//~0.5 is smallest increment.
			if(dir == 1)
			{
				sx = (sx + speed) % (planet.width/2);
			}
			else
			{
				sx = (sx - speed) <= 0 ? 540 : (sx - speed);
			}
            myBitmap.bitmapData.copyPixels(planet.bitmapData, new Rectangle(sx, 0, W, H), ORIGIN);
            myBitmap.bitmapData.applyFilter(myBitmap.bitmapData, new Rectangle(0, 0, W, H), ORIGIN, disp);
			myScore.bitmapData.copyPixels(planet.bitmapData, new Rectangle(sx, 270, W, H), ORIGIN);
        }
		
	}

}