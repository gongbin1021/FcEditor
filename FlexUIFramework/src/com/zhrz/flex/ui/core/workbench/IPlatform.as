package  com.zhrz.flex.ui.core.workbench
{
	
	import com.zhrz.flex.ui.core.configuration.ViewVo;
	import com.zhrz.flex.ui.core.workbench.IViewPart;
	
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	
	

	public interface IPlatform
	{
		function getActivateViewPart():IViewPart;
		
		
		function initProduct(productName:String,app:IVisualElementContainer):void;
		
		function addChildByLayout(layoutId:String,viewVo:ViewVo,instance:IVisualElement):void;
		
		function showView(viewVo:ViewVo,layoutId:String):void;
		
		function getCurrentPluginId():String;
		
		function showChildByViewVo(viewVo:ViewVo,layoutId:String):void;
		
		function onEditorContentSave(viewVo:ViewVo,layoutId:String):void;
		
		function onEditorContentChanged(viewVo:ViewVo,layoutId:String):void;
		
		
		function getCurrentActivateViewPart():IViewPart;
		
		function getCurrentSelected():Object;
		
		
		function findViewById(viewId:String):IViewPart;
		
		function findCurrentShowViewInLayoutId(layoutId:String):IViewPart;
	}
}