package  com.zhrz.flex.ui.core.pageLayoutClient
{
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;

	public interface IPageLayoutClient
	{
		function getLayoutClient():IVisualElementContainer;
		
		function getVisualArea():IVisualElement;
	}
}