package com.zhrz.flex.ui.core.layout
{
	import mx.core.IVisualElementContainer;

	public class DefaultLayoutAreaVo implements ILayoutAreaVo
	{
		public function DefaultLayoutAreaVo()
		{
		}
		
		private var _id:String;
		private var _isTab:String;
		private var _superTab:Boolean;
		private var _child:Object;
		private var _layoutArea:IVisualElementContainer;
		
		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get isTab():String
		{
			return _isTab;
		}

		public function set isTab(value:String):void
		{
			_isTab = value;
		}

		public function get superTab():Boolean
		{
			return _superTab;
		}

		public function set superTab(value:Boolean):void
		{
			_superTab = value;
		}

		public function get child():Object
		{
			return _child;
		}

		public function set child(value:Object):void
		{
			_child = value;
		}

		public function get layoutArea():IVisualElementContainer
		{
			return _layoutArea;
		}

		public function set layoutArea(value:IVisualElementContainer):void
		{
			_layoutArea = value;
		}


	}
}