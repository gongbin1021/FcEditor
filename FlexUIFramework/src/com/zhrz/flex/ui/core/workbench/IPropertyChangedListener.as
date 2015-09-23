package com.zhrz.flex.ui.core.workbench
{
	public interface IPropertyChangedListener
	{
		function onPropertyChanged(owner:Object,propertyName:String,newValue:String,oldValue:String):void;
	}
}