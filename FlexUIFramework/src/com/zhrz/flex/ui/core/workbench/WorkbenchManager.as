package com.zhrz.flex.ui.core.workbench
{

	import com.zhrz.flex.ui.core.configuration.PageVo;
	import com.zhrz.flex.ui.core.configuration.ViewVo;
	import com.zhrz.flex.ui.core.pageLayoutClient.IPageLayoutClient;
	import com.zhrz.flex.ui.core.pages.PageExtensionManager;
	import com.zhrz.flex.ui.core.product.ProductManager;
	
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;



	public class WorkbenchManager
	{
		public function WorkbenchManager()
		{
			allWorkBenchPage = new ArrayCollection();
		}
		
		private static var instance:WorkbenchManager;
		
		public static function getInstance():WorkbenchManager{
			if(instance == null){
				instance = new WorkbenchManager();
			}
			
			return instance;
		}
		
		public function getCurrentPluginId():String{
			return currentPluginId;
		}
		
		private var currentPluginId:String;
		private var _app:IVisualElementContainer;
		private var _layoutArea:IVisualElementContainer;
		
		private var _productName:String;
		private var _currentPageVo:PageVo;
		private var _currentPageIndex:int = 0;
		private var _currentWorkBenchPage:WorkbenchPage;
		
		private var allWorkBenchPage:ArrayCollection = null;
		private var pageVos:ArrayCollection = new ArrayCollection();
		
		private var pageManagers:ArrayCollection = new ArrayCollection();
		
		
		public function initProduct(productName:String,app:IVisualElementContainer):void{
			this._app = app;
			this._productName = productName;
			currentPluginId = ProductManager.getInstance().beginParseExtension().getCurrentPluginId(productName);
			ProductManager.getInstance().beginParseExtension().getPageLayoutClientByProductName(productName,createPageLayoutClientSuccess);
		}
		
		private function createPageLayoutClientSuccess(layoutClient:IPageLayoutClient):void{
			if(layoutClient != null){
				var visualArea:IVisualElement = layoutClient.getVisualArea();
				if(visualArea != null){
					this._app.addElement(visualArea);
				}
				this._layoutArea = layoutClient.getLayoutClient();
				
				pageVos = new ArrayCollection();
				var pages:Array = ProductManager.getInstance().beginParseExtension().getPagesByProductName(this._productName);
				if(pages == null || pages.length == 0){
					trace("没有定义page")
					return 
				}
				for each(var pageId:String in pages){
					var pageVo:PageVo = PageExtensionManager.getInstance().getExtension().getPageById(pageId);
					pageVos.addItem(pageVo);
				}
				
				_currentPageIndex = 0;
				_currentPageVo = getPageVoByIndex(_currentPageIndex);
				openPage(_currentPageVo);
			}
		}
		
		private function openPage(page:PageVo):void{
			var pageId:String = page.id;
			if(checkPageIsOpen(pageId)){
				var openedPage:WorkbenchPage = getPage(pageId);
				allWorkBenchPage.setItemAt(openedPage,allWorkBenchPage.length-1);
				this._layoutArea.setElementIndex(openedPage,_app.numElements-1);
				_currentWorkBenchPage = openedPage;
			}
			else{
				var newPage:WorkbenchPage = new WorkbenchPage();
				
				var pageManager:WorkbenchPageManager = new WorkbenchPageManager(newPage);
				pageManagers.addItem(pageManager);
				_currentWorkBenchPage = newPage;
				
				allWorkBenchPage.addItem(newPage);
				this._layoutArea.addElement(newPage);
				newPage.pageId = page.id;
				newPage.pageLabel =page.label; 
				newPage.init(page);	
			}
		}
		
		private function checkPageIsOpen(pageId:String):Boolean{
			if(allWorkBenchPage.length == 0) return false;
			for each(var page:WorkbenchPage in allWorkBenchPage){
				if(page.pageId == pageId) return true;
			}
			
			return false;
		}
		
		
		
		
		private function getPage(pageId:String):WorkbenchPage{
			for each(var page:WorkbenchPage in allWorkBenchPage){
				if(page.pageId == pageId){
					return page;
				}
			}
			
			return null;
		}
		
		private function getPageVoByIndex(index:int):PageVo{
			if(index >= 0 && index < pageVos.length){
				return pageVos.getItemAt(index) as PageVo
			}
			return null;
		}
		
		/*public function getViewsByLayoutId(layoutId:String):ArrayCollection{
			var result:ArrayCollection = new ArrayCollection();
			
			var viewIds:Array = [];
			for each(var layView:LayoutViewVo in _pluginVo.layouts_views){
				if(layView.layoutId == layoutId){
					viewIds.push(layView.viewId);
				}
			}
			
			if(viewIds.length > 0){
				for each(var viewId:String in viewIds){
					for each(var view:ViewVo in _pluginVo.views){
						if(viewId == view.id){
							result.addItem(view);
						}
					}
				}
				
			}
			
			return result;
		}*/
		
		public function addPartListener(listener:IPartListener):void{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				pageManager.addPartListener(listener);
			}
		}
		
		public function removePartListener(listener:IPartListener):void{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				pageManager.removePartListener(listener);
			}
		}
		
		public function addSelectionChangedListener(listener:ISelectionChangedListenter):void{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				pageManager.addSelectionChangedListener(listener);
			}
		}
		
		public function removeSelectionChangedListener(listener:ISelectionChangedListenter):void{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				pageManager.removeSelectionChangedListener(listener);
			}
		}
		
		public function setSelection(value:Object,fromLayoutId:String,fromViewId:String):void{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				pageManager.setSelection(value,fromLayoutId,fromViewId);
			}
		}
		
		
		
		private function getCurrentPageManager():WorkbenchPageManager{
			for each(var pageManager:WorkbenchPageManager in pageManagers){
				if(pageManager.getPage() == _currentWorkBenchPage){
					return pageManager;
				}
			}
			
			return null;
		}
		
		public function activate(viewPart:IViewPart,layoutId:String,viewId:String):void{
			onViewPartActivated(viewPart,layoutId,viewId);
		}
		
		private var _currentAvtivateViewPart:IViewPart;
		public function onViewPartActivated(viewPart:IViewPart,layoutId:String,viewId:String):void{
			if(_currentAvtivateViewPart == viewPart) return;
			
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				if(_currentAvtivateViewPart != null){
					pageManager.partDeactivated(_currentAvtivateViewPart,layoutId,viewId);
				}
				
				pageManager.partActivated(viewPart,layoutId,viewId);
				_currentAvtivateViewPart = viewPart;
			}
		}
		
		public function onViewPartOpened(partRef:IViewPart ,layoutId:String,viewId:String):void{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				pageManager.partOpened(partRef,layoutId,viewId);
			}
		}
		
		public function  onViewPartClosed(partRef:IViewPart ,layoutId:String,viewId:String):void{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				pageManager.partClosed(partRef,layoutId,viewId);
			}
		}
		
	
		
		public function findLayoutById(layoutId:String):Object{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				return pageManager.getPage().getLayoutGroupById(layoutId);
			}
			
			return null;
		}
		
		public function addViewToLayout(layoutId:String,viewVo:ViewVo,instance:IVisualElement):void{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				pageManager.addViewToLayout(layoutId,viewVo,instance);
			}
			
		}
		
		public function showChildByViewVo(viewVo:ViewVo,layoutId:String):void{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				pageManager.showChildByViewVo(viewVo,layoutId);
			}
			
		}
		
		public function onEditorContentSave(viewVo:ViewVo,layoutId:String):void{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				pageManager.onEditorContentSave(viewVo,layoutId);
			}
		}
		
		public function onEditorContentChanged(viewVo:ViewVo,layoutId:String):void{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				pageManager.onEditorContentChanged(viewVo,layoutId);
			}
		}
		
		public function getCurrentActivateViewPart():IViewPart{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				return pageManager.getCurrentActivateViewPart();
			}
			return null;
		}
		
		
		public function getCurrentSelected():Object{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				return pageManager.getCurrentSelected();
			}
			return null;
		}
		
		public function showView(viewVo:ViewVo,layoutId:String):void{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				 pageManager.showView(viewVo,layoutId);
			}
		}
		
		public function findViewById(viewId:String):IViewPart{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				return pageManager.findViewById(viewId);
			}
			else{
				return null;
			}
		}
		
		public function findCurrentShowViewInLayoutId(layoutId:String):IViewPart{
			var pageManager:WorkbenchPageManager = getCurrentPageManager();
			if(pageManager != null){
				return pageManager.findCurrentShowViewInLayoutId(layoutId);
			}
			else{
				return null;
			}
		}
	}
}