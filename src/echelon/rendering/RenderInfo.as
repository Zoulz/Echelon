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

	public class RenderInfo
	{
		public var sourceBmpData:BitmapData;
		public var sourceRect:Rectangle;
		public var destinationPt:Point;
		public var useTransparency:Boolean;
		public var alphaVal:Number;
		public var transformMx:Matrix;
		public var colorTransform:ColorTransform;
		public var blendMode:BlendMode;
		public var smoothing:Boolean;
	}
}
