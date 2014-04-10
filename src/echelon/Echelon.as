package echelon
{
	import echelon.display.Stage;
	import echelon.rendering.IRenderer;
	import echelon.timing.Time;
	import echelon.timing.timers.ITimer;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.geom.Rectangle;

	/*
		Echelon Rendering Engine
	*/
	final public class Echelon
	{
		private var _displayBmp:Bitmap;
		private var _renderBuffer:BitmapData;
		private var _timer:ITimer;
		private var _renderer:IRenderer;
		private var _stage:Stage;
		private var _clearRegion:Rectangle;
		private var _clearColor:uint;
		private var _tickHandler:Function;

		public function Echelon(displaySize:Rectangle, transparent:Boolean = true, fillColor:uint = 0x00000000, smoothing:Boolean = true)
		{
			_renderBuffer = new BitmapData(displaySize.width, displaySize.height, transparent, fillColor);

			_displayBmp = new Bitmap(_renderBuffer, PixelSnapping.AUTO, smoothing);

			_stage = new Stage(null);
			_clearColor = fillColor;
			_clearRegion = displaySize;
		}

		/**
		 * Starts the timer, thus starting the rendering loop.
		 */
		public function start():void
		{
			_timer.start(_displayBmp);
		}

		/**
		 * Stops the timer, halting rendering.
		 */
		public function stop():void
		{
			_timer.end();
		}

		/**
		 * Stops QEngine and cleans up.
		 */
		public function dispose():void
		{
			stop();

			_tickHandler = null;
			_timer = null;
			_renderer = null;

			_stage.dispose();
		}

		/**
		 * The main rendering loop handler, connected to the timer. Calls the tick handler function and renders all
		 * the display objects.
		 * @param time
		 */
		private function renderLoop(time:Time):void
		{
			//  Notify about tick.
			_tickHandler.call(null, time);

			//  Transverse the display objects.
			_renderBuffer.lock();
			_renderBuffer.fillRect(_clearRegion, _clearColor);
			_stage.render(time);
			_renderBuffer.unlock();
		}

		/**
		 * Return the main rendering canvas. This is where all the display objects gets rendered.
		 */
		public function get displayBitmap():Bitmap
		{
			return _displayBmp;
		}

		/**
		 * Return the stage object of the display list. This is the root where all subsequent display objects
		 * are added.
		 */
		public function get stage():Stage
		{
			return _stage;
		}

		/**
		 * Set the timer object to be used.
		 * @param value
		 */
		public function set timer(value:ITimer):void
		{
			_timer = value;
			_timer.tickHandler = renderLoop;
		}

		/**
		 * Set the renderer to be used.
		 * @param value
		 */
		public function set renderer(value:IRenderer):void
		{
			_renderer = value;
			_renderer.targetRenderBuffer = _renderBuffer;
			_stage.renderer = _renderer;
		}

		/**
		 * Set a callback handler that is called every timer tick.
		 * @param value
		 */
		public function set tickHandler(value:Function):void
		{
			_tickHandler = value;
		}
	}
}
