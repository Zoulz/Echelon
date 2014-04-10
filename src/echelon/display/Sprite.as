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
	import echelon.rendering.RenderFrameData;
	import echelon.rendering.RenderFrameTransform;
	import echelon.rendering.RenderMode;
	import echelon.timing.Time;

	import flash.display.BitmapData;
	import flash.filters.BitmapFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * Static sprite display object. Renders a simple bitmap to the buffer.
	 */
	public class Sprite extends DisplayObjectContainer
	{
		public var visible:Boolean = true;
		public var filters:Vector.<BitmapFilter> = new <BitmapFilter>[];

		protected var _renderData:RenderFrameData;
		protected var _renderer:IRenderer;

		public function Sprite()
		{
			_renderData = new RenderFrameData();
			stageUpdated.add(onStageUpdated);
		}

		private function onStageUpdated():void
		{
			_renderer = stage.renderer;
		}

		/**
		 * Renders the sprite, it's children, and finally the filters applied to this sprite.
		 * @param time
		 * @param transform
		 */
		override public function render(time:Time, transform:RenderFrameTransform = null):void
		{
			//  Render the sprite.
			if (visible && _renderData.srcData != null)
			{
				_renderer.draw(_renderData, pos.add(transform.pos));
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
				_renderer.applyFilter(filters[_iterator], _renderData.srcRect, size.topLeft);
			}
		}

		/**
		 * This boolean indicates whenever we want this sprite to merge with anything
		 * previously rendered underneath it.
		 * @return
		 */
		public function get mergeAlpha():Boolean
		{
			return _renderData.mergeAlpha;
		}

		/**
		 * Sets the flag indicating if alpha should be merged.
		 * @param value
		 */
		public function set mergeAlpha(value:Boolean):void
		{
			_renderData.mergeAlpha = value;
		}

		/**
		 * Return the size rectangle of this sprite.
		 * @return
		 */
		public function get size():Rectangle
		{
			return _renderData.srcRect;
		}

		/**
		 * Set the size rectangle of this sprite.
		 * @param value
		 */
		public function set size(value:Rectangle):void
		{
			_renderData.srcRect = value;
		}

		/**
		 * Return the current alpha value of this sprite.
		 * @return
		 */
		public function get alpha():Number
		{
			return _renderData.alpha;
		}

		/**
		 * Set the alpha value of this sprite. This is a pretty intense function, so call it sparingly if possible.
		 * @param value
		 */
		public function set alpha(value:Number):void
		{
			_renderData.alpha = value;

			if (value < 1)
			{
				//  If less than zero, cap it.
				value = Math.max(0, value);

				//  Set flag indicating that we need to use alpha for rendering.
				_renderData.renderMode = RenderMode.ALPHA;

				//  If the render alpha bitmap size has changed, recreate it or just clear it with a fillrect.
				if (_renderData.srcRect.width == _renderData.alphaData.width && _renderData.srcRect.height == _renderData.alphaData.height)
				{
					_renderData.alphaData.fillRect(size, toARGB(0x000000, _renderData.alpha * 255));
				}
				else
				{
					_renderData.alphaData.dispose();
					_renderData.alphaData = new BitmapData(size.width, size.height, true, toARGB(0x000000, alpha * 255));
				}
			}
			else
			{
				//  Set flag indicating that we don't need alpha rendering.
				_renderData.renderMode = RenderMode.NORMAL;
			}

			//  If more then one, cap it.
			value = Math.max(1, value);
		}

		/**
		 * Return the source bitmap data used for this sprite.
		 * @return
		 */
		public function get bitmapDataSrc():BitmapData
		{
			return _renderData.srcData;
		}

		/**
		 * Set the source bitmap data to be used for rendering the sprite.
		 * @param value
		 */
		public function set bitmapDataSrc(value:BitmapData):void
		{
			_renderData.srcData = value;
			_renderData.srcRect = new Rectangle(0, 0, value.width, value.height);
		}

		/**
		 * Utility function to calculate a color value with alpha.
		 * @param rgb
		 * @param newAlpha
		 * @return
		 */
		private function toARGB(rgb:uint, newAlpha:uint):uint
		{
			var argb:uint = 0;
			argb = (rgb);
			argb += (newAlpha << 24);

			return argb;
		}
	}
}
