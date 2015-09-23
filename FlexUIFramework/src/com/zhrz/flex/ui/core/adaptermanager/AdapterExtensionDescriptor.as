package com.zhrz.flex.ui.core.adaptermanager
{
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	
	public class AdapterExtensionDescriptor extends AbstractExtensionDescriptor
	{
		public function AdapterExtensionDescriptor(id:String)
		{
			super(id);
		}
		
		override public function init(xml:XML):void{
			super.init(xml);
			
			adapterType = ""+xml.@adapterType;
			adapterTargetType = ""+xml.@adapterTargetType;
			factoryClass = ""+xml.@factoryClass;
		}
		
		public var adapterType:String;
		public var adapterTargetType:String;
		public var factoryClass:String;
		
		public function getAdapter(callBack:Function,param:Object = null):void{
			if(factoryClass != null && factoryClass != ""){
				this.createObject(factoryClass,callBack,param);
			}
			else{
				callBack(null,param);
			}
		}
	}
}