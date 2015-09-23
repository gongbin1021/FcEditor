package  com.zhrz.flex.ui.core.workbench
{
	import com.zhrz.flex.ui.core.configuration.ViewVo;
	import com.zhrz.flex.ui.core.managers.ViewInitManager;
	import com.zhrz.flex.ui.core.rightmenu.IRightMenuViewDataSourceProvider;
	import com.zhrz.flex.ui.core.rightmenu.RightMenuManager;
	import com.zhrz.flex.ui.core.toolbar.ToolBarViewWidgetExpressManager;
	
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.core.IVisualElement;
	import mx.events.FlexEvent;
	

	public class WorkbenchViewCanvas extends Canvas implements IWorkbenchView
	{
		public function WorkbenchViewCanvas()
		{
			super();
			percentWidth = 100;
			percentHeight = 100;
			
			this.addEventListener(MouseEvent.CLICK,onMouseClick);
			this.addEventListener(MouseEvent.RIGHT_CLICK,onRightClick);
		}
		
		private function onMouseClick(event:MouseEvent):void{
			onActivate();
		}
		
		private function onRightClick(event:MouseEvent):void{
			var viewId:String = _viewVo.id;
			var menuItems:Array = null;
			if(innerVisualElement is IRightMenuViewDataSourceProvider){
				menuItems = (innerVisualElement as IRightMenuViewDataSourceProvider).getMenuItemDataSource();
			}
			RightMenuManager.getInstance().createRightMenu(viewId,menuItems);
		}
		
		public function onActivate():void{
			WorkbenchManager.getInstance().onViewPartActivated(this._viewPart,this.layoutId,this.getViewId());
		}
		
		private var _viewVo:ViewVo;
		public 	function set viewVo(value:ViewVo):void{
			_viewVo = value;
		}
		
		public var instance:IVisualElement;
		public var layoutId:String;
		private var innerVisualElement:IVisualElement;
		private var loadingView:LoadingView;
		
		public function initView():void{
			
			if(instance == null){
				
				loadingView = new LoadingView();
				addElement(loadingView);
				loadingView.loadingLabel = "loading "+ _viewVo.id;
				
				_viewVo.viewDescriptor.createView(createViewCallBack);
				/*
				var className:String = _viewVo.className;
				
				var ClassDef:Class =  getDefinitionByName(className) as Class;
				if(ClassDef!=null){
					innerVisualElement= new ClassDef() as IVisualElement;
					addView(innerVisualElement);
				}
				*/
			}
			else{
				innerVisualElement = instance;
				addView(instance);
			}
		}
		
		
		private function createViewCallBack(view:IVisualElement):void{
			innerVisualElement= view;
			addView(innerVisualElement);
			
			if(loadingView != null){
				removeElement(loadingView);
				loadingView = null;
			}
		}
		
		private var _viewPart:IViewPart;
		
		public function get viewPart():IViewPart{
			return _viewPart;
		}
		
		public function addView(child:IVisualElement):void{
			this.innerVisualElement = child;
			innerVisualElement.addEventListener(FlexEvent.PREINITIALIZE,onUiCreateCompleted);
			innerVisualElement.addEventListener(FlexEvent.CREATION_COMPLETE,onInnerVisualElementCreateCompleted);
			
			
			var obj:Object = innerVisualElement as Object;
			if(obj.hasOwnProperty("label") && obj["label"] != null && obj["label"] != ""){
				this.label = obj["label"];
			}
			else{
				this.label = _viewVo.label;
			}
			
			if(_viewVo.toolTip != null){
				this.toolTip = _viewVo.toolTip;
			}
			
			WorkbenchViewManager.getInstance().setView(_viewVo.id,this);
			this.addElement(child);
		}
		
		private function onInnerVisualElementCreateCompleted(event:FlexEvent):void{
			innerVisualElement.removeEventListener(FlexEvent.CREATION_COMPLETE,onInnerVisualElementCreateCompleted);
			ViewInitManager.getInstance().addInitCompletedViewId(this._viewVo.id);
		}
		
		private function onUiCreateCompleted(event:FlexEvent):void{
			innerVisualElement.removeEventListener(FlexEvent.PREINITIALIZE,onUiCreateCompleted);
			
			_viewPart = new ViewPart(this);
			_viewPart.setViewId(_viewVo.id);
			_viewPart.setLayoutId(this.layoutId);
			_viewPart.setViewExtensionDescriptor(_viewVo.viewDescriptor);
			
			var viewPartEvent:ViewPartEvent = new ViewPartEvent(ViewPartEvent.VIEW_PART_CREATED);
			viewPartEvent.viewPart = _viewPart;
			
			if(event.target is IEventDispatcher){
				(event.target as IEventDispatcher).dispatchEvent(viewPartEvent);
			}
			
			WorkbenchManager.getInstance().onViewPartOpened(_viewPart,this.layoutId,this.getViewId());
			
		}
		
		public function  getViewId():String{
			return _viewVo.id;
		}
		
		public function getAdapter(adapter:Object):Object{
			if(innerVisualElement is IAdapter){
				return (innerVisualElement as IAdapter).getAdapter(adapter);
			}
			if((innerVisualElement as Object).hasOwnProperty("getAdapter")){
				return (innerVisualElement as Object).getAdapter(adapter);
			}
			return null;
		}
		
		public function findViewById(viewId:String):IViewPart{
			if(getViewId() == viewId){
				return viewPart;
			}
			return null;
		}
		
		public function executeMethord(methordName:String,param:Array):Object{
			if((innerVisualElement as Object).hasOwnProperty(methordName) && innerVisualElement[""+methordName] && innerVisualElement[""+methordName] is Function){
				var f:Function = innerVisualElement[""+methordName] as Function;
				return f.apply(null,param);
			}
			
			return null;
		}
		
		public function fireToolBarExpressNewState(state:Object):void{
			ToolBarViewWidgetExpressManager.getInstance().executeExpress(this.getViewId(),state);
		}
	}
}