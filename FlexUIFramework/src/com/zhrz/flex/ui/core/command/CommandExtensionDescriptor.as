package com.zhrz.flex.ui.core.command
{
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;

	public class CommandExtensionDescriptor extends AbstractExtensionDescriptor
	{
		
		public function CommandExtensionDescriptor(id:String){
			super(id);
		}
		
		override public function init(xml:XML):void{
			super.init(xml);
			descn = ""+xml.@descn;
			category = ""+xml.@category;
			name = ""+xml.@name;
		}
		
		public var descn:String;
		
		public var category:String;
		public var name:String;
	}
}