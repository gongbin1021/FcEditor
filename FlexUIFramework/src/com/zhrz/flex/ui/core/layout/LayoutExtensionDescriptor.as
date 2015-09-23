package com.zhrz.flex.ui.core.layout
{
	import com.zhrz.flex.ui.core.configuration.LayoutVo;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	
	public class LayoutExtensionDescriptor extends AbstractExtensionDescriptor
	{
		public function LayoutExtensionDescriptor(id:String)
		{
			super(id);
		}
		
	
		public var layoutContent:XML;
		override public function init(xml:XML):void{
			layoutContent = xml.children()[0];
		}
		
		private var _layoutVo:LayoutVo;
		public function getLayoutVo():LayoutVo{
			if(_layoutVo == null){
				_layoutVo = new LayoutVo();
				_layoutVo.id = id;
				_layoutVo.layoutContent = layoutContent;
			}
			return _layoutVo;
		}
	}
}