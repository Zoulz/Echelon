/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-03
 * Time: 11:59
 * To change this template use File | Settings | File Templates.
 */
package echelon.display
{
	import echelon.rendering.IRenderer;
	import echelon.rendering.RenderFrameTransform;
	import echelon.timing.Time;

	public final class Stage extends DisplayObjectContainer
	{
		public var renderer:IRenderer;

		private var _renderTrans:RenderFrameTransform;

		public function Stage(renderer:IRenderer)
		{
			this.renderer = renderer;
		}

		override public function addChild(obj:DisplayObject):void
		{
			obj.stage = this;
			super.addChild(obj);
		}

		override public function render(time:Time, transform:RenderFrameTransform = null):void
		{
			_renderTrans = new RenderFrameTransform();

			for each (var child:DisplayObject in children)
			{
				child.render(time, _renderTrans);
			}
		}
	}
}
