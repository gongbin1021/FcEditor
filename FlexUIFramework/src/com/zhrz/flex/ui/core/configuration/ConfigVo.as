package com.zhrz.flex.ui.core.configuration
{
	public class ConfigVo
	{
		
		private var _id:String;
		private var _name:String;
		private var _version:String;
		
		
		
		public function get version():String
		{
			return _version;
		}

		public function set version(value:String):void
		{
			_version = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

	}
}