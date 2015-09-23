package com.zhrz.flex.ui.core.adaptermanager
{
	public interface IAdapterFactory
	{
		function getAdapter(apapterObject:Object,adapterType:String):Object;
	}
}