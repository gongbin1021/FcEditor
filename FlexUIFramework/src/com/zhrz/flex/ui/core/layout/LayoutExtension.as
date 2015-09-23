package com.zhrz.flex.ui.core.layout
{
	import com.zhrz.flex.ui.core.configuration.LayoutVo;
	import com.zhrz.flex.ui.core.extension.AbstractExtension;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionDefine;
	
	import mx.collections.ArrayCollection;
	
	public class LayoutExtension extends AbstractExtension
	{
		public function LayoutExtension(extensionPointId:String = null)
		{
			super(FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID+".layout");
		}
		
		override public function getExtensionDescriptor(id:String):AbstractExtensionDescriptor{
			return new LayoutExtensionDescriptor(id);
		}
		
		public function getLayoutById(id:String):LayoutVo{
			for each(var item:LayoutExtensionDescriptor in allItems){
				if(item.id == id) {
					return item.getLayoutVo();
				}
			}
			
			return null;
		}
		
		public function getLayoutByPluginId(pluginId:String):ArrayCollection{
			var result:ArrayCollection = new ArrayCollection();
			for each(var item:LayoutExtensionDescriptor in allItems){
				if(item.pluginId == pluginId){
					result.addItem(item);
				}
			}
			return result;
		}
	}
}