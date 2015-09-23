package com.zhrz.flex.ui.core.command
{
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;

	public class HandlerExtensionDescriptor extends AbstractExtensionDescriptor
	{
	
		public function HandlerExtensionDescriptor(id:String){
			super(id);
		}
		
		override public function init(xml:XML):void{
			super.init(xml);
			className = xml.@className;
			descn = xml.@descn;
			commandId = xml.@commandId;
		}
		
		public var className:String;
		public var descn:String;
		public var commandId:String;
	}
}