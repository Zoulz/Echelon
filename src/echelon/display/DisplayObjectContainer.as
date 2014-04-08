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

		public function addChild(obj:QDisplayObject):void
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
				throw new Error("Passed DisplayObject is NULL.");
			}
		}

		public function addChildAt(obj:QDisplayObject, index:uint):void
		{
			if (obj != null)
			{
				if (children.length == 0 || index < children.length)
				{
					children.splice(index, 0, obj);
				}
				else
				{
					throw new Error("Index is beyond bounds.");
				}

				if (obj.stage == null)
				{
					obj.stage = this.stage;
				}
			}
			else
			{
				throw new Error("Passed DisplayObject is NULL.");
			}
		}

		public function removeChild(obj:QDisplayObject):void
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
				throw new Error("Passed DisplayObject is NULL or has no children.");
			}
		}

		public function removeChildAt(index:int):void
		{
			if (index < children.length)
			{
				children.splice(index, 1);
			}
			else
			{
				throw new Error("Index is beyond bounds.");
			}
		}

		override public function render(time:Time, transform:RenderFrameTransform = null):void
		{
			//  This is just a copy of the 'renderChildren' method that is used by subclasses.
			//  We want to avoid a extra function call here, so that's why.
			_renderTrans = new RenderFrameTransform();
			_renderTrans.pos = transform.pos.add(this.pos);

			var len:int = children.length;
			for (var i:int = 0; i < len; i++)
			{
				children[i].render(time, _renderTrans);
			}
		}

		protected function renderChildren(time:Time, transform:RenderFrameTransform):void
		{
			_renderTrans = new RenderFrameTransform();
			_renderTrans.pos = transform.pos.add(this.pos);

			var len:int = children.length;
			for (var i:int = 0; i < len; i++)
			{
				children[i].render(time, _renderTrans);
			}
		}
	}
}
