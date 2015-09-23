package com.zhrz.flex.ui.core.workbench
{
	public interface IPartListener
	{
		function partActivated(partRef:IViewPart,layoutId:String,viewId:String):void;
		
		function  partDeactivated(partRef:IViewPart,layoutId:String,viewId:String):void;
		
		function partOpened(partRef:IViewPart,layoutId:String,viewId:String):void;
		
		function  partClosed(partRef:IViewPart,layoutId:String,viewId:String):void;
	}
}