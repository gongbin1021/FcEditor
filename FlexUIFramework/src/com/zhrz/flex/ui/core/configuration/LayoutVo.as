package com.zhrz.flex.ui.core.configuration
{
	
	public class LayoutVo extends ConfigVo
	{
		public function LayoutVo()
		{
			super();
		}
		
		public var layoutContent:XML;
		public var label:String;
		public var isDefault:String;
		public var layoutStrategyId:String;
	}
}