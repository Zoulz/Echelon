package echelon.timing.timers
{
	import flash.display.DisplayObject;

	/**
	 * This interface describes a Echelon timer.
	 */
	public interface ITimer
	{
		/**
		 * Invoked by QEngine to start the timer.
		 * @param target
		 */
		function start(target:DisplayObject):void;

		/**
		 * Invoked to stop the timer.
		 */
		function end():void;

		/**
		 * A callback function reference to be invoked by the timer on
		 * each tick.
		 * @param handler
		 */
		function set tickHandler(handler:Function):void;
	}
}
