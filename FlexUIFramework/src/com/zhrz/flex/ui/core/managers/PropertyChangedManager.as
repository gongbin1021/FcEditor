package com.zhrz.flex.ui.core.managers
{
	import com.zhrz.flex.ui.core.workbench.IPropertyChangedListener;
	
	import mx.collections.ArrayCollection;
	
	public class PropertyChangedManager implements IPropertyChangedManager
	{
		public function PropertyChangedManager()
		{
		}
		
		private var listeners:ArrayCollection = new ArrayCollection();
		
		public function addListener(listener:IPropertyChangedListener):void
		{
			var index:int = listeners.getItemIndex(listener);
			if(index == -1){
				listeners.addItem(listener);
			}
		}
		
		public function removeListener(listener:IPropertyChangedListener):void
		{
			var index:int = listeners.getItemIndex(listener);
			if(index != -1){
				listeners.removeItemAt(index);
			}
		}
	}
}