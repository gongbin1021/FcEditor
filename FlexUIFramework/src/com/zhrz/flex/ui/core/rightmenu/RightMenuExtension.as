package com.zhrz.flex.ui.core.rightmenu
{
	import com.zhrz.flex.ui.core.extension.AbstractExtension;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	
	
	public class RightMenuExtension extends AbstractExtension
	{
		public function RightMenuExtension(extensionPointId:String=null)
		{
			super("com.zhrz.eclipse.workbench.plugin.rightMenus");
		}
		
		override public function getExtensionDescriptor(id:String):AbstractExtensionDescriptor{
			return new RightMenuExtensionDescriptor(id);
		}
		
		public function getRightMenuDataSource(viewId:String,callBack:Function):void{
			for each(var item:RightMenuExtensionDescriptor in allItems){
				if(item.viewId == viewId){
					item.getMenuItems(callBack);
				}
			}
			callBack(null);
		}
	}
}