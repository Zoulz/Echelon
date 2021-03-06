/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-03
 * Time: 13:43
 * To change this template use File | Settings | File Templates.
 */
package echelon.rendering.tiles
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * Holds information about a tile inside a tilesheet. The rectangle region of the texture
	 * and a offset.
	 */
	public class TileData
	{
		public var rect:Rectangle;
		public var offset:Point;

		public function TileData(rect:Rectangle = null, offset:Point = null)
		{
			rect == null ? this.rect = new Rectangle() : this.rect = rect;
			offset == null ? this.offset = new Point() : this.offset = offset;
		}

		public function toString():String
		{
			return rect.toString();
		}
	}
}
