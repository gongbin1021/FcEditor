package com.zhrz.flex.ui.core.pageLayoutClient
{
	import com.zhrz.flex.ui.core.extension.AbstractExtension;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionDefine;
	
	
	public class PageLayoutClientExtension extends AbstractExtension
	{
		public function PageLayoutClientExtension(extensionId:String = null)
		{
			super(FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID+".pageLayoutClient");
		}
		
		
		override public function getExtensionDescriptor(id:String):AbstractExtensionDescriptor{
			return new PageLayoutClientDescriptor(id);
		}
		
		public function getPluginPageLayoutClient(pluginId:String,callBack:Function):void{
			for each(var item:AbstractExtensionDescriptor in allItems){
				if(item.pluginId == pluginId){
					item.createObject((item as PageLayoutClientDescriptor).className,callBack);
					break;
				}
			}
		}
		
		
		public function getPluginPageLayoutClientById(id:String,callBack:Function):void{
			for each(var item:AbstractExtensionDescriptor in allItems){
				if(item.id == id){
					item.createObject((item as PageLayoutClientDescriptor).className,callBack);
					break;
				}
			}
		}
		
	}
}