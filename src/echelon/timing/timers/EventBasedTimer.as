/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-04
 * Time: 10:06
 * To change this template use File | Settings | File Templates.
 */
package echelon.timing.timers
{
	import echelon.timing.Time;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.getTimer;

	public class EventBasedTimer implements ITimer
	{
		private var _target:DisplayObject;
		private var _tickHandler:Function;
		private var _time:Time;

		public function EventBasedTimer()
		{
		}

		public function start(target:DisplayObject):void
		{
			_target = target;
			_time = new Time();

			_target.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event:Event):void
		{
			_time.tick(getTimer());
			_tickHandler(_time);
		}

		public function set tickHandler(handler:Function):void
		{
			_tickHandler = handler;
		}

		public function end():void
		{
			_target.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}
