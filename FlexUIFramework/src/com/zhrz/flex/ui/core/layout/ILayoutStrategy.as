package com.zhrz.flex.ui.core.layout
{
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElementContainer;

	public interface ILayoutStrategy
	{
		function getLayoutAreaVos(parentUi:IVisualElementContainer,layoutXml:XML,extensionId:String):ArrayCollection;
	}
}