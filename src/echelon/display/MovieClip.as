package echelon.display
{
	import echelon.rendering.RenderFrameTransform;
	import echelon.rendering.tiles.TileData;
	import echelon.rendering.tiles.TileSheet;
	import echelon.timing.Time;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * Renders a animation based on a tilesheet.
	 */
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
		private var _animationComplete:ISignal = new Signal();

		public function MovieClip(frameRate:uint = 30, loop:Boolean = false)
		{
			super();

			this.frameRate = frameRate;
			_loop = loop;
			_hasStopped = false;
		}

		/**
		 * Enables the movieclip to play it's animation.
		 */
		public function play():void
		{
			_hasStopped = false;
		}

		/**
		 * Disables the movieclip from rendering it's animation. Freezes in it's current frame.
		 */
		public function stop():void
		{
			_hasStopped = true;
		}

		/**
		 * Increments current tile frame based on supplied time. Renders the frame and then
		 * transverses it's children.
		 * @param time
		 * @param transform
		 */
		override public function render(time:Time, transform:RenderFrameTransform = null):void
		{
			//  Increment tile index based on time.
			if (!_hasStopped)
			{
				_time += time.frameTime.milliseconds;
				while (_time >= _frameTime)
				{
					_time -= _frameTime;
					tileIndex++;

					if (tileIndex == tileSheet.length)
					{
						//  If we reached the last frame, check if we are looping, otherwise
						//  dispatch completion signal.
						tileIndex = 0;
						if (_loop == false)
						{
							_hasStopped = true;
							_animationComplete.dispatch();
						}
					}
				}
			}

			//  Render the current frame if visible and has a actual tilesheet reference.
			if (visible && _tileSheet != null)
			{
				_tileData = _tileSheet.getTileData(tileIndex);
				_renderData.srcRect = _tileData.rect;
				_renderer.draw(_renderData, pos.subtract(_tileData.offset).add(transform.pos));
			}

			//  Update the render transform.
			_renderTrans.clear();
			_renderTrans.pos = transform.pos.add(this.pos);

			//  Render children.
			_childrenLength = children.length;
			for (_iterator = 0; _iterator < _childrenLength; _iterator++)
			{
				children[_iterator].render(time, _renderTrans);
			}

			//  Apply filters.
			_childrenLength = filters.length;
			for (_iterator = 0; _iterator < _childrenLength; _iterator++)
			{
				_renderer.applyFilter(filters[_iterator], size, size.topLeft);
			}
		}

		/**
		 * Get the current frame rate (frames per second) used to calculate frame advancement.
		 */
		public function get frameRate():uint
		{
			return _frameRate;
		}

		/**
		 * Set the current frame rate in "frames per second".
		 * @param value
		 */
		public function set frameRate(value:uint):void
		{
			_frameRate = value;
			_frameTime = (1000 / _frameRate) << 0;
		}

		/**
		 * Get the currently used tilesheet.
		 */
		public function get tileSheet():TileSheet
		{
			return _tileSheet;
		}

		/**
		 * Set a tilesheet.
		 * @param value
		 */
		public function set tileSheet(value:TileSheet):void
		{
			_tileSheet = value;

			_renderData.srcData = _tileSheet.data;
		}

		/**
		 * Signal dispatched when the animation has run through all of it's tiles and the loop
		 * flag is not activated.
		 */
		public function get animationComplete():ISignal
		{
			return _animationComplete;
		}
	}
}
