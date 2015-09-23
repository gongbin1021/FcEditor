package com.zhrz.flex.ui.core.managers
{
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionDefine;
	import com.zhrz.flex.ui.core.login.LoginManager;
	import com.zhrz.flex.ui.core.plugin.IPluginParseStateChanged;
	import com.zhrz.flex.ui.core.plugin.PluginManager;
	import com.zhrz.flex.ui.core.plugin.PluginParseState;
	import com.zhrz.flex.ui.core.plugin.PluginXmlVo;
	
	import mx.collections.ArrayCollection;

	public class AppManager implements IAppManager,IPluginParseStateChanged
	{
		private static var instance:AppManager;
		
		public static function getInstance():AppManager{
			if(instance == null){
				instance = new AppManager();
			}
			return instance;
		}
		
		private var callBackArray:Array = [];
		private var swfFileBasePath:String;
		
		public function init(pluginXmlVos:ArrayCollection,swfFileBasePath:String = null):void{
			this.swfFileBasePath = swfFileBasePath;
			pluginXmlVos = pretreat(pluginXmlVos);
			PluginManager.getInstance().parsePluginXmls(pluginXmlVos,this,swfFileBasePath);
		
		}
		
		//预处理
		private function pretreat(pluginXmlVos:ArrayCollection):ArrayCollection{
			if(pluginXmlVos == null){
				pluginXmlVos = new ArrayCollection();
			}
			var workbenchPluginVo:PluginXmlVo = new PluginXmlVo();
			workbenchPluginVo.pluginId = FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID;
			workbenchPluginVo.xmlContent = FrameworkExtensionDefine.getWorkbenchPluginConfigXml();
			pluginXmlVos.addItemAt(workbenchPluginVo,0);
			return pluginXmlVos;
		}
		
		public function parsePluginStateChanged(state:String):void{
			if(state == PluginParseState.PLUGIN_WORKBENCH_STARTUP_STATE){
				
				if(LoginManager.isLogin){
					
				}
				else{
					initProduct();
				}
				
			}
		}
		
		private function initProduct():void{
			for each(var callBack:IAppManagerCallBack in callBackArray){
				callBack.coreLoadCompleted();
			}
		}
		
		public function destory():void{
			callBackArray = null;
		}
		
		public function addCompletedCallBack(callBack:IAppManagerCallBack):void{
			if(callBackArray.indexOf(callBack) == -1){
				callBackArray.push(callBack);
			}
		}
		
		public function removeCompletedCallBack(callBack:IAppManagerCallBack):void{
			var index:int = callBackArray.indexOf(callBack);
			if(index != -1){
				callBackArray.splice(index,1);
			}
		}
		
		private function notifyCompletedCallBack():void{
			for each(var callBack:IAppManagerCallBack in callBackArray){
				callBack.coreLoadCompleted();
			}
		}
		
		
		
	}
}