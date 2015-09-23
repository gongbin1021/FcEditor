package com.zhrz.flex.ui.core.view
{
	import com.zhrz.flex.ui.core.configuration.ViewVo;
	import com.zhrz.flex.ui.core.extension.AbstractExtension;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionDefine;
	
	public class ViewExtension extends AbstractExtension
	{
		public function ViewExtension(extensionPointId:String = null)
		{
			super(FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID+".views");
		}
		
		override public function getExtensionDescriptor(id:String):AbstractExtensionDescriptor{
			return new ViewExtensionDescriptor(id);
		}
		
		public function getViewVoById(id:String):ViewVo{
			for each(var item:ViewExtensionDescriptor in allItems){
				if(item.id == id){
					return item.getViewVo();
				}
			}
			return null;
		}
		
	}
}