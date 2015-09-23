package com.zhrz.flex.ui.core.editor
{
	import com.zhrz.flex.ui.core.workbench.AbstractView;
	
	public class AbstractEditor extends AbstractView implements IEditor
	{
		public function AbstractEditor()
		{
			super();
		}
		
		private var _editorObject:Object;
		
		public function setEditorObj(obj:Object):void
		{
			this._editorObject = obj;
		}
		
		
		
		public function onEditorOpen():void
		{
		}
		
		public function onEditorClose():void
		{
		}
		
		public function onSave():void
		{
		}
		
		public function onChanged():void
		{
			EditorManager.getInstance().onEditorChanged(_editorObject);
		}
		
		public function getEditorObject():Object
		{
			return _editorObject;
		}
	}
}