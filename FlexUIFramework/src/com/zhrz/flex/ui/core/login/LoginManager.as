package com.zhrz.flex.ui.core.login
{
	
	public class LoginManager
	{
		private static var instance:LoginManager;
		
		public static function getInstance():LoginManager{
			if(instance == null){
				instance = new LoginManager();
			}
			return instance;
		}
		
		public static var isLogin:Boolean = false;
	}
}