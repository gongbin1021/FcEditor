package com.zhrz.flex.ui.core.plugin
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexApplicationBootstrap;

	public class PluginLoader 
	{
		
		public function PluginLoader(pluginId:String,swfName:String,basePath:String){
			loader = new Loader();
			this.pluginId = pluginId;
			this.url = basePath + "/" +pluginId+"/" + swfName;
			if(basePath != null){
				loader.contentLoaderInfo.addEventListener(Event.INIT, onInitEvent);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIoError);
				loader.contentLoaderInfo.addEventListener(Event.OPEN,onOpen);
			}
			
		}
		
		private var loadCompletedCallBack:Function;
		private var isLoading:Boolean = false;
		
		public function beginLoad(loadCompletedCallBack:Function = null):void{
			isLoading = true;
			this.loadCompletedCallBack = loadCompletedCallBack;
			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.applicationDomain = appDomain;
			
			
			var request:URLRequest = new URLRequest(url+"?random="+Math.random()*(new Date()).time);
			var header:URLRequestHeader = new URLRequestHeader("pragma", "no-cache");
			request.requestHeaders.push(header);
			loader.load(request, loaderContext);
		}
		
		private function onInitEvent(event:Event):void {
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			
			if(loaderInfo && (loaderInfo.content is FlexApplicationBootstrap)) {
				var applicationBootstrap:FlexApplicationBootstrap = loaderInfo.content as FlexApplicationBootstrap;
				applicationBootstrap.addEventListener("ready",onPluginReady);
			} 
			else{
				//this.dispatchEvent(new Event(LAODER_SHARE_COMPLETED));
			}
		}
		
		private function onPluginReady(event:Event):void {
			if(event.target is FlexApplicationBootstrap) {
				var applicationBootstrap:FlexApplicationBootstrap = event.target as FlexApplicationBootstrap;
				plugin = applicationBootstrap.getChildAt(0) as IPlugin;
				isLoading = false;
				
				/* if(plugin){
				plugin.create("com.wxxr.flex.workflow.view.HtmlFlexView");
				} */
				
				//this.dispatchEvent(new Event(LAODER_MAIN_COMPLETED));
				if(loadCompletedCallBack!= null){
					loadCompletedCallBack();
				}
				notifyLoadCompleted();
			} 
			
		}
		
		private function onOpen(event:Event):void{
			trace("onOpen");
		}
		
		private function onIoError(event:IOErrorEvent):void{
			trace(event.text);
			Alert.show(event.text);
		}
		
		public function getIsLoading():Boolean{
			return isLoading;
		}
		
		private var loadingCreateArr:ArrayCollection = new ArrayCollection();
		public function addLoadingCreate(param1:Object,callBack:Function,param2:Object):void{
			loadingCreateArr.addItem({"param1":param1,"callBack":callBack,"param2":param2});
		}
		
		private function notifyLoadCompleted():void{
			for each(var item:Object in loadingCreateArr){
				var param1:Object = item.param1;
				var callBack:Function = item.callBack;
				var param2:Object = item.param2;
				
				var obj:Object = create(param1 as Array);
				if(callBack != null){
					if(param2 == null){
						callBack(obj);
					}
					else{
						callBack(obj,param2);
					}
				}
			}
			
			loadingCreateArr.removeAll();
		}
		
		
		private var loader:Loader;
		private var appDomain:ApplicationDomain = ApplicationDomain.currentDomain;
		
		public var pluginId:String;
		
		public var url:String;
		
		public var plugin:IPlugin;
		
		public function create(params:Array = null):Object{
			return plugin.create(params);
		}
	}
}