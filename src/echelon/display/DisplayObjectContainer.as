/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2013-12-03
 * Time: 13:37
 * To change this template use File | Settings | File Templates.
 */
package echelon.display
{
	import echelon.rendering.RenderFrameTransform;
	import echelon.timing.Time;

	public class DisplayObjectContainer extends DisplayObject
	{
		public var children:Vector.<DisplayObject> = new <DisplayObject>[];

		private var _renderTrans:RenderFrameTransform;

		override public function dispose():void
		{
			for each (var child:DisplayObject in children)
			{
				child.dispose();
			}
		}

		public function getChildByName(name:String):DisplayObject
		{
			for each (var child:DisplayObject in children)
			{
				if (child.name == name)
				{
					return child;
				}
			}

			return null;
		}

		public function addChild(obj:DisplayObject):void
		{
			if (obj != null)
			{
				children.push(obj);
				if (obj.stage == null)
				{
					obj.stage = this.stage;
				}
			}
			else
			{
				throw new Error("Passed QDisplayObject is NULL.");
			}
		}

		public function addChildAt(obj:DisplayObject, index:uint):void
		{
			if (obj != null)
			{
				if (index < children.length)
				{
					children.splice(index, 0, obj);
					if (obj.stage == null)
					{
						obj.stage = this.stage;
					}
				}
				else
				{
					throw new Error("Index is beyond bounds.");
				}
			}
			else
			{
				throw new Error("Passed QDisplayObject is NULL.");
			}
		}

		public function removeChild(obj:DisplayObject):void
		{
			if (obj != null)
			{
				var idx:int = children.indexOf(obj);
				if (idx != -1)
				{
					children.splice(idx, 1);
				}
			}
			else
			{
				throw new Error("Passed QDisplayObject is NULL or has no children.");
			}
		}

		override public function render(time:Time, transform:RenderFrameTransform = null):void
		{
			renderChildren(time, transform);    //  TODO maybe copy the method into here, to save a function call.
		}

		protected function renderChildren(time:Time, transform:RenderFrameTransform):void
		{
			_renderTrans = new RenderFrameTransform();
			_renderTrans.pos = transform.pos.add(this.pos);

			for each (var child:DisplayObject in children)
			{
				child.render(time, _renderTrans);
			}
		}
	}
}
