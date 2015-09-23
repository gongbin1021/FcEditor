package com.zhrz.flex.ui.core.editor
{
	public interface IEditor
	{
		
		
		function setEditorObj(obj:Object):void;
		
		function onEditorOpen():void;
		
		function onEditorClose():void;
		
		function onSave():void;
		
		function onChanged():void;
		
		function getEditorObject():Object;
	}
}