package com.zhrz.flex.ui.core.editor
{
	import com.zhrz.flex.ui.core.configuration.ViewVo;
	import com.zhrz.flex.ui.core.workbench.Platform;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.core.IVisualElement;
	import mx.utils.UIDUtil;

	

	public class EditorManager
	{
		private static var instance:EditorManager;
		
		public static function getInstance():EditorManager{
			if(instance == null){
				instance = new EditorManager();
			}
			
			return instance;
		}
		
		private var extension:EditorExtension;
		
		public function getExtension():EditorExtension{
			if(extension == null){
				extension = new EditorExtension();
				extension.beginParse();
			}
			return extension;
		}
		
		
		public function getEditorDescriptors(contentType:String):ArrayCollection{
			var result:ArrayCollection = new ArrayCollection();
			var editorIds:ArrayCollection = EditorContentTypeExtensionManager.getInstance().getExtension().getEditorIdByContentType(contentType);
			if(editorIds && editorIds.length > 0){
				for each(var editorId:String in editorIds){
					var editorDescn:EditorExtensionDescriptor = getExtension().getEditorDescriptorById(editorId);
					if(editorDescn){
						result.addItem(editorDescn);
					}
				}
			}
			
			return result;
		}
		
		private var cache:Object = new Object();
		
		
		public function selectEditorAtLayout(editorObj:Object,layoutId:String):void{
			var editorVo:EditorVo = getEditVo(editorObj,layoutId);
			if(editorVo != null){
				Platform.getInstance().showChildByViewVo(editorVo.viewVo,layoutId);
				return;
			}
		}
		
		public function openEditorAtLayout(editObj:Object,layoutId:String):void{
			var editorVo:EditorVo = getEditVo(editObj,layoutId);
			if(editorVo != null){
				Platform.getInstance().showChildByViewVo(editorVo.viewVo,layoutId);
				return;
			}
			if(editObj is IContentType){
				var contentType:String = (editObj as IContentType).getContentType();
				if(contentType != null){
					var editors:ArrayCollection = null;
					if(cache.hasOwnProperty(contentType)){
						editors = cache[contentType] as ArrayCollection;
					}
					else{
						editors = EditorContentTypeExtensionManager.getInstance().getExtension().getEditorIdByContentType(contentType);
						cache[contentType] = editors;
					}
					
					if(editors && editors.length > 0){
						var defaultEditorId:String = editors.getItemAt(0) as String;
						getExtension().getEditorById(defaultEditorId,getEditorCallBack,{"editObj":editObj,"layoutId":layoutId});
					}

				}
			}
		}
		
		
		
		private function getEditorCallBack(editor:IEditor,param:Object):void{
			var editorInstance:IEditor = editor;
			var editObj:Object = param.editObj;
			var layoutId:String = param.layoutId;
			if(editorInstance){
				editorInstance.setEditorObj(editObj);
				var viewVo:ViewVo = new ViewVo();
				//viewVo.className = defaultEditor.className;
				if(editObj is ITabTitle){
					viewVo.label = (editObj as ITabTitle).getTitle();
					viewVo.toolTip = (editObj as ITabTitle).getToolTip();
				}
				viewVo.id = Platform.getInstance().getCurrentPluginId() +"."+UIDUtil.createUID();
				
				Platform.getInstance().addChildByLayout(layoutId,viewVo,editorInstance as IVisualElement);
				
				var vo:EditorVo = new EditorVo();
				editorVos.addItem(vo);
				vo.editObj = editObj;
				vo.viewVo = viewVo;
				vo.layoutId = layoutId;
			}
		}
		
		public function showEditor(editorObj:Object,layoutId:String):void{
			for each(var vo:EditorVo in editorVos){
				if(vo.editObj == editorObj && vo.layoutId == layoutId){
					Platform.getInstance().showView(vo.viewVo,layoutId);
					break;
				}
			}
		}
		
		private var editorVos:ArrayCollection = new ArrayCollection();
		
		private function getEditVo(editObj:Object,layoutId:String):EditorVo{
			for each(var vo:EditorVo in editorVos){
				if(vo.editObj == editObj && vo.layoutId == layoutId) return vo;
			}
			return null;
		}
		
		public function editorClose(viewVo:ViewVo,layoutId:String):void{
			for(var i:int = 0 ;i < editorVos.length ; i++){
				var vo:EditorVo = editorVos.getItemAt(i) as EditorVo;
				if(vo.viewVo == viewVo && vo.layoutId == layoutId){
					editorVos.removeItemAt(i);
					break;
				}
			}
			
			
		}
		
		public function onEditorChanged(editObj:Object):void{
			for each(var editorVo:EditorVo in editorVos){
				if(editorVo.editObj == editObj){
					Platform.getInstance().onEditorContentChanged(editorVo.viewVo,editorVo.layoutId);
				}
			}
		}
		
		public function onEditorSave(editObj:Object):void{
			for each(var editorVo:EditorVo in editorVos){
				if(editorVo.editObj == editObj){
					Platform.getInstance().onEditorContentSave(editorVo.viewVo,editorVo.layoutId);
				}
			}
		}
	}
}
import com.zhrz.flex.ui.core.configuration.ViewVo;

class EditorVo{
	public var editObj:Object;
	public var viewVo:ViewVo;
	public var layoutId:String;
}