package com.zhrz.flex.ui.core.workbench
{
	import com.zhrz.flex.ui.core.configuration.ViewVo;
	import com.zhrz.flex.ui.core.editor.EditorManager;
	import com.zhrz.flex.ui.core.toolbar.ToolBarViewHBox;
	import com.zhrz.flex.ui.core.toolbar.ToolBarViewManager;
	
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElement;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	
	import flexlib.containers.SuperTabNavigator;
	import flexlib.events.SuperTabEvent;
	
	public class WorkbenchViewSuperTabNavigator extends SuperTabNavigator implements IWorkbenchViewSwitch
	{
		public function WorkbenchViewSuperTabNavigator()
		{
			super();
			
			percentWidth = 100;
			percentHeight = 100;
			
			this.setStyle("paddingTop",0);
			
			this.addEventListener(IndexChangedEvent.CHANGE,onChildIndexChanged);
			this.addEventListener(SuperTabEvent.TAB_CLOSE,onTabClose);
			this.addEventListener(FlexEvent.CREATION_COMPLETE,onCreateCompleted);
		}
		
		private function onCreateCompleted(event:FlexEvent):void{
			//trace("sssssssssssssss");
			changeToolBar();
		}
		
		private var  currentToolBarHbox:ToolBarViewHBox
		
		private function changeToolBar():void{
			if(currentToolBarHbox){
				removeToolBar(currentToolBarHbox);
			}
			currentToolBarHbox = ToolBarViewManager.getInstance().getToolBarHbox(getCurrentViewId());
			if(currentToolBarHbox != null)
				this.addToolBar(currentToolBarHbox);
		}
		
		private function getCurrentViewId():String{
			return (_viewVos.getItemAt(selectedIndex) as ViewVo).id;
		}
		
		
		private function onTabClose(event:SuperTabEvent):void{
			//trace("onTabClose")
			var viewVo:ViewVo = _viewVos.removeItemAt(event.tabIndex) as ViewVo;
			EditorManager.getInstance().editorClose(viewVo,this.layoutId);
			var workbenchView:WorkbenchViewCanvas = innerVisualElements.getItemAt(event.tabIndex) as WorkbenchViewCanvas;
			WorkbenchViewManager.getInstance().setView(workbenchView.getViewId(),null);
			WorkbenchManager.getInstance().onViewPartClosed(workbenchView.viewPart,this.layoutId,viewVo.id);
			innerVisualElements.removeItemAt(event.tabIndex);
		
			setTimeout(onClose,500);
		}
		
		private function onClose():void{
			//trace(selectedIndex);
			//trace(selectedChild);
			//trace("onTabClose")
			if(selectedChild){
				activateChild(selectedIndex);
			}
		}
		
		private function onChildIndexChanged(event:IndexChangedEvent):void{
			activateChild(event.newIndex);
		}
		
		private function activateChild(index:int):void{
			var workbenchView:WorkbenchViewCanvas = innerVisualElements.getItemAt(index) as WorkbenchViewCanvas;
			workbenchView.onActivate();
		}
		
		private var _viewVos:ArrayCollection;
		public 	function set viewVos(value:ArrayCollection):void{
			_viewVos = value;
		}
		
		public function switchView(viewVo:ViewVo):void{
			var index:int = _viewVos.getItemIndex(viewVo);
			if(index != -1){
				this.selectedIndex = index;
			}
		}
		
		public var instances:Array;
		public var layoutId:String;
		
		private var innerVisualElements:ArrayCollection = new ArrayCollection();
		
		public function initViews():void{
			if(_viewVos && _viewVos.length > 0){
				var i:int = 0;
				for each(var viewVo:ViewVo in _viewVos){
					var className:String = viewVo.className;
					
					var workbenchView:WorkbenchViewCanvas = new WorkbenchViewCanvas();
					this.addElement(workbenchView);
					innerVisualElements.addItem(workbenchView);
					
					workbenchView.viewVo = viewVo;
					workbenchView.layoutId = this.layoutId;
					if(instances){
						workbenchView.instance = instances[i];
					}
					i++;
					
					workbenchView.initView();
				}
				
				
				
			}
		}
		
		public function addView(viewVo:ViewVo,instance:IVisualElement):void{
			_viewVos.addItem(viewVo);
			
			var workbenchView:WorkbenchViewCanvas = new WorkbenchViewCanvas();
			this.addElement(workbenchView);
			selectedChild = workbenchView;
			innerVisualElements.addItem(workbenchView);
			workbenchView.layoutId = this.layoutId;
			workbenchView.viewVo = viewVo;
			workbenchView.addView(instance);
		}
		
		
		public function showChildByViewVo(viewVo:ViewVo):void{
			var index:int = _viewVos.getItemIndex(viewVo);
			if(index != -1){
				selectedIndex = index;
			}
		}
		
		public function onEditorContentChanged(viewVo:ViewVo):void{
			var index:int = _viewVos.getItemIndex(viewVo);
			if(index != -1){
				var child:Object = this.getChildAt(index);
				var label:String = child.label;
				if(label.indexOf("*") == -1){
					child.label = "*"+label;
				}
			}
		}
		
		public function onEditorContentSave(viewVo:ViewVo):void{
			var index:int = _viewVos.getItemIndex(viewVo);
			if(index != -1){
				var child:Object = this.getChildAt(index);
				var label:String = child.label;
				if(label.indexOf("*") != -1){
					child.label = label.replace("*","");
				}
			}
		}
		
		
		public function findViewById(viewId:String):IViewPart{
			for each(var view:WorkbenchViewCanvas in innerVisualElements){
				if(view.getViewId() == viewId){
					return view.viewPart;
				}
			}
			return null;
		}
		
		
	}
}