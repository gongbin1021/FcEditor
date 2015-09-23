package com.zhrz.flex.ui.core.command
{
	import com.zhrz.flex.ui.core.workbench.Platform;
	
	import flash.events.Event;
	import flash.utils.setTimeout;

	public class CommandManager
	{
		private static var instance:CommandManager;
		
		public static function getInstance():CommandManager{
			if(instance == null){
				instance = new CommandManager();
			}
			return instance;
		}
		
		private var cache:Object = new Object();
		
		public function executeCommand(commandId:String,orginEvent:Event = null,param:Object = null):void{
			var handler:HandlerVo = cache[commandId] as HandlerVo;
			if(handler == null){
				var commandDescn:CommandExtensionDescriptor = CommandExtensionManager.getInstance().getExtension().getCommand(commandId);
				if(commandDescn == null){
					throw new Error(commandId +" 未定义");
				}
				
				var hadlerDescn:HandlerExtensionDescriptor = HandlerExtensionManager.getInstance().getExtension().getHandler(commandId);
				if(hadlerDescn == null){
					throw new Error(commandId +" 未定义与之相对应的handler");
				}
				
				handler = new HandlerVo();
				cache[commandId] = handler;
				
				handler.commandDescriptor = commandDescn;
				handler.handlerDescriptor = hadlerDescn;
				handler.commandId = commandId;
				handler.orginEvent = orginEvent;
				handler.param = param;
				
				hadlerDescn.createObject(hadlerDescn.className,createHandlerCallBack,handler);
			}
			else{
				doHandler(handler,commandId,orginEvent,param);
			}
		}
		
		private function createHandlerCallBack(handler:AbstractHandler,param:Object):void{
			if(handler != null){
				var handlerVo:HandlerVo = param as HandlerVo;
				handlerVo.handler = handler;
				doHandler(handlerVo,handlerVo.commandId,handlerVo.orginEvent,handlerVo.param);
			}
		}
		
		
		private function doHandler(handlervo:HandlerVo,commandId:String,orginEvent:Event = null,param:Object = null):void{
			var evt:HandlerEvent = new HandlerEvent();
			evt.commandDescriptor = handlervo.commandDescriptor;
			evt.handlerDescriptor = handlervo.handlerDescriptor;
			evt.currentActivateViewPart = Platform.getInstance().getCurrentActivateViewPart();
			evt.currentSelectedObject =  Platform.getInstance().getCurrentSelected();
			evt.param = param;
			evt.currentEvent = orginEvent;
			evt.commandId = commandId;
			
			setTimeout(function():void{
				handlervo.handler.execute(evt);
			},200);
		}
		
	}
}
import com.zhrz.flex.ui.core.command.AbstractHandler;
import com.zhrz.flex.ui.core.command.CommandExtensionDescriptor;
import com.zhrz.flex.ui.core.command.HandlerExtensionDescriptor;

import flash.events.Event;

class HandlerVo{
	public var handler:AbstractHandler;
	public var commandDescriptor:CommandExtensionDescriptor;
	public var handlerDescriptor:HandlerExtensionDescriptor;
	
	public var commandId:String;
	public var orginEvent:Event;
	public var param:Object;
	
}