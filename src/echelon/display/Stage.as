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

	/**
	 * Stage is the equivalent of the flash Stage. This is the root node of the display list.
	 * This display object is created by Echelon internally and exposed publicly so it
	 * can be operated upon. Stage objects cannot be added to the display list.
	 */
	public final class Stage extends DisplayObjectContainer
	{
		public var renderer:IRenderer;

		/**
		 * Keep a reference to the renderer.
		 * @param renderer
		 */
		public function Stage(renderer:IRenderer)
		{
			this.renderer = renderer;
		}

		/**
		 * When something is added to this object, set it's stage reference to this.
		 * @param obj
		 */
		override public function addChild(obj:DisplayObject):void
		{
			obj.stage = this;
			super.addChild(obj);
		}

		/**
		 * Create a new render transform that will be passed down the display list, and then just
		 * iterates through it's children.
		 * @param time
		 * @param transform
		 */
		override public function render(time:Time, transform:RenderFrameTransform = null):void
		{
			_renderTrans = new RenderFrameTransform();

			_childrenLength = children.length;
			for (_iterator = 0; _iterator < _childrenLength; _iterator++)
			{
				children[_iterator].render(time, _renderTrans);
			}
		}
	}
}
