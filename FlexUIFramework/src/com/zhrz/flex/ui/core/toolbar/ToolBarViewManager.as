package com.zhrz.flex.ui.core.toolbar
{
	
	public class ToolBarViewManager
	{
		private static var instance:ToolBarViewManager;
		
		public static function getInstance():ToolBarViewManager{
			if(instance == null){
				instance = new ToolBarViewManager();
			}
			return instance;
		}
		
		private var cache:Object  = new Object();
		
		public function addToolBarWidget(viewId:String,widget:IToolBarWidget):void{
			var toolBarViewHBox:ToolBarViewHBox = null;
			if(cache[viewId] == null){
				toolBarViewHBox = new ToolBarViewHBox();
				cache[viewId] = toolBarViewHBox;
			}
			else{
				toolBarViewHBox = cache[viewId] as ToolBarViewHBox;
			}
			
			toolBarViewHBox.addWidget(widget,viewId);
		}
		
		public function getToolBarHbox(viewId:String):ToolBarViewHBox{
			return cache[viewId] as ToolBarViewHBox;
		}
	}
}