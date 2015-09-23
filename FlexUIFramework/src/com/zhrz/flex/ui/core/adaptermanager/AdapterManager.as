package com.zhrz.flex.ui.core.adaptermanager
{
	import avmplus.getQualifiedClassName;

	public class AdapterManager
	{
		
		private static var instance:AdapterManager;
		
		public function AdapterManager()
		{
		}
		
		public static function getInstance():AdapterManager{
			if(instance == null){
				instance = new AdapterManager();
			}
			return instance;
		}
		
		private var _extension:AdapterExtension;
		
		private function getExtension():AdapterExtension{
			if(_extension == null){
				_extension = new AdapterExtension();
				_extension.beginParse();
			}
			return _extension;
		}
		
		public function getAdapter(adapterObject:Object,adapterType:String,callBack:Function,param:Object = null):void{
			getExtension().getAdapter(adapterObject,adapterType,callBack,param);
		}
	}
}