/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-03
 * Time: 10:05
 * To change this template use File | Settings | File Templates.
 */
package echelon.timing
{
	public class TimeUnit
	{
		private var _ms:int;

		public function TimeUnit(ms:int = 0)
		{
			_ms = ms;
		}

		public function clone():TimeUnit
		{
			return new TimeUnit(_ms);
		}

		public function addUnit(time:TimeUnit):void
		{
			_ms += time.milliseconds;
		}

		public function add(ms:int):void
		{
			_ms += ms;
		}

		public function get milliseconds():int
		{
			return _ms;
		}

		public function set milliseconds(value:int):void
		{
			_ms = value;
		}

		public function get seconds():Number
		{
			return _ms * 0.001;
		}

		public function get minutes():Number
		{
			return (_ms * 0.001) / 60;
		}

		public function get hours():Number
		{
			return ((_ms * 0.001) / 60) / 60;
		}

		public function toString():String
		{
			return _ms.toString();
		}
	}
}
