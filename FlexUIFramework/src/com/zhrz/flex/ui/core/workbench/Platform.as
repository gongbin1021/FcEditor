package  com.zhrz.flex.ui.core.workbench
{
	
	import com.zhrz.flex.ui.core.configuration.ViewVo;
	import com.zhrz.flex.ui.core.workbench.IViewPart;
	
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	

	
	public class Platform implements IPlatform
	{
		public function Platform()
		{
		}
		
		private static var instance:IPlatform;
		public static function getInstance():IPlatform{
			if(instance == null){
				instance = new Platform();
			}
			return instance;
		}
		
		public function getActivateViewPart():IViewPart
		{
			return getCurrentActivateViewPart();
		}
		
		public function showView(viewVo:ViewVo,layoutId:String):void{
			WorkbenchManager.getInstance().showView(viewVo,layoutId);
		}
		
		public function initProduct(productName:String,app:IVisualElementContainer):void{
			WorkbenchManager.getInstance().initProduct(productName,app);
		}
		
		public function addChildByLayout(layoutId:String,viewVo:ViewVo,instance:IVisualElement):void{
			 WorkbenchManager.getInstance().addViewToLayout(layoutId,viewVo,instance);
		}
		
		public function getCurrentPluginId():String{
			return WorkbenchManager.getInstance().getCurrentPluginId();
		}
		
		public  function showChildByViewVo(viewVo:ViewVo,layoutId:String):void{
			WorkbenchManager.getInstance().showChildByViewVo(viewVo,layoutId);
		}
		
		public function onEditorContentSave(viewVo:ViewVo,layoutId:String):void{
			WorkbenchManager.getInstance().onEditorContentSave(viewVo,layoutId);
		}
		
		public function onEditorContentChanged(viewVo:ViewVo,layoutId:String):void{
			WorkbenchManager.getInstance().onEditorContentChanged(viewVo,layoutId);
		}
		
		public function getCurrentActivateViewPart():IViewPart{
			return WorkbenchManager.getInstance().getCurrentActivateViewPart();
		}
		
		
		public function getCurrentSelected():Object{
			return WorkbenchManager.getInstance().getCurrentSelected();
		}
		
		public function findViewById(viewId:String):IViewPart{
			return WorkbenchManager.getInstance().findViewById(viewId);
		}
		
		public function findCurrentShowViewInLayoutId(layoutId:String):IViewPart{
			return WorkbenchManager.getInstance().findCurrentShowViewInLayoutId(layoutId);
		}
	}
}