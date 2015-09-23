package com.zhrz.flex.ui.core.workbench
{
	import com.zhrz.flex.ui.core.managers.IViewInitClient;
	import com.zhrz.flex.ui.core.managers.ViewInitClientManager;
	import com.zhrz.flex.ui.core.view.ViewExtensionDescriptor;
	
	import mx.containers.Canvas;

	
	public class AbstractView extends Canvas implements IPartListener,ISelectionChangedListenter,IAdapter,IViewInitClient
	{
		public function AbstractView()
		{
			super();
			
			this.addEventListener(ViewPartEvent.VIEW_PART_CREATED,onViewPartCreated);
			ViewInitClientManager.getInstance().addViewClient(this);
		}
		private var _viewPart:IViewPart;
		
		public function get currentSelectedObj():Object
		{
			return _currentSelectedObj;
		}

		public function set currentSelectedObj(value:Object):void
		{
			_currentSelectedObj = value;
		}

		public function getThisViewPart():IViewPart{
			return _viewPart;
		}
		
		private var _currentSelectedObj:Object = {};
		
		private function onViewPartCreated(event:ViewPartEvent):void{
			_viewPart = event.viewPart;
			_viewPart.addPartListener(this);
			_viewPart.addSelectionChangedListener(this);
			if(labelChanged){
				_viewPart.setLabel(_label);
				labelChanged = false;
			}
			//trace("onViewPartCreated:"+_viewPart);
		}
		
		private var _label:String;
		private var labelChanged:Boolean = false;
		public function setLabel(value:String):void{
			_label = value;
			labelChanged = true;
			
			if(_viewPart){
				_viewPart.setLabel(value);
				labelChanged = false;
			}
			
			
		}
		
		
		public function activate(layoutId:String,viewId:String):void{
			_viewPart.activate(layoutId,viewId);
		}
		
		public function getViewExtensionDescriptor():ViewExtensionDescriptor{
			if(_viewPart){
				return _viewPart.getViewExtensionDescriptor();
			}
			
			return null;
		}
		
		public function partActivated(partRef:IViewPart,layoutId:String,viewId:String):void
		{
			//trace("partActivated:"+partRef);
		}
		
		public function  partDeactivated(partRef:IViewPart ,layoutId:String,viewId:String):void{
			//trace("partDeactivated:"+partRef);
		}
		
		public function setSelection(value:Object):void{
			_viewPart.setSelection(value);
		}
		
		public function onSelectionChanged(section:Object,fromLayoutId:String,fromViewId:String):void{
			currentSelectedObj = section;
		}
		
		public function partOpened(partRef:IViewPart ,layoutId:String,viewId:String):void{
		//	trace("partOpened:"+partRef);
		}
		
		public function  partClosed(partRef:IViewPart ,layoutId:String,viewId:String):void{
		//	trace("partClosed:"+partRef);
		}
		
		public function getAdapter(adapter:Object):Object{
			return null;
		}
		
		public function onAllInitViewCreateCompleted():void{
			
		}
		
		
		
		public function fireToolBarExpressNewState(state:Object):void{
			_viewPart.fireToolBarExpressNewState(state);
		}
	}
}