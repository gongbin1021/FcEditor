package com.zhrz.flex.ui.core.managers
{
	import mx.collections.ArrayCollection;

	public interface IAppManager
	{
		
		function init(pluginXmlVos:ArrayCollection,swfFileBasePath:String = null):void;
		
		
		function destory():void;
		
		function addCompletedCallBack(callBack:IAppManagerCallBack):void;
		
		function removeCompletedCallBack(callBack:IAppManagerCallBack):void;
		
		
	}
}