package com.zhrz.flex.ui.core.editor
{
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	
	public class EditorContentTypeExtensionDescriptor extends AbstractExtensionDescriptor
	{
		public function EditorContentTypeExtensionDescriptor(id:String)
		{
			super(id);
		}
		
		public var editorId:String;
		public var contentType:String;
		public var index:int= 0;
		
		override public function init(xml:XML):void{
			super.init(xml);
			
			editorId = xml.@editorId;
			contentType = xml.@contentType;
			if(xml.attribute("index").length() > 0){
				index = int(""+xml.@index);
			}
		}
	}
}