package echelon.timing
{
	/**
	 * Time container measuring the elapsed time since the start of
	 * execution and time elapsed during last frame.
	 *
	 * @auther tomas.augustinovic
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
