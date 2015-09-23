package com.zhrz.flex.ui.core.pages
{
	

	public class PageExtensionManager
	{
		private static var instance:PageExtensionManager;
		
		public static function getInstance():PageExtensionManager{
			if(instance == null){
				instance = new PageExtensionManager();
			}
			return instance;
		}
		
		private var _extension:PageExtension;
		public function getExtension():PageExtension{
			if(_extension == null){
				_extension = new PageExtension();
				_extension.beginParse();
			}
			return _extension;
		}
		
		
		
	}
}