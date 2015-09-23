package com.zhrz.flex.ui.core.plugin
{
	import mx.collections.ArrayCollection;


	public class PluginVo
	{
		
		public var id:String;
		public var name:String;
		public var version:String;
		
		public var swf:String;
		
		public var extensionPoint:ArrayCollection = new ArrayCollection();
		public var extensions:ArrayCollection = new ArrayCollection();
		
		
		
	}
}