package com.zhrz.flex.ui.core.workbench
{
	public class WorkbenchViewManager
	{
		
		private static var instance:WorkbenchViewManager;
		
		public static function getInstance():WorkbenchViewManager{
			if(instance == null){
				instance = new WorkbenchViewManager();
			}
			return instance;
		}
		
		private var cache:Object = new Object();
		
		public function setView(viewId:String,value:WorkbenchViewCanvas):void{
			if(value == null){
				delete cache[viewId];
			}
			else{
				cache[viewId] = value;
			}
		}
		
		public function getView(viewId:String):WorkbenchViewCanvas{
			return cache[viewId] as WorkbenchViewCanvas;
		}
		
	}
}