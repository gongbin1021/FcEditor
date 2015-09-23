package com.zhrz.flex.ui.core.product
{

	
	public class ProductManager
	{
		private static var instance:ProductManager;
		
		public static function getInstance():ProductManager{
			if(instance == null){
				instance = new ProductManager();
			}
			return instance;
		}
		
		
		private var _extension:ProductExtension;
		
		public function beginParseExtension():ProductExtension{
			if(_extension == null){
				_extension = new ProductExtension();
				_extension.beginParse();
			}
			
			return _extension;
		}
		
		
		
		public function getPageLayoutClientByProductName(productName:String,callBack:Function):void{
			_extension.getPageLayoutClientByProductName(productName,callBack);
		}
		
		public function getPagesByProductName(productName:String):Array{
			return _extension.getPagesByProductName(productName);
		}
		
		public function getCurrentPluginId(productName:String):String{
			return _extension.getCurrentPluginId(productName);
		}
		
	}
}