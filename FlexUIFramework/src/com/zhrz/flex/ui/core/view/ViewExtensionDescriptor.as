package com.zhrz.flex.ui.core.view
{
	import com.zhrz.flex.ui.core.configuration.ViewVo;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	
	public class ViewExtensionDescriptor extends AbstractExtensionDescriptor
	{
		public function ViewExtensionDescriptor(id:String)
		{
			super(id);
		}
		
		public var className:String;
		public var label:String;
		
		override public function init(xml:XML):void{
			super.init(xml);
			className = ""+xml.@className;
			label = ""+xml.@label;
		}
		
		public function getViewXml():XML{
			return extensionXml;
		}
		
		private var viewVo:ViewVo;
		public function getViewVo():ViewVo{
			if(viewVo == null){
				viewVo = new ViewVo();
				viewVo.id = id;
				viewVo.className = className;
				viewVo.label = label;
				viewVo.viewDescriptor = this;
			}
			return viewVo;
		}
		
		public function createView(callBack:Function):void{
			createObject(className,callBack);
		}
		
	}
}