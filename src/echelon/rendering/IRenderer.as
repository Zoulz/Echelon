/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-05
 * Time: 15:04
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

	public interface IRenderer
	{
		function simpleDraw(src:BitmapData, srcRect:Rectangle, destPoint:Point, useAlpha:Boolean = true, alpha:Number = 1):void;
		function advancedDraw(src:DisplayObject, srcRect:Rectangle, transformMx:Matrix = null, colorTransform:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null, smoothing:Boolean = false):void;
		function fillRect(rect:Rectangle, color:uint):void;
		function applyFilter(filter:BitmapFilter, region:Rectangle, dest:Point):void;

		function set targetRenderBuffer(value:BitmapData):void;
	}
}
