package echelon.rendering.tiles
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * A tilesheet holds a texture and a list of data describing each tile.
	 */
	public class TileSheet
	{
		protected var _data:BitmapData;
		protected var _tiles:Vector.<TileData>;

		public function TileSheet(data:BitmapData, tilesDef:Vector.<TileData>)
		{
			_data = data;
			_tiles = tilesDef;
		}

		public function dispose():void
		{
			_data.dispose();
			_tiles = null;
		}

		public function getTileData(index:uint):TileData
		{
			return _tiles[index];
		}

		public function get length():uint
		{
			return _tiles.length;
		}

		public function get data():BitmapData
		{
			return _data;
		}
	}
}
