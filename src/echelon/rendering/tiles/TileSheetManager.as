/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2014-03-18
 * Time: 14:03
 * To change this template use File | Settings | File Templates.
 */
package echelon.rendering.tiles
{
	import flash.utils.Dictionary;

	/**
	 * The tilesheet manager holds static references to tilesheets for easy (lazy) access.
	 */
	public class TileSheetManager
	{
		private static var _TILESHEETS:Dictionary = new Dictionary();

		public static function registerTileSheet(id:String, tilesheet:TileSheet):void
		{
			_TILESHEETS[id] = tilesheet;
		}

		public static function unregisterTileSheet(id:String):void
		{
			_TILESHEETS[id] = null;
		}

		public static function getTileSheet(id:String):TileSheet
		{
			return _TILESHEETS[id];
		}
	}
}
