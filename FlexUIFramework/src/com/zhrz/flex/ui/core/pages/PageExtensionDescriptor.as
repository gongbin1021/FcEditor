package com.zhrz.flex.ui.core.pages
{
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	
	public class PageExtensionDescriptor extends AbstractExtensionDescriptor
	{
		public function PageExtensionDescriptor(id:String)
		{
			super(id);
		}
		
		public var label:String;
		public var layouts:Array = [];
		
		override public function init(xml:XML):void{
			label = xml.@label;
			
			var childXmlList:XMLList = xml.children();
			for(var i:int = 0 ; i < childXmlList.length();i++){
				var childXml:XML = childXmlList[i];
				if(childXml.localName() == "layouts"){
					parsePageLayout(childXml);
				}
			}
		}
		
		private function parsePageLayout(xml:XML):void{
			var childXmlList:XMLList = xml.children();
			for(var i:int = 0 ; i < childXmlList.length();i++){
				var childXml:XML = childXmlList[i];
				if(childXml.localName() == "pageLayout"){
					layouts.push({"id":""+childXml.@id,"layoutId":""+childXml.@layoutId,"isDefault":""+childXml.@isDefault,"label":""+childXml.@label,"layoutStrategyId":""+childXml.@layoutStrategyId});
				}
			}
		}
	}
}