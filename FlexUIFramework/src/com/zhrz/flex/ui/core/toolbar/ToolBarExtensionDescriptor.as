package com.zhrz.flex.ui.core.toolbar
{
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	
	import mx.collections.ArrayCollection;
	
	
	public class ToolBarExtensionDescriptor extends AbstractExtensionDescriptor
	{
		public function ToolBarExtensionDescriptor(id:String)
		{
			super(id);
		}
		
		override public function init(xml:XML):void{
			super.init(xml);
			
			this.viewId = ""+xml.@viewId;
			if(xml.children() != null){
				var children:XML = xml.children()[0];
				var toolBarxmlist:XMLList = children.children();
				for(var i:int = 0 ; i < toolBarxmlist.length();i++){
					var toolBar:XML = toolBarxmlist[i];
					var toolButton:ToolBarButton = null;
					if(toolBar.localName() == "toolBarButton"){
						toolButton = parseToolBarButton(toolBar);
					}
					
					if(toolBar.child("expressItems").length() == 1){
						var expressItemsXml:XML = toolBar.child("expressItems")[0];
						
						if(expressItemsXml.children().length() > 0){
							var expresses:ArrayCollection = new ArrayCollection();
							
							for(var n:int = 0; n < expressItemsXml.children().length();n++){
								var expressXml:XML = expressItemsXml.children()[n];
								var expressVo:ToolBarExtensionExpressItem = new ToolBarExtensionExpressItem();
								expressVo.express = expressXml.@express;
								expressVo.property = expressXml.@property;
								expressVo.variable = expressXml.@variable;
								expressVo.value =  expressXml.@value;
								expressVo.defaultValue = expressXml.@defaultValue;
								expresses.addItem(expressVo);
							}
							
							toolButton.setExpresses(expresses);
						}
					}
					
				}
			}
		}
		
		public var viewId:String;
		
		private function parseToolBarButton(xml:XML):ToolBarButton{
			var toolButton:ToolBarButton = new ToolBarButton();
			toolButton.setId(""+xml.@id);
			toolButton.setCommandId(""+xml.@command);
			toolButton.label = ""+xml.@label;
			toolButton.toolTip = ""+xml.@toolTip;
			toolButton.styleName = ""+xml.@styleName;
			allToolBarWidget.addItem(toolButton);
			return toolButton;
		}
		
		private var allToolBarWidget:ArrayCollection = new ArrayCollection();
		public function getAllWidget():ArrayCollection{
			return allToolBarWidget;
		}
	}
}
import com.zhrz.flex.ui.core.toolbar.IToolBarWidget;
import com.zhrz.flex.ui.core.toolbar.ToolBarExtensionExpressItem;

import mx.collections.ArrayCollection;
import mx.controls.Button;
import mx.core.IVisualElement;

class ToolBarButton implements IToolBarWidget{
	
	private var _widget:IVisualElement;
	
	public function getWidget():IVisualElement{
		if(_widget == null){
			_widget = new Button();
			(_widget as Button).buttonMode = true;
		}
		
		return _widget;
	}
	
	private var commandId:String;
	
	public function getCommandId():String{
		return commandId;
	}
	
	public function setCommandId(value:String):void{
		 commandId = value;
	}
	
	private var id:String;
	public function getId():String{
		return id;
	}
	public function setId(value:String):void{
		id = value;
	}

	public function get label():String
	{
		return _label;
	}

	public function set label(value:String):void
	{
		_label = value;
	}

	public function get toolTip():String
	{
		return _toolTip;
	}

	public function set toolTip(value:String):void
	{
		_toolTip = value;
	}

	public function get styleName():String
	{
		return _styleName;
	}

	public function set styleName(value:String):void
	{
		_styleName = value;
	}

	
	public function getExpresses():ArrayCollection{
		return _expresses;
	}
	
	public function setExpresses(value:ArrayCollection):void{
		_expresses = value;
		for each(var item:ToolBarExtensionExpressItem in value){
			item.target = getWidget();
		}
	}
	
	private var _label:String;
	private var _toolTip:String;
	private var _styleName:String;
	private var _expresses:ArrayCollection;
	
	
	
}