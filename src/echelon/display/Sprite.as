/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-03
 * Time: 10:02
 * To change this template use File | Settings | File Templates.
 */
package echelon.display
{
	import echelon.rendering.IRenderer;
	import echelon.rendering.RenderFrameTransform;
	import echelon.timing.Time;

	import flash.display.BitmapData;
	import flash.filters.BitmapFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Sprite extends DisplayObjectContainer
	{
		public var alpha:Number = 1;
		public var visible:Boolean = true;
		public var transparent:Boolean = true;
		public var filters:Vector.<BitmapFilter> = new <BitmapFilter>[];

		private var _bmp:BitmapData;
		private var _sz:Rectangle;

		protected var _renderer:IRenderer;

		public function Sprite()
		{
			stageUpdated.add(onStageUpdated);
		}

		private function onStageUpdated():void
		{
			_renderer = stage.renderer;
		}

		override public function render(time:Time, transform:RenderFrameTransform = null):void
		{
			if (visible && _bmp != null)
			{
				_renderer.simpleDraw(_bmp, _sz, pos.add(transform.pos), transparent, alpha);
			}

			renderChildren(time, transform);

			for each (var filter:BitmapFilter in filters)
			{
				_renderer.applyFilter(filter, _sz, new Point(_sz.x, _sz.y));
			}
		}

		public function get bitmapDataSrc():BitmapData
		{
			return _bmp;
		}

		public function set bitmapDataSrc(value:BitmapData):void
		{
			_bmp = value;
			_sz = new Rectangle(0, 0, value.width, value.height);
		}

		public function set size(value:Rectangle):void
		{
			_sz = value;
		}
	}
}
