package com.zhrz.flex.ui.core.pages
{
	import com.zhrz.flex.ui.core.configuration.PageVo;
	import com.zhrz.flex.ui.core.extension.AbstractExtension;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionDefine;
	
	public class PageExtension extends AbstractExtension
	{
		public function PageExtension(extensionPointId:String=null)
		{
			super(FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID+".pages");
		}
		
		override public function getExtensionDescriptor(id:String):AbstractExtensionDescriptor{
			return new PageExtensionDescriptor(id);
		}
		
		public function getPageById(id:String):PageVo{
			for each(var item:PageExtensionDescriptor in allItems){
				if(item.id == id){
					var pageVo:PageVo = new PageVo();
					pageVo.id = id;
					pageVo.label = item.label;
					pageVo.layouts = item.layouts;
					return pageVo;
				}
			}
			
			return null;
		}
	}
}