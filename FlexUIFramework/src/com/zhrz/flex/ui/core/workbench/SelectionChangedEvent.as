package com.zhrz.flex.ui.core.workbench
{
	import flash.events.Event;
	
	public class SelectionChangedEvent extends Event
	{
		
		public static const SELECTION_CHANGED:String = "selectionChanged";
		
		public function SelectionChangedEvent(selection:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(SELECTION_CHANGED, bubbles, cancelable);
		}
		
		private var _selection:Object;
		
		public function get selection():Object{
			return _selection;
		}
	}
}