package com.zhrz.flex.ui.core.plugin
{
	import com.zhrz.flex.ui.core.extension.ExtensionPointManager;
	import com.zhrz.flex.ui.core.extension.ExtensionPointVo;
	import com.zhrz.flex.ui.core.extension.ExtensionVo;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionDefine;
	import com.zhrz.flex.ui.core.workbench.WorkbenchPlugin;
	
	import mx.collections.ArrayCollection;
	
	public class PluginManager
	{
		private static var instance:PluginManager;
		
		public static function getInstance():PluginManager{
			if(instance == null){
				instance = new PluginManager();
			}
			return instance;
		}
		
		
		
		private var stateNotifyer:IPluginParseStateChanged;
		private var originalPluginVos:ArrayCollection;
		
		private var allPlugins:ArrayCollection = new ArrayCollection();
		private var pluginVoMap:Object = new Object();
		
		
		private var pluginLoaderMap:Object = new Object();
		private var swfFileBasePath:String = null;
		
		public function getPluginLoader(pluginId:String):PluginLoader{
			return pluginLoaderMap[pluginId] as PluginLoader;
		}
		
		public function loadPlugin(pluginId:String,callBack:Function):void{
			//this.swfFileBasePath = swfFileBasePath;
			var pluginVo:PluginVo = pluginVoMap[pluginId] as PluginVo;
			var plugloader:PluginLoader = new PluginLoader(pluginId,pluginVo.swf,this.swfFileBasePath);
			
			var loadCompletedCallBack:Function = function():void{
				callBack(plugloader);
			};
			
			plugloader.beginLoad(loadCompletedCallBack);
			pluginLoaderMap[pluginId] = plugloader;
		}
		
		public function getAllExtensionByExtensionId(extensionId:String):ArrayCollection{
			return ExtensionPointManager.getInstance().getAllExtensionByExtensionId(extensionId);
		}
		
		public function parsePluginXmls(pluginXmlVos:ArrayCollection,parsePluginXmlStateCallBack:IPluginParseStateChanged,swfFileBasePath:String):void{
			this.swfFileBasePath = swfFileBasePath;
			this.originalPluginVos = pluginXmlVos;
			this.stateNotifyer = parsePluginXmlStateCallBack;
			
			stateNotifyer.parsePluginStateChanged(PluginParseState.PLUGIN_PARSE_BEGIN_STATE);
			
			parseAllExtensionPoint();
			parseAllExtension();
			
			stateNotifyer.parsePluginStateChanged(PluginParseState.PLUGIN_PARSE_COMPLETED_STATE);
			
			startUpWorkbenchPlugin();
			
			stateNotifyer.parsePluginStateChanged(PluginParseState.PLUGIN_WORKBENCH_STARTUP_STATE);
			
			
		}
		
		private function startUpWorkbenchPlugin():void{
			var pluginLoader:PluginLoader = new PluginLoader(FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID,null,null);
			pluginLoader.pluginId = FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID;
			pluginLoader.plugin = new WorkbenchPlugin();
			pluginLoaderMap[pluginLoader.pluginId] = pluginLoader;
		}
		
		private function parseAllExtensionPoint():void{
			stateNotifyer.parsePluginStateChanged(PluginParseState.PLUGIN_PARSE_EXTENSIONPOINT_STATE);
			for each(var vo:PluginXmlVo in originalPluginVos){
				var pluginXml:XML = new XML(vo.xmlContent);
				parseExtensionPoint(pluginXml);
			}
		}
		
		private function parseAllExtension():void{
			stateNotifyer.parsePluginStateChanged(PluginParseState.PLUGIN_PARSE_EXTENSION_STATE);
			for each(var vo:PluginXmlVo in originalPluginVos){
				var pluginXml:XML = new XML(vo.xmlContent);
				parseExtension(pluginXml);
			}
		}
		
		private function parseExtensionPoint(pluginXml:XML):void{
			var pluginVo:PluginVo = new PluginVo();
			allPlugins.addItem(pluginVo);
			
			pluginVo.id = pluginXml.@id;
			pluginVo.name = pluginXml.@name;
			pluginVo.version = pluginXml.@version;
			pluginVo.swf = pluginXml.@swf;
			
			pluginVoMap[pluginVo.id] = pluginVo;
			
			var extensionPointXmllist:XMLList = pluginXml.child("extensionPoint");
			for(var i:int = 0 ; i < extensionPointXmllist.length();i++){
				var extensionPointXml:XML = extensionPointXmllist[i];
				var extensionPoint:ExtensionPointVo = new ExtensionPointVo();
				pluginVo.extensionPoint.addItem(extensionPoint);
				
				extensionPoint.id = pluginVo.id+"."+extensionPointXml.@id;
				extensionPoint.name = extensionPointXml.@name;
				extensionPoint.pluginId = pluginVo.id;
				
				ExtensionPointManager.getInstance().addExtensionPoint(extensionPoint);
			}
			
		}
		
		private function parseExtension(pluginXml:XML):void{
			var pluginId:String = pluginXml.@id;
			var pluginVo:PluginVo = getPluginVoById(pluginId);
			
			var extensionXmllist:XMLList = pluginXml.child("extension");
			for(var i:int = 0 ; i < extensionXmllist.length();i++){
				var extensionXml:XML = extensionXmllist[i];
				
				var extensionVo:ExtensionVo = new ExtensionVo();
				extensionVo.id = pluginId + "." + extensionXml.@id;
				extensionVo.extensionPointId = extensionXml.@point;
				extensionVo.pluginId = pluginId;
				extensionVo.childrenXml = extensionXml.children();
				
				pluginVo.extensions.addItem(extensionVo);
				ExtensionPointManager.getInstance().addExtension(extensionVo,extensionVo.extensionPointId);
				
				
			}
		}
		
		public function getPluginVoById(id:String):PluginVo{
			return pluginVoMap[id] as PluginVo;
		}
	}
}