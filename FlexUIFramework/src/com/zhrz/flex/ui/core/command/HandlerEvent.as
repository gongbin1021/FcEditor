package com.zhrz.flex.ui.core.command
{
	import com.zhrz.flex.ui.core.workbench.IViewPart;
	
	import flash.events.Event;
	
	public class HandlerEvent extends Event
	{
		private static const COMMAND_HANDLER_EVENT:String = "commandHandlerEvent";
		
		public function HandlerEvent(bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(COMMAND_HANDLER_EVENT, bubbles, cancelable);
		}
		
		public var commandDescriptor:CommandExtensionDescriptor;
		public var handlerDescriptor:HandlerExtensionDescriptor;
		
		public var currentEvent:Event;
		
		public var currentSelectedObject:Object;
		
		public var currentActivateViewPart:IViewPart;
		
		public var param:Object;
		
		public var commandId:String;
	}
}