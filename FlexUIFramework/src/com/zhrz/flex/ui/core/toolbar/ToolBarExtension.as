package com.zhrz.flex.ui.core.toolbar
{
	import com.zhrz.flex.ui.core.extension.AbstractExtension;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionDefine;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionPointDefine;
	
	import mx.collections.ArrayCollection;
	
	public class ToolBarExtension extends AbstractExtension
	{
		public function ToolBarExtension(extensionPointId:String=null)
		{
			super(FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID+"."+FrameworkExtensionPointDefine.toolbars_EXTENSION_POINT);
		}
		
		override public function getExtensionDescriptor(id:String):AbstractExtensionDescriptor{
			return new ToolBarExtensionDescriptor(id);
		}
		
		public function getAllToolBarWidget(viewId:String):ArrayCollection{
			for each(var item:ToolBarExtensionDescriptor in allItems){
				if(item.viewId == viewId){
					return item.getAllWidget();
				}
			}
			
			return null;
		}
	}
}