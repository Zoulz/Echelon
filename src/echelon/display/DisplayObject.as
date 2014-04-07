/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-03
 * Time: 09:59
 * To change this template use File | Settings | File Templates.
 */
package echelon.display
{
	import echelon.rendering.RenderFrameTransform;
	import echelon.timing.Time;

	import flash.geom.Point;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class DisplayObject
	{
		public var pos:Point = new Point();
		public var name:String = "";

		private static var _objCount:uint = 0;

		private var _stage:Stage = null;
		private var _stageUpdated:Signal = new Signal();

		public function DisplayObject()
		{
			name = "object" + DisplayObject.getNextObjectId();
		}

		public static function getNextObjectId():uint
		{
			return _objCount++;
		}

		public function dispose():void
		{
			_stageUpdated.removeAll();
		}

		public function render(time:Time, transform:RenderFrameTransform = null):void
		{
			//  NO-OP
		}

		public function set stage(value:Stage):void
		{
			_stage = value;
			_stageUpdated.dispatch();
		}

		public function get stage():Stage
		{
			return _stage;
		}

		public function get stageUpdated():ISignal
		{
			return _stageUpdated;
		}
	}
}
