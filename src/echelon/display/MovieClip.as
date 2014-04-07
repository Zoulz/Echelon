/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-03
 * Time: 10:01
 * To change this template use File | Settings | File Templates.
 */
package echelon.display
{
	import echelon.rendering.RenderFrameTransform;
	import echelon.rendering.TileData;
	import echelon.rendering.TileSheet;
	import echelon.timing.Time;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class MovieClip extends Sprite
	{
		public var tileIndex:uint;

		private var _frameRate:uint;
		private var _time:int;
		private var _frameTime:int;
		private var _loop:Boolean;
		private var _hasStopped:Boolean;
		private var _tileSheet:TileSheet;
		private var _tileData:TileData;
		private var _animationComplete:Signal = new Signal();

		public function MovieClip(frameRate:uint = 30, loop:Boolean = false)
		{
			super();

			this.frameRate = frameRate;
			_loop = loop;
			_hasStopped = false;
		}

		public function play():void
		{
			_hasStopped = false;
		}

		public function stop():void
		{
			_hasStopped = true;
		}

		override public function render(time:Time, transform:RenderFrameTransform = null):void
		{
			if (!_hasStopped)
			{
				_time += time.frameTime.milliseconds;
				while (_time >= _frameTime)
				{
					_time -= _frameTime;
					tileIndex++;
					if (tileIndex == tileSheet.length)
					{
						tileIndex = 0;
						if (_loop == false)
						{
							_hasStopped = true;
							_animationComplete.dispatch();
						}
					}
				}
			}

			if (visible)
			{
				_tileData = _tileSheet.getTileData(tileIndex);
				_renderer.simpleDraw(_tileSheet.data, _tileData.rect, pos.subtract(_tileData.offset).add(transform.pos), transparent, alpha);
			}

			renderChildren(time, transform);
		}

		public function get frameRate():uint
		{
			return _frameRate;
		}

		public function set frameRate(value:uint):void
		{
			_frameRate = value;
			_frameTime = (1000 / _frameRate) << 0;
		}

		public function get tileSheet():TileSheet
		{
			return _tileSheet;
		}

		public function set tileSheet(value:TileSheet):void
		{
			_tileSheet = value;
		}

		public function get animationComplete():ISignal
		{
			return _animationComplete;
		}
	}
}
