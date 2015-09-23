package com.zhrz.flex.ui.core.workbench
{
	import flash.events.Event;
	
	public class ViewPartEvent extends Event
	{
		
		public static const VIEW_PART_CREATED:String = "viewPartCreate";
		
		private var _viewPart:IViewPart;
		
		public function ViewPartEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
		}
		
		
		public function get viewPart():IViewPart
		{
			return _viewPart;
		}

		public function set viewPart(value:IViewPart):void
		{
			_viewPart = value;
		}

	}
}