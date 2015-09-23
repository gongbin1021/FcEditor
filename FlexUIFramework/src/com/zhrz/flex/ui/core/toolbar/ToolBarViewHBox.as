package com.zhrz.flex.ui.core.toolbar
{
	import com.zhrz.flex.ui.core.command.CommandManager;
	
	import flash.events.MouseEvent;
	
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.core.IVisualElement;
	
	public class ToolBarViewHBox extends HBox
	{
		public function ToolBarViewHBox()
		{
			super();
			percentHeight = percentWidth = 100;
			this.setStyle("horizontalAlign","right");
			//this.setStyle("backgroundColor","0xff0000");
		}
		
		public function addWidget(widget:IToolBarWidget,viewId:String):void{
			var ui:IVisualElement = widget.getWidget();
			if(ui){
				this.addElement(ui);
				var commandId:String = widget.getCommandId();
				if(commandId == null || commandId==""){
					throw new Error(widget.getId()+" 没有设置commandId");
				}
				if(widget.label!= null && widget.label !=""){
					(ui as Button).label = widget.label;
				}
				if(widget.toolTip!= null && widget.toolTip !=""){
					(ui as Button).toolTip = widget.toolTip;
				}
				if(widget.styleName!= null && widget.styleName !=""){
					(ui as Button).styleName = widget.styleName;
				}
				
				
				if(widget.getExpresses()){
					ToolBarViewWidgetExpressManager.getInstance().addExpress(viewId,widget.getExpresses());
				}
				
				ui.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
					CommandManager.getInstance().executeCommand(commandId,evt);
				});
			}
		}
	}
}