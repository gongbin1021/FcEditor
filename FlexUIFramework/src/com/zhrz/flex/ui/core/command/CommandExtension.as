package com.zhrz.flex.ui.core.command
{
	import com.zhrz.flex.ui.core.extension.AbstractExtension;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionDefine;
	
	public class CommandExtension extends AbstractExtension
	{
		public function CommandExtension(extensionPointId:String = null)
		{
			super(FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID+".commands");
		}
		
		override public function getExtensionDescriptor(id:String):AbstractExtensionDescriptor{
			return new CommandExtensionDescriptor(id);
		}
		
		public function getCommand(commandId:String):CommandExtensionDescriptor{
			for each(var item:CommandExtensionDescriptor in allItems){
				if(item.id == commandId){
					return item;
				}
			}
			
			return null;
		}
	}
}