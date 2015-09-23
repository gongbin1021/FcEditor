package com.zhrz.flex.ui.core.layoutview
{
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	
	public class LayoutViewExtensionDescriptor extends AbstractExtensionDescriptor
	{
		public function LayoutViewExtensionDescriptor(id:String)
		{
			super(id);
		}
		
		public var layoutId:String;
		public var viewId:String;
		
		override public function init(xml:XML):void{
			layoutId = ""+xml.@layoutId;
			viewId = ""+xml.@viewId;
		}
	}
}