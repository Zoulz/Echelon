/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-13
 * Time: 12:03
 * To change this template use File | Settings | File Templates.
 */
package echelon.rendering
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * Provides data about the render to be made, passed to the renderer.
	 */
	public class RenderFrameData
	{
		public var srcData:BitmapData;
		public var alphaData:BitmapData;
		public var srcRect:Rectangle = new Rectangle();
		public var mergeAlpha:Boolean = true;
		public var renderMode:int = RenderMode.NORMAL;
		public var alpha:Number = 1;
		public var transformMx:Matrix = new Matrix();
		public var colorTransform:ColorTransform = new ColorTransform();
		public var blendMode:String = BlendMode.NORMAL;
	}
}
