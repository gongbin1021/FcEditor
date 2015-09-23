package com.zhrz.flex.ui.core.toolbar
{
	import mx.collections.ArrayCollection;

	public class ToolBarViewWidgetExpressManager
	{
		public function ToolBarViewWidgetExpressManager()
		{
		}
		
		private static var instance:ToolBarViewWidgetExpressManager;
		
		public static function getInstance():ToolBarViewWidgetExpressManager{
			if(instance == null){
				instance = new ToolBarViewWidgetExpressManager();
			}
			return instance;
		}
		
		private var cache:Object = new Object();
		public function addExpress(viewId:String,expresses:ArrayCollection):void{
			for each(var item:ToolBarExtensionExpressItem in expresses){
				var key:String = viewId+":"+item.variable;
				cache[key] = item;
				item.init();
			}
		}
		
		public function executeExpress(viewId:String,newState:Object):void{
			for(var variable:String in newState){
				var key:String = viewId+":"+variable;
				var item:ToolBarExtensionExpressItem = cache[key];
				if(item){
					item.setVariableValue(newState[variable]);
				}
			}
			
			
		}
	}
}