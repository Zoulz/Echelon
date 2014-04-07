/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-05
 * Time: 14:57
 * To change this template use File | Settings | File Templates.
 */
package echelon.rendering
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Renderer implements IRenderer
	{
		private var _target:BitmapData;
		private var _alphaBmp:BitmapData;
		private var _alphaRect:Rectangle;

		public function Renderer(targetBuffer:BitmapData = null)
		{
			_target = targetBuffer;
			_alphaBmp = new BitmapData(1, 1, true);
			_alphaRect = new Rectangle();
		}

		public function simpleDraw(src:BitmapData, srcRect:Rectangle, destPoint:Point, useAlpha:Boolean = true, alpha:Number = 1):void
		{
			if (alpha < 1)
			{
				if (_alphaRect.width == src.width && _alphaRect.height == src.height)
				{
					_alphaBmp.fillRect(_alphaRect, toARGB(0x000000, alpha * 255));
				}
				else
				{
					_alphaBmp.dispose();
					_alphaBmp = new BitmapData(src.width, src.height, true, toARGB(0x000000, alpha * 255));
					_alphaRect.width = src.width;
					_alphaRect.height = src.height;
				}

				_target.copyPixels(src, srcRect, destPoint, _alphaBmp, null, useAlpha);
			}
			else
			{
				_target.copyPixels(src, srcRect, destPoint, null, null, useAlpha);
			}
		}

		public function advancedDraw(src:DisplayObject, srcRect:Rectangle, transformMx:Matrix = null, colorTransform:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null, smoothing:Boolean = false):void
		{
			_target.draw(src, transformMx, colorTransform, blendMode, clipRect, smoothing);
		}

		public function fillRect(rect:Rectangle, color:uint):void
		{
			_target.fillRect(rect, color);
		}

		public function set targetRenderBuffer(value:BitmapData):void
		{
			_target = value;
		}

		private function toARGB(rgb:uint, newAlpha:uint):uint
		{
			var argb:uint = 0;
			argb = (rgb);
			argb += (newAlpha << 24);

			return argb;
		}

		public function applyFilter(filter:BitmapFilter, region:Rectangle, dest:Point):void
		{
			_target.applyFilter(_target,  region, dest, filter);
		}
	}
}
