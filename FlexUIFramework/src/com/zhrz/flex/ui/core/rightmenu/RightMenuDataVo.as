package com.zhrz.flex.ui.core.rightmenu
{
	
	public class RightMenuDataVo implements IRightMenuDataVo
	{
		private var _label:String;
		private var _enabled:Boolean = true;
		private var _icon:String;
		private var _type:String ="normal";
		private var _toggled:Boolean = false;
		private var _groupName:String;
		private var _data:String;
		private var _commandId:String;
		
		private var _children:Array;
		
		public function parseXml(xml:XML):void{
			
			if(xml.attribute("label").length() != 0){
				this.label = ""+xml.@label;
			}
			if(xml.attribute("enabled").length() != 0){
				this.enabled = (""+xml.@enabled)=="true"?true:false;
			}
			if(xml.attribute("icon").length() != 0){
				this.icon = ""+xml.@icon;
			}
			if(xml.attribute("type").length() != 0){
				this.type = ""+xml.@type;
			}
			if(xml.attribute("toggled").length() != 0){
				this.toggled = (""+xml.@toggled)=="true"?true:false;
			}
			if(xml.attribute("groupName").length() != 0){
				this.groupName = ""+xml.@groupName;
			}
			if(xml.attribute("data").length() != 0){
				this.data = ""+xml.@data;
			}
			if(xml.attribute("commandId").length() != 0){
				this.commandId = ""+xml.@commandId;
			}
			
			var xmllist:XMLList = xml.children();
			var count:int = xmllist.length();
			if(count>0){
				_children = [];
				for(var i:int = 0 ; i < count;i++){
					var childXml:XML = xmllist[i];
					var item:RightMenuDataVo = new RightMenuDataVo();
					_children.push(item);
					item.parseXml(childXml);
				}
			}
			
		}

		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			_label = value;
		}

		public function get enabled():Boolean
		{
			return _enabled;
		}

		public function set enabled(value:Boolean):void
		{
			_enabled = value;
		}

		public function get commandId():String
		{
			return _commandId;
		}

		public function set commandId(value:String):void
		{
			_commandId = value;
		}

		public function get children():Array
		{
			return _children;
		}

		public function set children(value:Array):void
		{
			_children = value;
		}

		public function get icon():String
		{
			return _icon;
		}

		public function set icon(value:String):void
		{
			_icon = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get toggled():Boolean
		{
			return _toggled;
		}

		public function set toggled(value:Boolean):void
		{
			_toggled = value;
		}

		public function get groupName():String
		{
			return _groupName;
		}

		public function set groupName(value:String):void
		{
			_groupName = value;
		}

		public function get data():String
		{
			return _data;
		}

		public function set data(value:String):void
		{
			_data = value;
		}


	}
}