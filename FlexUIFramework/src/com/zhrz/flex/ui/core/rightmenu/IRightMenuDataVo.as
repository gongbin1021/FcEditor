package com.zhrz.flex.ui.core.rightmenu
{
	public interface IRightMenuDataVo
	{
		function get label():String;
		
		
		function set label(value:String):void;
		
		
		function get enabled():Boolean;
		
		function set enabled(value:Boolean):void;
		
		
		function get commandId():String;
		
		function set commandId(value:String):void;
		
		
		function get children():Array;
		
		
		function set children(value:Array):void;
		
		function get data():String;
		
		function set data(value:String):void;
	}
}