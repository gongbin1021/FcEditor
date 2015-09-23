package com.zhrz.flex.ui.core.adaptermanager
{
	import com.zhrz.flex.ui.core.extension.AbstractExtension;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionDefine;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionPointDefine;
	
	import avmplus.getQualifiedClassName;
	
	public class AdapterExtension extends AbstractExtension
	{
		public function AdapterExtension(extensionPointId:String=null)
		{
			super(FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID+"."+FrameworkExtensionPointDefine.adapter_EXTENSION_POINT);
		}
		
		override public function getExtensionDescriptor(id:String):AbstractExtensionDescriptor{
			return new AdapterExtensionDescriptor(id);
		}
		
		public function getAdapter(adapterObject:Object,adapterType:String,callBack:Function,param:Object = null):void{
			var adapterTargetType:String = getQualifiedClassName(adapterObject);
			adapterTargetType= adapterTargetType.replace("::",".");
			var isExist:Boolean;
			for each(var item:AdapterExtensionDescriptor in allItems){
				if(item.adapterTargetType == adapterTargetType && item.adapterType == adapterType){
					
					isExist = true;
					break;
				}
			}
			
			if(!isExist){
				callBack(null,param);
			}
			
		}
	}
}