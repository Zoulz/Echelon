/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-03
 * Time: 09:59
 * To change this template use File | Settings | File Templates.
 */
package echelon.rendering
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class TileSheet
	{
		private var _data:BitmapData;
		private var _tiles:Vector.<TileData>;

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

		public static function fromBitmapData(bitmapData:BitmapData, tileSize:Rectangle, numRows:uint, numColumns:uint):TileSheet
		{
			var tiles:Vector.<TileData> = new <TileData>[];

			for (var col:uint = 0; col < numColumns; col++)
			{
				for (var row:uint = 0; row < numRows; row++)
				{
					var posRect:Rectangle = tileSize.clone();
					posRect.x = tileSize.width * col;
					posRect.y = tileSize.height * row;
					tiles.push(new TileData(posRect));
				}
			}

			var ret:TileSheet = new TileSheet(bitmapData, tiles);

			return ret;
		}

		public static function fromBitmapDataCollection(bmps:Vector.<BitmapData>, tileSize:Rectangle, numRows:uint, numColumns:uint):TileSheet
		{
			var bitmapData:BitmapData = new BitmapData(numColumns * tileSize.x, numRows * tileSize.y);
			var count:uint = 0;

			for (var col:uint = 0; col < numColumns; col++)
			{
				for (var row:uint = 0; row < numRows; row++)
				{
					if (count < bmps.length)
					{
						bitmapData.copyPixels(bmps[count], tileSize, new Point(col * tileSize.x, row * tileSize.y));
						count++;
					}
				}
			}

			return fromBitmapData(bitmapData, tileSize, numRows, numColumns);
		}

		public static function fromSprite(sprite:Sprite):TileSheet
		{
			var tiles:Vector.<TileData> = new <TileData>[];
			var bitmapData:BitmapData = new BitmapData(sprite.width, sprite.height);

			tiles.push(new TileData(new Rectangle(0, 0, sprite.width, sprite.height)));
			bitmapData.draw(sprite);

			var ret:TileSheet = new TileSheet(bitmapData, tiles);
			return ret;
		}

		public static function fromMovieClip(mc:MovieClip):TileSheet
		{
			var tiles:Vector.<TileData> = new <TileData>[];
			var curX:int = 0;
			var curY:int = 0;
			var maxX:int = 0;
			var maxY:int = 0;

			mc.gotoAndStop(1);

			for (var i:uint = 0; i < mc.totalFrames; i++)
			{
				var td:TileData = new TileData(new Rectangle(curX, curY, mc.width, mc.height));
				tiles.push(td);

				mc.nextFrame();
				curX += mc.width;

				if (curX > maxX)
				{
					maxX = curX;
				}

				if (curX > 512)
				{
					curX = 0;
					curY += mc.height;
				}

				if (curY + mc.height > maxY)
				{
					maxY = curY + mc.height;
				}
			}

			mc.gotoAndStop(1);

			var bitmapData:BitmapData = new BitmapData(Math.round(maxX), Math.round(maxY), true, 0x00000000);
			for each (var td:TileData in tiles)
			{
				var pos:Matrix = new Matrix();
				pos.translate(td.rect.x, td.rect.y);
				bitmapData.draw(mc, pos);
				mc.nextFrame();
			}

			var ret:TileSheet = new TileSheet(bitmapData, tiles);
			return ret;
		}

		public static function fromXml(bitmapData:BitmapData, xml:XML):TileSheet
		{
			var tiles:Vector.<TileData> = new <TileData>[];

			for each (var tile:XML in xml.children())
			{
				var td:TileData = new TileData(new Rectangle(tile.@x, tile.@y, tile.@width, tile.@height), new Point(tile.@frameX, tile.@frameY));
				tiles.push(td);
			}

			var ret:TileSheet = new TileSheet(bitmapData, tiles);

			return ret;
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
