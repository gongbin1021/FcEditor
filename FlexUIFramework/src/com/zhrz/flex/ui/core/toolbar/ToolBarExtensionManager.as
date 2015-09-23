package com.zhrz.flex.ui.core.toolbar
{

	public class ToolBarExtensionManager
	{
		private static var instance:ToolBarExtensionManager;
		
		public static function getInstance():ToolBarExtensionManager{
			if(instance == null){
				instance = new ToolBarExtensionManager();
			}
			return instance;
		}
		
		private var _extension:ToolBarExtension;
		
		public function getExtension():ToolBarExtension{
			if(_extension ==null){
				_extension = new ToolBarExtension();
				_extension.beginParse();
			}
			return _extension;
		}
		
	}
}