package com.zhrz.flex.ui.core.layout
{
	import mx.core.IVisualElementContainer;

	public interface ILayoutAreaVo
	{
		function get id():String;
		
		function set id(value:String):void;
		
		function get isTab():String;
		
		function set isTab(value:String):void;
		
		function get superTab():Boolean;
		
		function set superTab(value:Boolean):void;
		
		function set layoutArea(value:IVisualElementContainer):void;
		
		function get layoutArea():IVisualElementContainer;
	}
}