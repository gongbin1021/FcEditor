package com.zhrz.flex.ui.core.layoutview
{


	public class LayoutViewExtensionManager
	{
		private static var instance:LayoutViewExtensionManager;
		
		public static function getInstance():LayoutViewExtensionManager{
			if(instance == null){
				instance = new LayoutViewExtensionManager();
			}
			return instance;
		}
		
		
		private var extension:LayoutViewExtension;
		
		public function getExtension():LayoutViewExtension{
			if(extension == null){
				extension = new LayoutViewExtension();
				extension.beginParse();
			}
			
			return extension;
		}
	}
}