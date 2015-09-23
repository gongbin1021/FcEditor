package com.zhrz.flex.ui.core.plugin
{
	public interface IPlugin
	{
		function create(params:Array = null):Object;
		
		function init(param:Object=null):void;
	}
}