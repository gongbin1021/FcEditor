package com.zhrz.flex.ui.core.layoutview
{
	import com.zhrz.flex.ui.core.extension.AbstractExtension;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionDefine;
	
	import mx.collections.ArrayCollection;
	
	public class LayoutViewExtension extends AbstractExtension
	{
		public function LayoutViewExtension(extensionPointId:String=null)
		{
			super(FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID+".layoutView");
		}
		
		override public function getExtensionDescriptor(id:String):AbstractExtensionDescriptor{
			return new LayoutViewExtensionDescriptor(id);
		}
		
		public function getViewIdsByLayoutId(layoutId:String):ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			for each(var item:LayoutViewExtensionDescriptor in allItems){
				if(item.layoutId == layoutId){
					arr.addItem(item.viewId);
				}
			}
			return arr;
		}
	}
}