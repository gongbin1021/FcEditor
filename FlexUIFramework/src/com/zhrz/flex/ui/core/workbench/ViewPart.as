package com.zhrz.flex.ui.core.workbench
{
	import com.zhrz.flex.ui.core.view.ViewExtensionDescriptor;

	public class ViewPart implements IViewPart
	{
		private var _workbenchView:IWorkbenchView;
		
		public function ViewPart(workbenchView:IWorkbenchView)
		{
			this._workbenchView = workbenchView;
		}
		
		public function addPartListener(listener:IPartListener):void{
			WorkbenchManager.getInstance().addPartListener(listener);
		}
		
		public function removePartListener(listener:IPartListener):void{
			WorkbenchManager.getInstance().removePartListener(listener);
		}
		
		public function getAdapter(adapter:Object):Object{
			return _workbenchView.getAdapter(adapter);
		}
		
		public function setSelection(value:Object):void{
			WorkbenchManager.getInstance().setSelection(value,this.getLayoutId(),this.getViewId());
		}
		
		public function addSelectionChangedListener(listener:ISelectionChangedListenter):void{
			WorkbenchManager.getInstance().addSelectionChangedListener(listener);
		}
		
		public function removeSelectionChangedListener(listener:ISelectionChangedListenter):void{
			WorkbenchManager.getInstance().removeSelectionChangedListener(listener);
		}
		
		private var _viewId:String;
		
		public function getViewId():String{
			return _viewId;
		}
		
		public function setViewId(value:String):void{
			this._viewId = value;
		}
		
		private var _layoutId:String;
		public function getLayoutId():String{
			return _layoutId;
		}
		public function setLayoutId(value:String):void{
			_layoutId = value;
		}
		
		public function setLabel(label:String):void{
			WorkbenchViewManager.getInstance().getView(_viewId).label = label;
		}
		
		private var _viewExtensionDescriptor:ViewExtensionDescriptor;
		public  function getViewExtensionDescriptor():ViewExtensionDescriptor{
			return _viewExtensionDescriptor;
		}
		
		public function setViewExtensionDescriptor(value:ViewExtensionDescriptor):void{
			this._viewExtensionDescriptor = value;
		}
		
		public function activate(layoutId:String,viewId:String):void{
			WorkbenchManager.getInstance().activate(this,layoutId,viewId);
		}
		
		public function executeMethord(methordName:String,param:Array):Object{
			return this._workbenchView.executeMethord(methordName,param);
		}
		
		public function fireToolBarExpressNewState(state:Object):void{
			this._workbenchView.fireToolBarExpressNewState(state);
		}
	}
}