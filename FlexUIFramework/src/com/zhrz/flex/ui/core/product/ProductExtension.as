package com.zhrz.flex.ui.core.product
{
	import com.zhrz.flex.ui.core.extension.AbstractExtension;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionDefine;
	import com.zhrz.flex.ui.core.pageLayoutClient.PageLayoutClientExtensionManager;
	
	import mx.controls.Alert;

	
	public class ProductExtension extends AbstractExtension
	{
		public function ProductExtension()
		{
			super(FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID+".product");
		}
		
		override public function getExtensionDescriptor(id:String):AbstractExtensionDescriptor{
			return new ProductExtensionDescriptor(id);
		}
		
		private function getProductByName(productName:String):ProductExtensionDescriptor{
			for each(var item:ProductExtensionDescriptor in allItems){
				if(item.name == productName) return item;
			}
			
			return null;
		}
		
		public function getCurrentPluginId(productName:String):String{
			var productDescn:ProductExtensionDescriptor = getProductByName(productName);
			if(productDescn){
				return productDescn.id;
			}
			return null;
		}
		
		public function getPageLayoutClientByProductName(productName:String,callBack:Function):void{
			var productDescn:ProductExtensionDescriptor = getProductByName(productName);
			if(productDescn == null){
				Alert.show("找不到产品 [ "+productName + " ] 的注册消息","系统提示");
			}
			else{
				var pageLayoutClient:String = productDescn.pageLayoutClient;
				if(pageLayoutClient == null || pageLayoutClient == ""){
					Alert.show("产品  "+productName + " 没有指定 pageLayoutClient","系统提示");
				}
				else{
					
					PageLayoutClientExtensionManager.getInstance().beginParseExtension().getPluginPageLayoutClientById(pageLayoutClient,callBack);
					
				}
			}
		}
		
		public function getPagesByProductName(productName:String):Array{
			for each(var item:ProductExtensionDescriptor in allItems){
				if(item.name == productName) return item.pages;
			}
			
			return null;
		}
		
	}
}