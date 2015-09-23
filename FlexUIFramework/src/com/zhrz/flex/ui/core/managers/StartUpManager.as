package com.zhrz.flex.ui.core.managers
{
	public class StartUpManager
	{
		
		private static var instance:StartUpManager;
		
		public static function getInstance():StartUpManager{
			if(instance == null){
				instance = new StartUpManager();
			}
			return instance;
		}
		
	}
}