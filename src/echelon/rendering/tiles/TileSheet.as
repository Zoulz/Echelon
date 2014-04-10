package echelon.rendering.tiles
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	/**
	 * A tilesheet holds a texture and a list of data describing each tile.
	 */
	public class TileSheet
	{
		protected var _data:BitmapData;
		protected var _compressedData:ByteArray;
		protected var _tiles:Vector.<TileData>;
		protected var _isCompressed:Boolean = false;

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

		public function compress():void
		{
			if (!_isCompressed)
			{
				_compressedData = new ByteArray();
				_compressedData.writeUnsignedInt(_data.width);
				_compressedData.writeBytes(_data.getPixels(_data.rect));
				_compressedData.compress();

				_data.dispose();
				_data = null;

				_isCompressed = true;
			}
			else
			{
				throw new Error("Bitmap data is already compressed.");
			}
		}

		public function uncompress():void
		{
			if (_isCompressed)
			{
				_compressedData.uncompress();

				var width:uint = _compressedData.readUnsignedInt();
				var height:uint = ((_compressedData.length - 4) / 4) / width;
				_data = new BitmapData(width, height, true, 0);
				_data.setPixels(_data.rect, _compressedData);

				_compressedData = null;

				_isCompressed = false;
			}
			else
			{
				throw new Error("Bitmap data is already uncompressed.");
			}
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

		public function get isCompressed():Boolean
		{
			return _isCompressed;
		}
	}
}
