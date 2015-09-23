package com.zhrz.flex.ui.core.command
{
	import com.zhrz.flex.ui.core.extension.AbstractExtension;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionDefine;
	
	public class HandlerExtension extends AbstractExtension
	{
		public function HandlerExtension(extensionPointId:String = null)
		{
			super(FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID+".handlers");
		}
		
		override public function getExtensionDescriptor(id:String):AbstractExtensionDescriptor{
			return new HandlerExtensionDescriptor(id);
		}
		
		public function getHandler(commandId:String):HandlerExtensionDescriptor{
			for each(var item:HandlerExtensionDescriptor in allItems){
				if(item.commandId == commandId){
					return item;
				}
			}
			
			return null;
		}
	}
}