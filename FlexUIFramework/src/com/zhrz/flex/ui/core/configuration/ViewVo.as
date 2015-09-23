package com.zhrz.flex.ui.core.configuration
{
	import com.zhrz.flex.ui.core.view.ViewExtensionDescriptor;

	public class ViewVo extends ConfigVo
	{
		public function ViewVo()
		{
			super();
		}
		
		public var className:String;
		public var label:String;
		
		public var toolTip:String;
		
		public var viewDescriptor:ViewExtensionDescriptor;
		
	}
}