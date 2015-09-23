package com.zhrz.flex.ui.core.layout
{
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	
	public class LayoutStrategyExtensionDescriptor extends AbstractExtensionDescriptor
	{
		public function LayoutStrategyExtensionDescriptor(id:String)
		{
			super(id);
		}
		
		private var className:String;
		
		override public function init(xml:XML):void{
			className = xml.@className
		}
	}
}