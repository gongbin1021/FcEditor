package  com.zhrz.flex.ui.core.pageLayoutClient
{


	public class PageLayoutClientExtensionManager
	{
		
		private static var instance:PageLayoutClientExtensionManager;
		
		public static function getInstance():PageLayoutClientExtensionManager{
			if(instance == null){
				instance = new PageLayoutClientExtensionManager();
			}
			return instance;
		}
		
		private var _extension:PageLayoutClientExtension;
		
		public function beginParseExtension():PageLayoutClientExtension{
			if(_extension == null){
				_extension = new PageLayoutClientExtension();
				_extension.beginParse();
			}
			
			return _extension;
		}
		
		public function getPluginPageLayoutClient(pluginId:String,callBack:Function):void{
			_extension.getPluginPageLayoutClient(pluginId,callBack);
		}
		
		public function getPluginPageLayoutClientById(id:String,callBack:Function):void{
			_extension.getPluginPageLayoutClientById(id,callBack);
		}
	}
}