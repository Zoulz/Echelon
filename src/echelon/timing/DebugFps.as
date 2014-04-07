/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-03
 * Time: 10:49
 * To change this template use File | Settings | File Templates.
 */
package echelon.timing
{
	import flash.display.Sprite;
	import flash.text.TextField;

	public class DebugFps extends Sprite
	{
		private var _time:Time;
		private var _count:Number;
		private var _frames:uint;
		private var _tf:TextField;

		public function DebugFps(time:Time)
		{
			_time = time;
			_count = 0;
			_frames = 0;

			_tf = new TextField();
			_tf.textColor = 0x000000;
			_tf.x = 5;
			_tf.y = 5;
			addChild(_tf);
		}

		public function update():void
		{
			_count += _time.frameTime.milliseconds;
			_frames++;

			if (_count >= 1000)
			{
				_count -= 1000;
				_tf.text = _frames.toString();
				_frames = 0;
			}
		}
	}
}
