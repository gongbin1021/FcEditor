package com.zhrz.flex.ui.core.rightmenu
{
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	

	
	public class RightMenuExtensionDescriptor extends AbstractExtensionDescriptor
	{
		public function RightMenuExtensionDescriptor(id:String)
		{
			super(id);
		}
		
		override public function init(xml:XML):void{
			super.init(xml);
			
			viewId = ""+xml.@viewId;
			menuFilterClassName = ""+xml.@menuFilterClassName;
			
			var childXmllist:XMLList = xml.children();
			if(childXmllist.length() == 1){
				dataProviderXml = childXmllist[0];
			}
			
		}
		
		private var dataProviderXml:XML;
		
		private function createMenuFilterCallBack(menuFilter:IMenuDataFilter,param:Object = null):void{
			_menuFilter = menuFilter;
			
			createMenuItems();
			
			_menuFilter.filter(_menuItems);
			
			var callBack:Function = param.callBack as Function;
			callBack(_menuItems);
		}
		
		public var viewId:String;
		private var menuFilterClassName:String;
		private var _menuFilter:IMenuDataFilter;
		
		private var _menuItems:Array;
		
		private function createMenuItems():void{
			if(dataProviderXml){
				_menuItems = [];
				var childXmllist:XMLList = dataProviderXml.children();
				var count:int = childXmllist.length();
				for(var i:int = 0 ; i < count;i++){
					var childXml:XML = childXmllist[i];
					var item:RightMenuDataVo = new RightMenuDataVo();
					_menuItems.push(item);
					item.parseXml(childXml);
				}
			}
			
			
		}
		
		
		
		public function getMenuItems(callBack:Function):void{
			if(dataProviderXml == null){
				callBack(null);
				return;
			}
			if(menuFilterClassName != "" && menuFilterClassName != null){
				if(_menuFilter == null){
					var param:Object = {"callBack":callBack};
					createObject(menuFilterClassName,createMenuFilterCallBack,param);
				}
				else{
					createMenuItems();
					_menuFilter.filter(_menuItems);
					callBack(_menuItems);
				}
			}
			else{
				createMenuItems();
				callBack(_menuItems);
			}
		}
	}
}