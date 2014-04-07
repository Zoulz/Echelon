/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-04
 * Time: 10:06
 * To change this template use File | Settings | File Templates.
 */
package echelon.timing.timers
{
	import flash.display.DisplayObject;

	public interface ITimer
	{
		function start(target:DisplayObject):void;
		function end():void;
		function set tickHandler(handler:Function):void;
	}
}
