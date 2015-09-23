package com.zhrz.flex.ui.core.extension
{
	import mx.collections.ArrayCollection;

	public class ExtensionPointVo
	{
		public var id:String;
		public var name:String;
		public var pluginId:String;
		
		public var extensions:ArrayCollection = new ArrayCollection();
	}
}