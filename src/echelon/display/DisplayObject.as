package echelon.display
{
	import echelon.rendering.RenderFrameTransform;
	import echelon.timing.Time;

	import flash.geom.Point;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * The most basic of display objects which all others extend from.
	 * Supplies a position and name. Also keeps track of it's current stage
	 * and if it changes. Has no visual context and thus requires no rendering.
	 */
	public class DisplayObject
	{
		public var name:String = "";

		private static var _objCount:Number = 0;

		private var _stage:Stage = null;
		private var _stageUpdated:Signal = new Signal();

		protected var _pos:Point = new Point();

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

		public function get pos():Point
		{
			return _pos;
		}

		public function set x(value:int):void
		{
			pos.x = value;
		}

		public function get x():int
		{
			return pos.x;
		}

		public function set y(value:int):void
		{
			pos.y = value;
		}

		public function get y():int
		{
			return pos.y;
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
