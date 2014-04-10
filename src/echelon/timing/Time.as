package echelon.timing
{
	/**
	 * Holds the time it takes to render one frame, as well as the elapsed time since QEngine
	 * was started.
	 */
	public class Time
	{
		private var _time:TimeUnit;
		private var _frameTime:TimeUnit;

		public function Time()
		{
			_time = new TimeUnit(0);
			_frameTime = new TimeUnit(0);
		}

		public function tick(time:Number):void
		{
			_frameTime.milliseconds = time - _time.milliseconds;
			_time.milliseconds += _frameTime.milliseconds;
		}

		public function get elapsedTime():TimeUnit
		{
			return _time;
		}

		public function get frameTime():TimeUnit
		{
			return _frameTime;
		}
	}
}
