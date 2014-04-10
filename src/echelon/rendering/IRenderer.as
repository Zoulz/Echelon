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

	/**
	 * Describes a renderer.
	 */
	public interface IRenderer
	{
		/**
		 * Performs a render using the supplied data and destination point.
		 * @param data
		 * @param dest
		 */
		function draw(data:RenderFrameData, dest:Point):void;

		/**
		 * Applies a filter to the specified region and destination point.
		 * @param filter
		 * @param region
		 * @param dest
		 */
		function applyFilter(filter:BitmapFilter, region:Rectangle, dest:Point):void;

		/**
		 * Sets reference to the target rendering bitmap data buffer.
		 * @param value
		 */
		function set targetRenderBuffer(value:BitmapData):void;
	}
}
