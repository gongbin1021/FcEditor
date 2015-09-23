package com.zhrz.flex.ui.core.layout
{
	
	
	public class LayoutExtensionManager
	{
		private static var instance:LayoutExtensionManager;
		
		public static function getInstance():LayoutExtensionManager{
			if(instance == null){
				instance = new LayoutExtensionManager();
			}
			return instance;
		}
		
		private var extension:LayoutExtension;
		public function getExtension():LayoutExtension{
			if(extension == null){
				extension = new LayoutExtension();
				extension.beginParse();
			}
			return extension;
		}
	}
}