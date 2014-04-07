/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2014-04-04
 * Time: 14:02
 * To change this template use File | Settings | File Templates.
 */
package echelon.samples
{
	import echelon.Echelon;
	import echelon.display.MovieClip;
	import echelon.rendering.Renderer;
	import echelon.rendering.TileSheet;
	import echelon.rendering.TileSheetFactory;
	import echelon.timing.Time;
	import echelon.timing.timers.EventBasedTimer;

	import flash.display.Sprite;

	import flash.geom.Rectangle;

	[SWF(width = "800", height = "600", frameRate = "30")]
	public class MovieClipTest extends flash.display.Sprite
	{
		private var _echelon:Echelon;
		private var _mc:echelon.display.MovieClip;

		private const GUYBRUSH_WALK_TILESHEET:String = "guybrush_walk";

		[Embed(source="../../../assets/gb_walk.png")]
		private var GuybrushWalk:Class;

		public function MovieClipTest()
		{
			_echelon = new Echelon(new Rectangle(0, 0, 800, 600));
			_echelon.renderer = new Renderer();
			_echelon.timer = new EventBasedTimer();
			_echelon.tickCallback = ticker;

			addChild(_echelon.displayBitmap);

			addContent();

			_echelon.start();
		}

		private function ticker(time:Time):void
		{

		}

		private function addContent():void
		{
			//	Create a tilesheet.
			TileSheetFactory.registerTileSheet(GUYBRUSH_WALK_TILESHEET, TileSheet.fromBitmapData(new GuybrushWalk().bitmapData, new Rectangle(0, 0, 104, 150), 1, 6));

			//	Create a movieclip that utilizes the tilesheet.
			_mc = new MovieClip(10, true);
			_mc.tileSheet = TileSheetFactory.getTileSheet(GUYBRUSH_WALK_TILESHEET);
			_mc.pos.x = 40;
			_mc.pos.y = 50;
			_mc.play();

			//	Add it to stage.
			_echelon.stage.addChild(_mc);
		}
	}
}
