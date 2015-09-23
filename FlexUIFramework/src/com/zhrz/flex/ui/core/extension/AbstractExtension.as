package com.zhrz.flex.ui.core.extension
{
	import com.zhrz.flex.ui.core.plugin.PluginManager;
	
	import mx.collections.ArrayCollection;

	public class AbstractExtension
	{
		
		private var extensionPointId:String;
		
		public function AbstractExtension(extensionPointId:String){
			this.extensionPointId = extensionPointId;
		}
		
		public var allItems:ArrayCollection = new ArrayCollection();
		
		public function beginParse():void{
			var allExtension:ArrayCollection = PluginManager.getInstance().getAllExtensionByExtensionId(extensionPointId);
			for each(var extension:ExtensionVo in allExtension){
				var childxmllist:XMLList = extension.childrenXml;
				for(var i:int = 0 ; i < childxmllist.length();i++){
					createItem(childxmllist[i],extension.pluginId,extension.id);
				}
			}
		}
		
		public function createItem(xml:XML,pluginId:String,extensionId:String):void{
			var id:String = xml.@id;
			var descn:AbstractExtensionDescriptor = getExtensionDescriptor(extensionId+"."+id);
			descn.pluginId = pluginId;
			descn.init(xml);
			allItems.addItem(descn);
		}
		
		public function getExtensionDescriptor(id:String):AbstractExtensionDescriptor{
			throw new Error("必须子类实现");
		}
		
		
		
	}
}