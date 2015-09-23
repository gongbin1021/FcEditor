package com.zhrz.flex.ui.core.extension
{
	import com.zhrz.flex.ui.core.plugin.PluginLoader;
	import com.zhrz.flex.ui.core.plugin.PluginManager;

	public class AbstractExtensionDescriptor
	{
		public var id:String;
		public var pluginId:String;
		public var extensionXml:XML
		
		public function AbstractExtensionDescriptor(id:String)
		{
			this.id = id;
		}
		
		public function init(xml:XML):void{
			this.extensionXml = xml;
		}
		
		public function createObject(className:String,callBack:Function,param:Object = null):void{
			var pluginLoader:PluginLoader = PluginManager.getInstance().getPluginLoader(pluginId);
			if(pluginLoader == null){
				
				var getPluginLoader:Function = function(loader:PluginLoader):void{
					if(callBack != null){
						var instance:Object = loader.create([className]);
						if(param == null){
							callBack(instance);
						}
						else{
							callBack(instance,param);
						}
					}
				};
				
				PluginManager.getInstance().loadPlugin(pluginId,getPluginLoader);
			}
			else{
				
				if(pluginLoader.getIsLoading()){
					pluginLoader.addLoadingCreate([className],callBack,param);
				}
				else{
					var obj:Object = pluginLoader.create([className]);
					if(callBack != null){
						if(param == null){
							callBack(obj);
						}
						else{
							callBack(obj,param);
						}
					}
				}
				
				
			}
		}
	}
}