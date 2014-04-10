/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2014-04-07
 * Time: 11:31
 * To change this template use File | Settings | File Templates.
 */
package echelon.rendering
{
	import flash.geom.Point;

	/**
	 * Describes a render frame transformation. Used to pass transformations between child
	 * display objects along the display list.
	 */
	public class RenderFrameTransform
	{
		public var pos:Point = new Point();
		public var scale:Point = new Point();
		//  TODO Add more like: alpha, rotation etc.

		public function clear():void
		{
			pos.x = 0;
			pos.y = 0;
			scale.x = 0;
			scale.y = 0;
		}
	}
}
