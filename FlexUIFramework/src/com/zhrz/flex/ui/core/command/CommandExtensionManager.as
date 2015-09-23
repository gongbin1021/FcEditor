package com.zhrz.flex.ui.core.command
{
	public class CommandExtensionManager
	{
		private static var instance:CommandExtensionManager;
		
		public static function getInstance():CommandExtensionManager{
			if(instance == null){
				instance = new CommandExtensionManager();
			}
			return instance;
		}
		
		private var extension:CommandExtension;
		
		public function getExtension():CommandExtension{
			if(extension == null){
				extension = new CommandExtension();
				extension.beginParse();
			}
			
			return extension;
		}
		
	}
}