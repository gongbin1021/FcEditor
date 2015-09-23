package  com.zhrz.flex.ui.core.workbench
{
	import com.zhrz.flex.ui.core.configuration.ViewVo;
	import com.zhrz.flex.ui.core.toolbar.IToolBarContainer;
	import com.zhrz.flex.ui.core.toolbar.IToolBarWidget;
	import com.zhrz.flex.ui.core.toolbar.ToolBarExtensionManager;
	import com.zhrz.flex.ui.core.toolbar.ToolBarViewHBox;
	import com.zhrz.flex.ui.core.toolbar.ToolBarViewManager;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Box;
	import mx.containers.BoxDirection;
	import mx.containers.TabNavigator;
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;

	
	
	public class WorkbenchViewTabNavigator extends TabNavigator implements IToolBarContainer,IWorkbenchViewSwitch
	{
		public function WorkbenchViewTabNavigator()
		{
			super();
			percentWidth = 100;
			percentHeight = 100;
			
			this.setStyle("paddingTop",0);
			
			this.addEventListener(IndexChangedEvent.CHANGE,onChildIndexChanged);
			this.addEventListener(FlexEvent.CREATION_COMPLETE,onCreateCompleted);
		}
		
		private function onCreateCompleted(event:FlexEvent):void{
			//trace("sssssssssssssss");
			changeToolBar();
		}
		
		protected var holder:Box;
		
		
		override protected function createChildren():void{
			super.createChildren();
			
			
			if (!holder)
			{
				// Why not just use HBox? Because in the future we might want
				// to use a VBox for vertical tabs. This lets a subclass simply
				// change the direction.
				holder = new Box();
				holder.direction = BoxDirection.HORIZONTAL;
				
				holder.setStyle("horizontalGap", 0);
				holder.setStyle("borderStyle", "none");
				holder.setStyle("paddingTop", 0);
				holder.setStyle("paddingBottom", 0);
			//	holder.setStyle("backgroundColor","0xff0000");
				holder.horizontalScrollPolicy = "off";
				
				rawChildren.addChild(holder);
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number,
													  unscaledHeight:Number):void
		{
			
			var th:Number = this.tabBarHeight + 1;
			holder.move(0, 1);
			holder.setActualSize(unscaledWidth, th);
			
			
			
			super.updateDisplayList(unscaledWidth,unscaledHeight);
		}
		
		
		private function get tabBarHeight():Number
		{
			var tabHeight:Number = getStyle("tabHeight");
			
			if (isNaN(tabHeight))
				tabHeight = tabBar.getExplicitOrMeasuredHeight();
			
			return tabHeight - borderMetrics.top;
		}
		
		public function addToolBar(toolBar:IVisualElementContainer):void{
			
		}
		
		private function onChildIndexChanged(event:IndexChangedEvent):void{
			var workbenchView:WorkbenchViewCanvas = innerVisualElements.getItemAt(event.newIndex) as WorkbenchViewCanvas;
			workbenchView.onActivate();
			
			changeToolBar();
			
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
					
					createToolBar(viewVo.id);
				}
			}
		}
		
		public function addView(viewVo:ViewVo,instance:IVisualElement):void{
			_viewVos.addItem(viewVo);
			
			var workbenchView:WorkbenchViewCanvas = new WorkbenchViewCanvas();
			this.addElement(workbenchView);
			selectedChild = workbenchView;
			innerVisualElements.addItem(workbenchView);
			
			workbenchView.viewVo = viewVo;
			workbenchView.addView(instance);
			
			createToolBar(viewVo.id);
		}
		
		private function createToolBar(viewId:String):void{
			holder.removeAllChildren();
			
			
			var allToolBarWidgets:ArrayCollection = ToolBarExtensionManager.getInstance().getExtension().getAllToolBarWidget(viewId);
			if(allToolBarWidgets && allToolBarWidgets.length > 0){
				for each(var widget:IToolBarWidget in allToolBarWidgets){
					ToolBarViewManager.getInstance().addToolBarWidget(viewId,widget);
				}
			}
			
		}
		
		public function showChildByViewVo(viewVo:ViewVo):void{
			var index:int = _viewVos.getItemIndex(viewVo);
			if(index != -1){
				selectedIndex = index;
			}
		}
		
		private function getCurrentViewId():String{
			return (_viewVos.getItemAt(selectedIndex) as ViewVo).id;
		}
		
		private function changeToolBar():void{
			holder.removeAllChildren();
			var toolBarHbox:ToolBarViewHBox = ToolBarViewManager.getInstance().getToolBarHbox(getCurrentViewId());
			if(toolBarHbox != null)
				holder.addChild(toolBarHbox);
		}
		
		public function findViewById(viewId:String):IViewPart{
			for each(var view:WorkbenchViewCanvas in innerVisualElements){
				if(view.getViewId() == viewId){
					return view.viewPart;
				}
			}
			return null;
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
	}
}