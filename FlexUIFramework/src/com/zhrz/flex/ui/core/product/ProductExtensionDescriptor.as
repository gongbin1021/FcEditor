package com.zhrz.flex.ui.core.product
{
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	
	public class ProductExtensionDescriptor extends AbstractExtensionDescriptor
	{
		public function ProductExtensionDescriptor(id:String)
		{
			super(id);
		}
		
		public var name:String;
		public var pageLayoutClient:String;
		public var style:String;
		public var pages:Array;
		
		override public function init(xml:XML):void{
			name = xml.@name;
			pageLayoutClient = xml.@pageLayoutClient;
			style = xml.@style;
			
			var childXmlLIst:XMLList = xml.children();
			for(var i:int = 0 ; i < childXmlLIst.length();i++){
				var childXml:XML = childXmlLIst[i];
				if(childXml.localName() == "pages"){
					parsePages(childXml);
				}
			}
			
		}
		
		private function parsePages(xml:XML):void{
			var childXmlLIst:XMLList = xml.children();
			if(childXmlLIst.length() > 0){
				pages = [];
			}
			for(var i:int = 0 ; i < childXmlLIst.length();i++){
				var xml:XML = childXmlLIst[i];
				var pageId:String = xml.@id;
				pages.push(""+xml.@id);
			}
		}
	}
}