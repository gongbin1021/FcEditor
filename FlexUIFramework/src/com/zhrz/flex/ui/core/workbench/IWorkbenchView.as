package com.zhrz.flex.ui.core.workbench
{
	public interface IWorkbenchView extends IAdapter
	{
		
		function getViewId():String;
		
		function executeMethord(methordName:String,param:Array):Object;
		
		function fireToolBarExpressNewState(state:Object):void;
	}
}