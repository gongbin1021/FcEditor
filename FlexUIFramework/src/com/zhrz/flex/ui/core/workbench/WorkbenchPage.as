package  com.zhrz.flex.ui.core.workbench  
{
	
	

	import com.zhrz.flex.ui.core.configuration.LayoutVo;
	import com.zhrz.flex.ui.core.configuration.PageVo;
	import com.zhrz.flex.ui.core.configuration.ViewVo;
	import com.zhrz.flex.ui.core.layout.LayoutExtensionManager;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.core.IVisualElement;

	
	
	public class WorkbenchPage extends Canvas
	{
		public function WorkbenchPage()
		{
			super();
			
			layoutGroups = new ArrayCollection();
			percentHeight = 100;
			percentWidth = 100;
		}
		
		public var pageId:String;
		public var pageLabel:String;
		private var _pageVo:PageVo;
		private var layoutMap:Object = new Object();
		private var layoutVos:ArrayCollection = new ArrayCollection();
		private var currentLayout:WorkbenchPageLayout;
		public var allLayoutNames:Array = [];
		
		
		private var layoutGroups:ArrayCollection;
		
		public function getLayoutGroupById(layoutId:String):LayoutAreaVo{
			for each(var obj:LayoutAreaVo in layoutGroups){
				if(obj.id == layoutId) return obj;
			}
			return null;
		}
		
		
		public function init(pageVo:PageVo):void{
			this._pageVo = pageVo;
			
			for each(var item:Object in this._pageVo.layouts){
				var layoutVo:LayoutVo = LayoutExtensionManager.getInstance().getExtension().getLayoutById(item.layoutId);
				if(layoutVo){
					if(item.label != null || item.label != ""){
						layoutVo.label = item.label;
					}
					else{
						layoutVo.label = item.id;
					}
					layoutVo.isDefault = item.isDefault;
					layoutVo.layoutStrategyId = item.layoutStrategyId;
					allLayoutNames.push(layoutVo.label);
					layoutVos.addItem(layoutVo);
				}
				
				
			}
			
			var layoutItem:LayoutVo = findDefaultLayout();
			createLayoutByVo(layoutItem);
			
			
			/*if(this.lauoutVo != null){
				createLayout();
			}*/
			
		}
		
		
		public function findViewById(viewId:String):IViewPart{
			if(currentLayout == null) return null;
			return currentLayout.findViewById(viewId);
		}
		
		private function createLayoutByVo(vo:LayoutVo):void{
			if(currentLayout != null){
				currentLayout.destory();
			}
			
			currentLayout = layoutMap[vo.id] as WorkbenchPageLayout;
			if(currentLayout == null){
				currentLayout = new WorkbenchPageLayout(vo);
				layoutMap[vo.id] = currentLayout;
			}
			
			currentLayout.layout(this);
			
			
		}
		
		private function findDefaultLayout():LayoutVo{
			
			var defaultItem:LayoutVo;
			for each(var item:LayoutVo in layoutVos){
				if(item.isDefault =="true"){
					defaultItem = item;
					break;
				}
			}
			
			if(defaultItem == null){
				defaultItem = layoutVos[0];
			}
			
			return defaultItem;
			
		}
		
		public function showView(viewVo:ViewVo,layoutId:String):void{
			currentLayout.showView(viewVo,layoutId);    
		}
		
		/*private function createLayoutChildren(views:ArrayCollection,layoutVo:LayoutAreaVo,childInsatnces:Array = null):void{
			if(views.length > 0){
				var group:Container = layoutVo.layout as Container;
				if(layoutVo.isTab =="true"){
					var canvas1:Canvas = new Canvas();
					canvas1.percentHeight = 100;
					canvas1.percentWidth = 100;
					canvas1.styleName = "workbenchViewStyle";
					group.addElement(canvas1);
					if(layoutVo.superTab){
						var superTabvigator:WorkbenchViewSuperTabNavigator = new WorkbenchViewSuperTabNavigator();
						
						canvas1.addElement(superTabvigator);
						
						superTabvigator.viewVos = views;
						superTabvigator.instances = childInsatnces;
						superTabvigator.initViews();
						superTabvigator.layoutId = layoutVo.id;
						layoutVo.child = superTabvigator;
					}
					else{
						var tabnavigator:WorkbenchViewTabNavigator = new WorkbenchViewTabNavigator();
						canvas1.addElement(tabnavigator);
						
						tabnavigator.viewVos = views;
						tabnavigator.instances = childInsatnces;
						tabnavigator.initViews();
						tabnavigator.layoutId = layoutVo.id;
						layoutVo.child = tabnavigator;
					}
					
					
				}
				else{
					var i:int = 0;
					for each(var viewVo:ViewVo in views){
						var canvas:WorkbenchViewCanvas = new WorkbenchViewCanvas();
						canvas.styleName = "workbenchViewStyle";
						group.addElement(canvas);
						canvas.viewVo = viewVo;
						if(childInsatnces){
							canvas.instance = childInsatnces[i];
						}
						canvas.layoutId = layoutVo.id;
						canvas.initView();
						i++;
						layoutVo.child = group;
					}
				}
			}
		}*/
		
		public function addViewToLayout(layoutId:String,viewVo:ViewVo,instance:IVisualElement):void{
			currentLayout.addViewToLayout(layoutId,viewVo,instance);
		}
		
		
		
		public function showChildByViewVo(viewVo:ViewVo,layoutId:String):void{
			/*var layoutVo:LayoutAreaVo =  getLayoutGroupById(layoutId);
			if(layoutVo && layoutVo.child){
				if(layoutVo.child is WorkbenchViewSuperTabNavigator){
					(layoutVo.child as WorkbenchViewSuperTabNavigator).showChildByViewVo(viewVo);
				}
				if(layoutVo.child is WorkbenchViewTabNavigator){
					(layoutVo.child as WorkbenchViewTabNavigator).showChildByViewVo(viewVo);
				}
			}*/
			currentLayout.showView(viewVo,layoutId);
		}
		
		public function onEditorContentChanged(viewVo:ViewVo,layoutId:String):void{
			currentLayout.onEditorContentChanged(viewVo,layoutId);
			
		}
		
		public function onEditorContentSave(viewVo:ViewVo,layoutId:String):void{
			var layoutVo:LayoutAreaVo =  getLayoutGroupById(layoutId);
			if(layoutVo.child){
				if(layoutVo.child is WorkbenchViewSuperTabNavigator){
					(layoutVo.child as WorkbenchViewSuperTabNavigator).onEditorContentSave(viewVo);
				}
			}
		}
		
		public function findCurrentShowViewInLayoutId(layoutId:String):IViewPart{
			if(currentLayout){
				return currentLayout.findCurrentShowViewInLayoutId(layoutId);
			}
			return null;
		}
		
		
	}
}


class LayoutAreaVo {
	public var id:String;
	public var isTab:String;
	public var superTab:Boolean;
	public var child:Object;
	public var layout:Object;
}