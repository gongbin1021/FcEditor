package com.zhrz.flex.ui.core.app
{
	import com.zhrz.flex.ui.core.managers.AppManager;
	import com.zhrz.flex.ui.core.managers.IAppManagerCallBack;
	import com.zhrz.flex.ui.core.workbench.Platform;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.Application;
	
	public class SparkApplication extends Application implements IAppManagerCallBack
	{
		public function SparkApplication()
		{
			super();
			
			AppManager.getInstance().addCompletedCallBack(this);
		}
		
		public function initApp(pluginXmlVos:ArrayCollection,productName:String = null,pluginFileBaseFile:String = null):void{
			this.productName = productName;
			AppManager.getInstance().init(pluginXmlVos,pluginFileBaseFile);
		}
		
		private var productName:String;
		
		
		
		public function coreLoadCompleted():void{
			Platform.getInstance().initProduct(productName,this);
		}
	}
}