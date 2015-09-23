package com.zhrz.flex.ui.core.workbench
{
	import com.zhrz.flex.ui.core.configuration.LayoutVo;
	import com.zhrz.flex.ui.core.configuration.ViewVo;
	import com.zhrz.flex.ui.core.layout.DefaultLayoutStrategy;
	import com.zhrz.flex.ui.core.layout.ILayoutAreaVo;
	import com.zhrz.flex.ui.core.layout.ILayoutStrategy;
	import com.zhrz.flex.ui.core.layoutview.LayoutViewExtensionManager;
	import com.zhrz.flex.ui.core.managers.ViewInitManager;
	import com.zhrz.flex.ui.core.view.ViewExtensionManager;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.containers.TabNavigator;
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	import mx.utils.StringUtil;

	public class WorkbenchPageLayout
	{
		
		public var layoutVo:LayoutVo;
		
		private var _layoutStrategy:ILayoutStrategy;
		private var _client:WorkbenchPage;
		private var layoutAreaVos:ArrayCollection;
		private var innerLayoutAreas:ArrayCollection;
		
		public function WorkbenchPageLayout(layoutVo:LayoutVo):void{
			this.layoutVo = layoutVo;
		}
		
		public function layout(client:WorkbenchPage):void{
			_client = client;
			if(_layoutStrategy != null){
				beginLayout();
			}
			else{
				if(this.layoutVo.layoutStrategyId == null || StringUtil.trim(this.layoutVo.layoutStrategyId) == ""){
					_layoutStrategy = new DefaultLayoutStrategy();
					beginLayout();
				}
				else{
					
				}
			}
			
			
		}
		
		private function getLayoutStrategy(layoutStrategy:ILayoutStrategy):void{
			_layoutStrategy = layoutStrategy;
			beginLayout();
		}
		
		private function beginLayout():void{
			if(layoutAreaVos == null){
				layoutAreaVos = _layoutStrategy.getLayoutAreaVos(_client,this.layoutVo.layoutContent,this.layoutVo.id);
				innerLayoutAreas = new ArrayCollection();
				
				for each(var item:ILayoutAreaVo in layoutAreaVos){
					var innerAreaVo:InnerLayoutAreaVo = new InnerLayoutAreaVo(item);
					innerLayoutAreas.addItem(innerAreaVo);
					
					var viewIds:ArrayCollection = LayoutViewExtensionManager.getInstance().getExtension().getViewIdsByLayoutId(item.id);
					
					var viewVos:ArrayCollection = new ArrayCollection();
					for each(var viewId:String in viewIds){
						
						ViewInitManager.getInstance().addInitViewId(viewId);
						
						var viewVo:ViewVo = ViewExtensionManager.getInstance().getExtension().getViewVoById(viewId);
						if(viewVo){
							viewVos.addItem(viewVo);
						}
					}
					createLayoutChildren(viewVos,innerAreaVo,null);
				}
			}
			
			else{
				
			}
			
		}
		
		
		private function createLayoutChildren(views:ArrayCollection,layoutVo:InnerLayoutAreaVo,childInsatnces:Array = null):void{
			if(views.length > 0){
				var group:IVisualElementContainer = layoutVo.viewArea.layoutArea ;
				if(layoutVo.viewArea.isTab =="true"){
					var canvas1:Canvas = new Canvas();
					canvas1.percentHeight = 100;
					canvas1.percentWidth = 100;
					canvas1.styleName = "workbenchViewStyle";
					group.addElement(canvas1);
					if(layoutVo.viewArea.superTab){
						var superTabvigator:WorkbenchViewSuperTabNavigator = new WorkbenchViewSuperTabNavigator();
						
						canvas1.addElement(superTabvigator);
						
						superTabvigator.viewVos = views;
						superTabvigator.instances = childInsatnces;
						superTabvigator.layoutId = layoutVo.viewArea.id;
						superTabvigator.initViews();
						layoutVo.child = superTabvigator;
						layoutVo.viewVos = views;
					}
					else{
						var tabnavigator:WorkbenchViewTabNavigator = new WorkbenchViewTabNavigator();
						canvas1.addElement(tabnavigator);
						
						tabnavigator.viewVos = views;
						tabnavigator.instances = childInsatnces;
						tabnavigator.layoutId = layoutVo.viewArea.id;
						tabnavigator.initViews();
						
						layoutVo.child = tabnavigator;
						layoutVo.viewVos = views;
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
						canvas.layoutId = layoutVo.viewArea.id;
						canvas.initView();
						i++;
						layoutVo.child = group;
						layoutVo.viewVos = new ArrayCollection([viewVo]);
					}
				}
			}
		}
		
		public function showView(viewVo:ViewVo,layoutId:String):void{
			for each(var innerrVo:InnerLayoutAreaVo in innerLayoutAreas){
				if(innerrVo.viewArea.id == layoutId){
					if(innerrVo.child is IWorkbenchViewSwitch){
						(innerrVo.child as IWorkbenchViewSwitch).switchView(viewVo);
					}
				}
			}
		}
		
		public function findViewById(viewId:String):IViewPart{
			for each(var innerrVo:InnerLayoutAreaVo in innerLayoutAreas){
				for each(var viewVo:ViewVo in innerrVo.viewVos){
					if(viewVo.id == viewId){
						var viewPage:Object = innerrVo.child;
						if(viewPage.hasOwnProperty("findViewById")){
							return viewPage.findViewById(viewId);
						}
					}
				}
			}
			return null;
		}
		
		private function getLayoutGroupById(layoutId:String):InnerLayoutAreaVo{
			for each(var item:InnerLayoutAreaVo in innerLayoutAreas){
				if(item.viewArea.id == layoutId) return item;
			}
			
			return null;
		}
		
		public function addViewToLayout(layoutId:String,viewVo:ViewVo,instance:IVisualElement):void{
			var layoutVo:InnerLayoutAreaVo =  getLayoutGroupById(layoutId);
			if(layoutVo.child == null){
				
				createLayoutChildren(new ArrayCollection([viewVo]),layoutVo,[instance]);
			}
			else{
				if(layoutVo.child is WorkbenchViewSuperTabNavigator){
					(layoutVo.child as WorkbenchViewSuperTabNavigator).addView(viewVo,instance);
				}
				if(layoutVo.child is WorkbenchViewTabNavigator){
					(layoutVo.child as WorkbenchViewTabNavigator).addView(viewVo,instance);
				}
				else{
					
				}
				if(layoutVo.child is WorkbenchViewCanvas){
					var canvas:WorkbenchViewCanvas = new WorkbenchViewCanvas();
					canvas.styleName = "workbenchViewStyle";
					(layoutVo.child as IVisualElementContainer).addElement(canvas);
					canvas.viewVo = viewVo;
					canvas.initView();
				}
			}
		}
		
		public function destory():void{
			
		}
		
		public function onEditorContentChanged(viewVo:ViewVo,layoutId:String):void{
			for each(var innerrVo:InnerLayoutAreaVo in innerLayoutAreas){
				if(innerrVo.viewArea.id == layoutId){
					if(innerrVo.child is WorkbenchViewSuperTabNavigator){
						(innerrVo.child as WorkbenchViewSuperTabNavigator).onEditorContentChanged(viewVo);
					}
					if(innerrVo.child is WorkbenchViewTabNavigator){
						(innerrVo.child as WorkbenchViewTabNavigator).onEditorContentChanged(viewVo);
					}
				}
			}
		}
		
		public function findCurrentShowViewInLayoutId(layoutId:String):IViewPart{
			for each(var innerlayoutVo:InnerLayoutAreaVo in innerLayoutAreas){
				if(innerlayoutVo.viewArea.id == layoutId){
					if(innerlayoutVo.child == null) return null;
					var workbenchViewCanvas:WorkbenchViewCanvas = null;
					if(innerlayoutVo.child is WorkbenchViewTabNavigator || innerlayoutVo.child is WorkbenchViewSuperTabNavigator){
						workbenchViewCanvas = (innerlayoutVo.child as TabNavigator).selectedChild as WorkbenchViewCanvas;
						return workbenchViewCanvas.viewPart;
					}
					else{
						for(var i:int = 0 ; i < innerlayoutVo.child.numElements;i++){
							workbenchViewCanvas = innerlayoutVo.child.getElementAt(i) as WorkbenchViewCanvas;
							if(workbenchViewCanvas.visible && workbenchViewCanvas.includeInLayout){
								return workbenchViewCanvas.viewPart;
							}
						}
					}
				}
			}
			return null;
		}
	}
}
import com.zhrz.flex.ui.core.layout.ILayoutAreaVo;

import mx.collections.ArrayCollection;
import mx.core.IVisualElementContainer;


class InnerLayoutAreaVo{
	public function InnerLayoutAreaVo(viewArea:ILayoutAreaVo){
		this.viewArea = viewArea;
	}
	
	public var child:IVisualElementContainer;
	public var viewArea:ILayoutAreaVo;
	
	public var viewVos:ArrayCollection;
	
}