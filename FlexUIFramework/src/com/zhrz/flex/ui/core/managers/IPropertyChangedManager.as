package com.zhrz.flex.ui.core.managers
{
	import com.zhrz.flex.ui.core.workbench.IPropertyChangedListener;

	public interface IPropertyChangedManager
	{
		
		function addListener(lisener:IPropertyChangedListener):void;
		
		function removeListener(listener:IPropertyChangedListener):void;
		
	}
}