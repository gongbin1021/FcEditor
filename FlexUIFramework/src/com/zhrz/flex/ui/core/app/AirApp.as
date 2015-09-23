package com.zhrz.flex.ui.core.app
{
	import com.zhrz.flex.ui.core.managers.AppManager;
	import com.zhrz.flex.ui.core.managers.IAppManagerCallBack;
	import com.zhrz.flex.ui.core.workbench.Platform;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import spark.components.WindowedApplication;
	
	public class AirApp extends WindowedApplication implements IAppManagerCallBack
	{
		public function AirApp()
		{
			super();
			
			this.showStatusBar = false;
			
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			
			AppManager.getInstance().addCompletedCallBack(this);
			
			
		}
		
		public function initApp(pluginXmlVos:ArrayCollection,productName:String = null,pluginFileBaseFile:String = null):void{
			this.productName = productName;
			AppManager.getInstance().init(pluginXmlVos,pluginFileBaseFile);
		}
		
		private var productName:String;
		
		private function creationCompleteHandler(event:FlexEvent):void{
			this.maximize();
		}
		
		public function coreLoadCompleted():void{
			Platform.getInstance().initProduct(productName,this);
		}
	}
}