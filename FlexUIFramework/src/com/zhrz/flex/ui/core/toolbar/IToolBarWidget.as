package com.zhrz.flex.ui.core.toolbar
{
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElement;

	public interface IToolBarWidget
	{
		
		function getWidget():IVisualElement;
		function getCommandId():String;
		function getId():String;
		
		function get label():String;
		
		function get toolTip():String;
		
		function get styleName():String;
		
		function getExpresses():ArrayCollection;
	}
}