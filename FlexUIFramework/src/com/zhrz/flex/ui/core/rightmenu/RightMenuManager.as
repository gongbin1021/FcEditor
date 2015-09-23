package com.zhrz.flex.ui.core.rightmenu
{
	import com.zhrz.flex.ui.core.adaptermanager.AdapterManager;
	import com.zhrz.flex.ui.core.adaptermanager.IAdapterFactory;
	import com.zhrz.flex.ui.core.command.CommandManager;
	
	import mx.controls.Menu;
	import mx.core.FlexGlobals;
	import mx.events.MenuEvent;
	
	import avmplus.getQualifiedClassName;
	
	public class RightMenuManager
	{
		
		private static var instance:RightMenuManager;
		
		public static function getInstance():RightMenuManager{
			if(instance == null){
				instance = new RightMenuManager();
			}
			return instance;
		}
		
		private var _extension:RightMenuExtension;
		
		private function getExtension():RightMenuExtension{
			if(_extension == null){
				_extension = new RightMenuExtension();
				_extension.beginParse();
			}
			return _extension;
		}
		
		private var myMenu:Menu;
		public function createRightMenu(viewId:String,menuItems:Array = null):void{
			
			if(menuItems != null && menuItems.length>0){ //表示界面中提供了数据源
				var item:Object = menuItems[0];
				if(item is IRightMenuDataVo){
					createRightMenuCallBack(menuItems);
				}
				else{
					var param:Object = {"items":menuItems};
					AdapterManager.getInstance().getAdapter(item,"com.zhrz.flex.ui.core.rightmenu.IRightMenuDataVo",getAdapterClassCallBack,param);
				}
			}
			else{
				//如果界面没有提供，就从配置文件中找寻
				getExtension().getRightMenuDataSource(viewId,createRightMenuCallBack);
			}
			
		}
		
		private function getAdapterClassCallBack(adapterFactory:IAdapterFactory,param:Object):void{
			if(adapterFactory){
				var menuItems:Array = param.items as Array;
				var newMneuItems:Array = [];
				for each(var item:Object in menuItems){
					var newItem:IRightMenuDataVo = adapterFactory.getAdapter(item,"com.zhrz.flex.ui.core.rightmenu.IRightMenuDataVo") as IRightMenuDataVo;
					if(newItem){
						newMneuItems.push(newItem);
					}
				}
				
				if(newMneuItems.length > 0){
					createRightMenuCallBack(newMneuItems)
				}
				
			}
		}
		
		private function createRightMenuCallBack(menuItems:Array):void{
			if(menuItems){
				if(myMenu){
					myMenu.hide();
					myMenu = null;
				}
				myMenu = Menu.createMenu(null,menuItems,true);
				myMenu.addEventListener(MenuEvent.ITEM_CLICK,onMenuItemClick);
				myMenu.show(FlexGlobals.topLevelApplication.stage.mouseX+10,FlexGlobals.topLevelApplication.stage.mouseY-10);
			}
			
		}
		
		private function onMenuItemClick(event:MenuEvent):void{
			myMenu.removeEventListener(MenuEvent.ITEM_CLICK,onMenuItemClick);
			
			var vo:IRightMenuDataVo = event.item as IRightMenuDataVo;
			if(vo){
				if(vo.commandId != null && vo.commandId !=""){
					CommandManager.getInstance().executeCommand(vo.commandId,event,vo);
				}
			}
			
		}
		
	}
}