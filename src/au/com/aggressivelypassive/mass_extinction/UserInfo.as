package au.com.aggressivelypassive.mass_extinction
{
	import flash.net.SharedObject;
	import au.com.aggressivelypassive.mass_extinction.*;
	
	/**
	 * ...
	 * @author Andrew Reynolds
	 */
	public class UserInfo 
	{
		//also needs "abilities" like disease and potency etc.
		public var userInfo:SharedObject;
		
		private const asteroidSizeDefault:Number = 1;
		private const asteroidSpeedDefault:Number = 1;
		private const asteroidDensityDefault:Number = 1;
		private const rotateSpeedDefault:Number = 4;
		private const nameDefault:String = "J. Smith";
		private const contagionPotencyDefault:Number = 0;
		
		private var asteroidSize:Number;
		private var asteroidSpeed:Number;
		private var asteroidDensity:Number;
		
		private var contagionPotency:Number;
		
		private var rotateSpeed:Number;
		
		private var name:String;
		
		public function init():void
		{
			userInfo = SharedObject.getLocal("MassExtinction");
			
			//load settings
		    load();
		}
		
		private function load():void
		{
			if(userInfo.data.asteroidSize == null)
		    {
				setAsteroidSize(asteroidSizeDefault);
		    }
			else
			{
				setAsteroidSize(userInfo.data.asteroidSize);
			}
			
			if(userInfo.data.Density== null)
		    {
				setAsteroidDensity(asteroidDensityDefault);
		    }
			else
			{
				setAsteroidDensity(userInfo.data.asteroidDensity);
			}
			
			if(userInfo.data.asteroidSpeed == null)
		    {
				setAsteroidSpeed(asteroidSpeedDefault);
		    }
			else
			{
				setAsteroidSpeed(userInfo.data.asteroidSpeed);
			}
			
			if(userInfo.data.rotateSpeed == null)
		    {
				setRotateSpeed(rotateSpeedDefault);
		    }
			else
			{
				setRotateSpeed(userInfo.data.rotateSpeed);
			}
			
			if(userInfo.data.name == null)
		    {
				setName(nameDefault);
		    }
			else
			{
				setName(userInfo.data.name);
			}
			
			if(userInfo.data.contagionPotency == null)
		    {
				setContagionPotency(contagionPotencyDefault);
		    }
			else
			{
				setContagionPotency(userInfo.data.contagionPotency);
			}
		}
		
		public function reset():void
		{
			setAsteroidSize(asteroidSizeDefault);
			setAsteroidDensity(asteroidDensityDefault);
			setAsteroidSpeed(asteroidSpeedDefault);
			setRotateSpeed(rotateSpeedDefault);
			setContagionPotency(contagionPotencyDefault);
			setName(nameDefault);
		}
		
		public function save():void
		{
			userInfo.data.asteroidSize = getAsteroidSize();
			userInfo.data.asteroidDensity = getAsteroidDensity();
			userInfo.data.asteroidSpeed = getAsteroidSpeed();
			userInfo.data.rotateSpeed = getRotateSpeed();
			userInfo.data.name = getName();
			userInfo.flush();
		}
		
		public function getAsteroidSize():Number
		{
			return asteroidSize;
		}
		
		public function getAsteroidSpeed():Number
		{
			return asteroidSpeed;
		}
		
		public function getAsteroidDensity():Number
		{
			return asteroidDensity;
		}
		
		public function getRotateSpeed():Number
		{
			return rotateSpeed;
		}
		
		public function getName():String
		{
			return name;
		}
		
		public function getContagionPotency():Number
		{
			return contagionPotency;
		}
		
		public function setAsteroidSize(size:Number):void
		{
			asteroidSize = size;
		}
		
		public function setAsteroidSpeed(speed:Number):void
		{
			asteroidSpeed = speed;
		}
		
		public function setAsteroidDensity(density:Number):void
		{
			asteroidDensity = density;
		}
		
		public function setRotateSpeed(speed:Number):void
		{
			if (speed < 0.5)
				rotateSpeed = 0.5;
			else if (speed > 4)
				rotateSpeed = 4;
			else
				rotateSpeed = speed;
		}
		
		public function setName(uName:String):void
		{
			name = uName;
		}
		
		public function setContagionPotency(potency:Number):void
		{
			contagionPotency = potency;
		}
	}
}