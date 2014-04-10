/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-04
 * Time: 10:30
 * To change this template use File | Settings | File Templates.
 */
package echelon.timing.timers
{
	import echelon.timing.Time;

	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	/**
	 * This timer uses a flash.utils.Timer object to keep track of the time.
	 */
	public class TimeBasedTimer implements ITimer
	{
		private var _timer:Timer;
		private var _tickHandler:Function;
		private var _time:Time;

		public function TimeBasedTimer()
		{
			_timer = new Timer(1);
			_time = new Time();
			_timer.addEventListener(TimerEvent.TIMER, onTimerTick);
		}

		private function onTimerTick(event:TimerEvent):void
		{
			_time.tick(getTimer());
			_tickHandler.call(null, _time);
		}

		public function start(target:DisplayObject):void
		{
			_timer.start();
		}

		public function end():void
		{
			_timer.stop();
		}

		public function set tickHandler(handler:Function):void
		{
			_tickHandler = handler;
		}
	}
}
