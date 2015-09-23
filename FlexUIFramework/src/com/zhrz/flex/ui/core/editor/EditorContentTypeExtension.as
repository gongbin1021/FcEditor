package com.zhrz.flex.ui.core.editor
{
	import com.zhrz.flex.ui.core.extension.AbstractExtension;
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	import com.zhrz.flex.ui.core.extension.FrameworkExtensionDefine;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	public class EditorContentTypeExtension extends AbstractExtension
	{
		public function EditorContentTypeExtension(extensionPointId:String = null)
		{
			super(FrameworkExtensionDefine.WORKBENCH_PLUGIN_ID+".editorContentType");
		}
		
		override public function getExtensionDescriptor(id:String):AbstractExtensionDescriptor{
			return new EditorContentTypeExtensionDescriptor(id);
		}
		
		public function getEditorIdByContentType(contentType:String):ArrayCollection{
			var arr:ArrayCollection = new ArrayCollection();
			for each(var item:EditorContentTypeExtensionDescriptor in allItems){
				if(item.contentType.indexOf(contentType) != -1){
					arr.addItem( item);
				}
			}
			
			var sort:Sort = new Sort();
			sort.fields = [new SortField("index")];
			arr.sort = sort;
			arr.refresh();
			
			var editorIds:ArrayCollection = new ArrayCollection();
			
			for(var i:int = (arr.length - 1); i>=0 ;i--){
				editorIds.addItem(arr[i].editorId);
			}
			
			
			
			return editorIds;
		}
	}
}