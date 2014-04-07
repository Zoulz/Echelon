/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-03
 * Time: 09:45
 * To change this template use File | Settings | File Templates.
 */
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
		private var _tickCallback:Function = null;

		public function Echelon(displaySize:Rectangle, transparent:Boolean = true, fillColor:uint = 0xFF000000, smoothing:Boolean = true)
		{
			_renderBuffer = new BitmapData(displaySize.width, displaySize.height, transparent, fillColor);

			_displayBmp = new Bitmap(_renderBuffer, PixelSnapping.AUTO, smoothing);

			_stage = new Stage(_renderer);
			_clearColor = fillColor;
			_clearRegion = displaySize;
		}

		/**
		 * Begin the rendering.
		 */
		public function start():void
		{
			if (_timer)
			{
				_timer.start(_displayBmp);
			}
			else
			{
				throw new Error("Echelon has no timer instance.");
			}
		}

		/**
		 * Stop the rendering.
		 */
		public function stop():void
		{
			if (_timer)
			{
				_timer.end();
			}
			else
			{
				throw new Error("Echelon has no timer instance.");
			}
		}

		/**
		 * Shut down echelon. Stop rendering and dispose the stage object.
		 */
		public function destroy():void
		{
			stop();

			_stage.dispose();
		}

		/**
		 * The render loop invoked for each tick of the timer.
		 * @param time
		 */
		private function renderLoop(time:Time):void
		{
			//	Tick callback if set.
			if (_tickCallback)
			{
				_tickCallback(time);
			}

			//  Transverse the display objects.
			_renderBuffer.lock();
			_renderBuffer.fillRect(_clearRegion, _clearColor);
			_stage.render(time);
			_renderBuffer.unlock();
		}

		/**
		 * Return the render target bitmap.
		 */
		public function get displayBitmap():Bitmap
		{
			return _displayBmp;
		}

		/**
		 * Return the echelon stage object.
		 */
		public function get stage():Stage
		{
			return _stage;
		}

		/**
		 * Set reference of timer to use.
		 * @param value
		 */
		public function set timer(value:ITimer):void
		{
			_timer = value;
			_timer.tickHandler = renderLoop;
		}

		/**
		 * Set reference of renderer to use.
		 * @param value
		 */
		public function set renderer(value:IRenderer):void
		{
			_renderer = value;
			_renderer.targetRenderBuffer = _renderBuffer;
			_stage.renderer = _renderer;
		}

		/**
		 * Set callback function invoked at the beginning of a tick.
		 * @param value
		 */
		public function set tickCallback(value:Function):void
		{
			_tickCallback = value;
		}
	}
}
