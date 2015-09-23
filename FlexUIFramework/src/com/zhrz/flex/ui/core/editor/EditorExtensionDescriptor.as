package com.zhrz.flex.ui.core.editor
{
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	
	public class EditorExtensionDescriptor extends AbstractExtensionDescriptor
	{
		public function EditorExtensionDescriptor(id:String)
		{
			super(id);
		}
		
		override public function init(xml:XML):void{
			super.init(xml);
			
			className = ""+ xml.@className;
			type = ""+ xml.@type;
			label = ""+ xml.@label;
		}
		
		public var className:String;
		public var type:String;
		public var label:String;
	}
}