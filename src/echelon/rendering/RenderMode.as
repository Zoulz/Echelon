/**
 * Created with IntelliJ IDEA.
 * User: Tomas Augustinovic
 * Date: 2014-04-10
 * Time: 13:23
 * To change this template use File | Settings | File Templates.
 */
package echelon.rendering
{
	/**
	 * Defines which mode of rendering to use.
	 */
	public class RenderMode
	{
		/**
		 * Indicates that nothing out of the ordinary (copy pixels from source to destination) is going on.
		 */
		public static const NORMAL:int = 1;
		/**
		 * Means that the resulting render is not opaque and will be rendered with a alpha value.
		 * Rendering with alpha adds a bit of overhead.
		 */
		public static const ALPHA:int = 2;
		/**
		 * Allows to use more advanced rendering techniques such a blend modes and color transforms.
		 * This is the most performance intense mode of rendering. Use sparingly.
		 */
		public static const ADVANCED:int = 4;
	}
}
