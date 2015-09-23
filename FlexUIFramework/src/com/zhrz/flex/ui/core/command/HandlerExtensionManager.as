package com.zhrz.flex.ui.core.command
{
	
	public class HandlerExtensionManager
	{
		private static var instance:HandlerExtensionManager;
		
		public static function getInstance():HandlerExtensionManager{
			if(instance == null){
				instance = new HandlerExtensionManager();
			}
			return instance;
		}
		
		private var extension:HandlerExtension;
		
		public function getExtension():HandlerExtension{
			if(extension == null){
				extension = new HandlerExtension();
				extension.beginParse();
			}
			
			return extension;
		}
	}
}