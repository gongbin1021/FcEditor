package com.zhrz.flex.ui.core.view
{

	public class ViewExtensionManager
	{
		private static var instance:ViewExtensionManager;
		
		public static function getInstance():ViewExtensionManager{
			if(instance == null){
				instance = new ViewExtensionManager();
			}
			return instance;
		}
		
		private var extension:ViewExtension;
		
		public function getExtension():ViewExtension{
			if(extension == null){
				extension = new ViewExtension();
				extension.beginParse();
			}
			return extension;
		}
		
	}
}