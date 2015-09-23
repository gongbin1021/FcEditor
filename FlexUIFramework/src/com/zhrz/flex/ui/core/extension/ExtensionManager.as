package com.zhrz.flex.ui.core.extension
{

	public class ExtensionManager
	{
		private static var instance:ExtensionManager;
		
		public static function getInstance():ExtensionManager{
			if(instance == null){
				instance = new ExtensionManager();
			}
			return instance;
		}
		
		
		private var cahce:Object = new Object();
		
		
		
	}
}