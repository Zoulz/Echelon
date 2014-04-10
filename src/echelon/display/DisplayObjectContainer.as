package echelon.display
{
	import echelon.rendering.RenderFrameTransform;
	import echelon.timing.Time;

	/**
	 * Adds the functionality to have child display objects under this
	 * display object.
	 */
	public class DisplayObjectContainer extends DisplayObject
	{
		public var children:Vector.<DisplayObject> = new <DisplayObject>[];

		protected var _renderTrans:RenderFrameTransform = new RenderFrameTransform();
		protected var _childrenLength:int;
		protected var _iterator:int;

		/**
		 * Disposes all of the child objects.
		 */
		override public function dispose():void
		{
			_childrenLength = children.length;
			for (var i:int = 0; i < _childrenLength; i++)
			{
				children[i].dispose();
			}
		}

		/**
		 * Return a child display object by it's name, or NULL if it's not found.
		 * @param name
		 * @return
		 */
		public function getChildByName(name:String):DisplayObject
		{
			_childrenLength = children.length;
			for (var i:int = 0; i < _childrenLength; i++)
			{
				if (children[i].name == name)
				{
					return children[i];
				}
			}

			return null;
		}

		/**
		 * Add a display object at the end of the list.
		 * @param obj
		 */
		public function addChild(obj:DisplayObject):void
		{
			if (obj != null && !(obj is Stage))
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

		/**
		 * Insert a display object at the specified index of the list.
		 * @param obj
		 * @param index
		 */
		public function addChildAt(obj:DisplayObject, index:uint):void
		{
			if (obj != null && !(obj is Stage))
			{
				if (children.length == 0 || index <= children.length)
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

		/**
		 * Remove a display object from the list.
		 * @param obj
		 */
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
				throw new Error("Passed DisplayObject is NULL or has no children.");
			}
		}

		/**
		 * Remove a display object at the specified index from the list.
		 * @param index
		 */
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

		/**
		 * Addes the transforms from the previous display object and the transverses through
		 * the list of children.
		 * @param time
		 * @param transform
		 */
		override public function render(time:Time, transform:RenderFrameTransform = null):void
		{
			_renderTrans.clear();
			_renderTrans.pos = transform.pos.add(this.pos);

			_childrenLength = children.length;
			for (_iterator = 0; _iterator < _childrenLength; _iterator++)
			{
				children[_iterator].render(time, _renderTrans);
			}
		}
	}
}
