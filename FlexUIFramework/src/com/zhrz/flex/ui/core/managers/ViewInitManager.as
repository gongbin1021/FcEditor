package com.zhrz.flex.ui.core.managers
{
	public class ViewInitManager
	{
		private static var instance:ViewInitManager;
		
		public static function getInstance():ViewInitManager{
			if(instance == null){
				instance = new ViewInitManager();
			}
			return instance;
		}
		
		
		private var cache:Object = {};
		
		public function addInitViewId(viewId:String):void{
			cache[viewId] = false;
		}
		
		public function addInitCompletedViewId(viewId:String):void{
			if(cache == null) return;
			cache[viewId] = true;
			
			if(checkAllInitCompleted()){
				notifyAllViewInitCompleted();
			}
		}
		
		private function checkAllInitCompleted():Boolean{
			for(var viewId:String in cache){
				if(cache[viewId] == false) return false;
			}
			return true;
		}
		
		private function notifyAllViewInitCompleted():void{
			ViewInitClientManager.getInstance().notify();
			ViewInitClientManager.getInstance().clean();
			cache = null;
		}
	}
}