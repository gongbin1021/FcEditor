package com.zhrz.flex.ui.core.workbench
{
	import com.zhrz.flex.ui.core.configuration.ViewVo;
	
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElement;

	public class WorkbenchPageManager implements IPartListener 
	{
		
		private var _page:WorkbenchPage;
		public function WorkbenchPageManager(page:WorkbenchPage):void{
			this._page = page;
		}
		
		public function getPage():WorkbenchPage{
			return _page;
		}
		
		private var partListeners:ArrayCollection = new ArrayCollection();
		
		public function addPartListener(listener:IPartListener):void{
			var index:int = partListeners.getItemIndex(listener);
			if(index == -1){
				partListeners.addItem(listener);
			}
		}
		
		public function removePartListener(listener:IPartListener):void{
			var index:int = partListeners.getItemIndex(listener);
			if(index != -1){
				partListeners.removeItemAt(index);
			}
		}
		
		private var _activateViewPart:IViewPart;
		
		public function getCurrentActivateViewPart():IViewPart{
			return _activateViewPart;
		}
		
		public function partActivated(partRef:IViewPart,layoutId:String,viewId:String):void{
			_activateViewPart = partRef;
			for each(var listener:IPartListener in partListeners){
				listener.partActivated(partRef,layoutId,viewId);
			}
		}
		
		public function  partDeactivated(partRef:IViewPart ,layoutId:String,viewId:String):void{
			for each(var listener:IPartListener in partListeners){
				listener.partDeactivated(partRef,layoutId,viewId);
			}
		}
		
		public function partOpened(partRef:IViewPart ,layoutId:String,viewId:String):void{
			for each(var listener:IPartListener in partListeners){
				listener.partOpened(partRef,layoutId,viewId);
			}
		}
		
		public function  partClosed(partRef:IViewPart ,layoutId:String,viewId:String):void{
			for each(var listener:IPartListener in partListeners){
				listener.partClosed(partRef,layoutId,viewId);
			}
		}
		
		private var _selection:Object;
		private var _fromLayoutId:String;
		private var _fromViewId:String;
		public function setSelection(value:Object,fromLayoutId:String,fromViewId:String):void{
			//if(_selection == value) return;
			_selection = value;
			_fromLayoutId = fromLayoutId;
			_fromViewId = fromViewId;
			setTimeout(notifySelectionChanged,500);//防止激活与选择冲突，如果不延时，那么会发生先选择然后再激活
			
		}
		
		public function getCurrentSelected():Object{
			return _selection;
		}
		
		
		private function notifySelectionChanged():void{
			for each(var listener:ISelectionChangedListenter in selectionListeners){
				listener.onSelectionChanged(_selection,_fromLayoutId,_fromViewId);
			}
		}
		
		
		private var selectionListeners:ArrayCollection = new ArrayCollection();
		public function addSelectionChangedListener(listener:ISelectionChangedListenter):void{
			var index:int = selectionListeners.getItemIndex(listener);
			if(index == -1){
				selectionListeners.addItem(listener);
			}
		}
		
		public function removeSelectionChangedListener(listener:ISelectionChangedListenter):void{
			var index:int = selectionListeners.getItemIndex(listener);
			if(index != -1){
				selectionListeners.removeItemAt(index);
			}
		}
		
		public function addViewToLayout(layoutId:String,viewVo:ViewVo,instance:IVisualElement):void{
			_page.addViewToLayout(layoutId,viewVo,instance);
		}
		
		public function showChildByViewVo(viewVo:ViewVo,layoutId:String):void{
			_page.showChildByViewVo(viewVo,layoutId);
		}
		
		public function onEditorContentSave(viewVo:ViewVo,layoutId:String):void{
			_page.onEditorContentSave(viewVo,layoutId);
		}
		
		public function onEditorContentChanged(viewVo:ViewVo,layoutId:String):void{
			_page.onEditorContentChanged(viewVo,layoutId);
		}
		
		public function showView(viewVo:ViewVo,layoutId:String):void{
			_page.showView(viewVo,layoutId);
		}
		
		public function findViewById(viewId:String):IViewPart{
			return _page.findViewById(viewId);
		}
		
		public function findCurrentShowViewInLayoutId(layoutId:String):IViewPart{
			return _page.findCurrentShowViewInLayoutId(layoutId);
		}
	}
}