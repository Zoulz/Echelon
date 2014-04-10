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

	/**
	 * Default implementation of the renderer. Uses primarily copyPixels operations, and draw for the
	 * advanced mode.
	 */
	public class Renderer implements IRenderer
	{
		private var _target:BitmapData;

		public function Renderer(targetBuffer:BitmapData = null)
		{
			_target = targetBuffer;
		}

		public function draw(data:RenderFrameData, dest:Point):void
		{
			if (data.renderMode & RenderMode.NORMAL)
			{
				_target.copyPixels(data.srcData, data.srcRect, dest, null, null, data.mergeAlpha);
			}
			else if (data.renderMode & RenderMode.ALPHA)
			{
				_target.copyPixels(data.srcData, data.srcRect, dest, data.alphaData, null, data.mergeAlpha);
			}
			else if (data.renderMode & RenderMode.ADVANCED)
			{
				_target.draw(data.srcData, data.transformMx, data.colorTransform, data.blendMode);
			}
		}

		public function applyFilter(filter:BitmapFilter, region:Rectangle, dest:Point):void
		{
			_target.applyFilter(_target, region, dest, filter);
		}

		public function set targetRenderBuffer(value:BitmapData):void
		{
			_target = value;
		}
	}
}
