package com.zhrz.flex.ui.core.workbench
{
	import com.zhrz.flex.ui.core.view.ViewExtensionDescriptor;

	public interface IViewPart extends IAdapter
	{
		function addPartListener(listener:IPartListener):void;
		
		function removePartListener(listener:IPartListener):void;
		
		function setSelection(value:Object):void;
		
		function addSelectionChangedListener(listener:ISelectionChangedListenter):void;
		
		function removeSelectionChangedListener(listener:ISelectionChangedListenter):void;
		
		function getViewId():String;
		function setViewId(value:String):void;
		
		function getLayoutId():String;
		function setLayoutId(value:String):void;
		
		function setLabel(label:String):void;
		
		function getViewExtensionDescriptor():ViewExtensionDescriptor;
		
		function setViewExtensionDescriptor(value:ViewExtensionDescriptor):void;
		
		function activate(layoutId:String,viewId:String):void;
		
		function executeMethord(methordName:String,param:Array):Object;
		
		function fireToolBarExpressNewState(state:Object):void;
	}
}