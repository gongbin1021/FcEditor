package com.zhrz.flex.ui.core.toolbar
{
	import mx.core.IVisualElement;
	import mx.utils.StringUtil;

	public class ToolBarExtensionExpressItem
	{
		public function ToolBarExtensionExpressItem()
		{
		}
		
		private var _property:String;
		private var _express:String;
		private var _variable:String;
		private var _value:String;
		private var _defaultValue:String;
		
		private var _target:IVisualElement;
		
		public function setVariableValue(value1:String):void{
			if(value1 != null && StringUtil.trim(value1) != ""){
				setPropertyValue(value1);
			}
		}
		
		public function init():void{
			if(_defaultValue != null && StringUtil.trim(_defaultValue) != ""){
				setPropertyValue(_defaultValue);
			}
		}
		
		private function setPropertyValue(value1:String):void{
			if(express == "="){
				if(_value == value1){
					_target[_property] = true;
					if(_property == "visible"){
						_target["includeInLayout"] = true;
					}
				}
				else{
					_target[_property] = false;
					if(_property == "visible"){
						_target["includeInLayout"] = false;
					}
				}
			}
			if(express == "indexOf"){
				if(_value.indexOf(value1) != -1){
					_target[_property] = true;
					if(_property == "visible"){
						_target["includeInLayout"] = true;
					}
				}
				else{
					_target[_property] = false;
					if(_property == "visible"){
						_target["includeInLayout"] = false;
					}
				}
			}
		}
		
		public function get property():String
		{
			return _property;
		}

		public function set property(value:String):void
		{
			_property = value;
		}

		public function get express():String
		{
			return _express;
		}

		public function set express(value:String):void
		{
			_express = value;
		}

		public function get variable():String
		{
			return _variable;
		}

		public function set variable(value:String):void
		{
			_variable = value;
		}

		public function get target():IVisualElement
		{
			return _target;
		}

		public function set target(value:IVisualElement):void
		{
			_target = value;
		}

		public function get defaultValue():String
		{
			return _defaultValue;
		}

		public function set defaultValue(value:String):void
		{
			_defaultValue = value;
		}

		public function get value():String
		{
			return _value;
		}

		public function set value(value:String):void
		{
			_value = value;
		}


	}
}