/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2014-04-10
 * Time: 13:22
 * To change this template use File | Settings | File Templates.
 */
package echelon.utils
{
	import echelon.rendering.tiles.TileData;
	import echelon.rendering.tiles.TileSheet;

	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class TileSheetUtil
	{
		/**
		 * Divides existing bitmap data into tiles.
		 * @param bitmapData
		 * @param tileSize
		 * @param numRows
		 * @param numColumns
		 * @return
		 */
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

		/**
		 * Turns a collection of bitmap data into a tilesheet.
		 * @param bmps
		 * @param tileSize
		 * @param numRows
		 * @param numColumns
		 * @return
		 */
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

		/**
		 * Takes a flash sprite and turns it into a tilesheet (one tile).
		 */
		public static function fromSprite(sprite:Sprite):TileSheet
		{
			var tiles:Vector.<TileData> = new <TileData>[];
			var bitmapData:BitmapData = new BitmapData(sprite.width, sprite.height);

			tiles.push(new TileData(new Rectangle(0, 0, sprite.width, sprite.height)));
			bitmapData.draw(sprite);

			var ret:TileSheet = new TileSheet(bitmapData, tiles);
			return ret;
		}

		/**
		 * Takes a flash movieclip and turns it into a tilesheet animation sequence.
		 * @param mc
		 * @return
		 */
		public static function fromMovieClip(mc:MovieClip):TileSheet
		{
			var tiles:Vector.<TileData> = new <TileData>[];
			var curX:int = 0;
			var curY:int = 0;
			var maxX:int = 0;
			var maxY:int = 0;
			var td:TileData;

			mc.gotoAndStop(1);

			for (var i:uint = 0; i < mc.totalFrames; i++)
			{
				td = new TileData(new Rectangle(curX, curY, mc.width, mc.height));
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
			for each (td in tiles)
			{
				var pos:Matrix = new Matrix();
				pos.translate(td.rect.x, td.rect.y);
				bitmapData.draw(mc, pos);
				mc.nextFrame();
			}

			var ret:TileSheet = new TileSheet(bitmapData, tiles);
			return ret;
		}

		/**
		 * Parses supplied xml data and turns it into a tilesheet, coupled with the supplied bitmap data.
		 *
		 * <tiles>
		 *     <tile x="0" y="0" width="420" height="420" frameX="-5" frameY="20" />
		 * </tiles>
		 *
		 * @param bitmapData
		 * @param xml
		 * @return
		 */
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
	}
}
