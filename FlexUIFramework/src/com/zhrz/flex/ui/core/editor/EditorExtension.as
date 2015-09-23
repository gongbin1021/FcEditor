package com.zhrz.flex.ui.core.editor
{
	import com.zhrz.flex.ui.core.extension.AbstractExtension;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionDefine;
	
	public class EditorExtension extends AbstractExtension
	{
		public function EditorExtension(extensionPointId:String = null)
		{
			super(FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID+".editors");
		}
		
		override public function getExtensionDescriptor(id:String):AbstractExtensionDescriptor{
			return new EditorExtensionDescriptor(id);
		}
		
		public function getEditorById(editorId:String,callBack:Function,param:Object):void{
			for each(var item:EditorExtensionDescriptor in allItems){
				if(item.id == editorId){
					item.createObject(item.className,callBack,param);
				}
			}
		}
		
		public function getEditorDescriptorById(editorId:String):EditorExtensionDescriptor{
			for each(var item:EditorExtensionDescriptor in allItems){
				if(item.id == editorId){
					return item;
				}
			}
			return null;
		}
		
	}
}