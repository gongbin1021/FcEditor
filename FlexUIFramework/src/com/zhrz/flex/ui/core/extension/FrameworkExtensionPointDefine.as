package com.zhrz.flex.ui.core.extension
{
	public class FrameworkExtensionPointDefine
	{
		
		public static const DEFAULT_EXTENSION_POINT_DEFINE:String = ""+
				'<extensionPoint id="' +product_EXTENSION_POINT +'" name="extensionpoint.product"></extensionPoint>'+
				'<extensionPoint id="'+pageLayoutClient_EXTENSION_POINT+'" name="extensionpoint.pageLayoutClient"></extensionPoint>'+
				'<extensionPoint id="'+pages_EXTENSION_POINT+'" name="extensionpoint.pages"></extensionPoint>'+
				'<extensionPoint id="'+layout_EXTENSION_POINT+'" name="extensionpoint.layout"></extensionPoint>'+
				'<extensionPoint id="'+layoutStrategy_EXTENSION_POINT+'" name="extensionpoint.layoutStrategy"></extensionPoint>'+
				'<extensionPoint id="'+views_EXTENSION_POINT+'" name="extensionpoint.views"></extensionPoint>'+
				'<extensionPoint id="'+layoutView_EXTENSION_POINT+'" name="extensionpoint.layoutView"></extensionPoint>'+
				'<extensionPoint id="'+commands_EXTENSION_POINT+'" name="extensionpoint.commands"></extensionPoint>'+
				'<extensionPoint id="'+handlers_EXTENSION_POINT+'" name="extensionpoint.handlers"></extensionPoint>'+
				'<extensionPoint id="'+editors_EXTENSION_POINT+'" name="extensionpoint.editors"></extensionPoint>'+
				'<extensionPoint id="'+toolbars_EXTENSION_POINT+'" name="extensionpoint.toolbars"></extensionPoint>'+
				'<extensionPoint id="'+rightMenu_EXTENSION_POINT+'" name="extensionpoint.rightMenus"></extensionPoint>'+
				'<extensionPoint id="'+adapter_EXTENSION_POINT+'" name="extensionpoint.adapterFactory"></extensionPoint>'+
				'<extensionPoint id="'+editorContentType_EXTENSION_POINT+'" name="extensionpoint.editorContentType"></extensionPoint>';
		
		
		
		public static const product_EXTENSION_POINT:String = "product";
		public static const pageLayoutClient_EXTENSION_POINT:String = "pageLayoutClient";
		public static const pages_EXTENSION_POINT:String = "pages";
		public static const layout_EXTENSION_POINT:String = "layout";	
		public static const layoutStrategy_EXTENSION_POINT:String = "layoutStrategy";	
		public static const views_EXTENSION_POINT:String = "views";	
		public static const layoutView_EXTENSION_POINT:String = "layoutView";
		public static const commands_EXTENSION_POINT:String = "commands";	
		public static const handlers_EXTENSION_POINT:String = "handlers";
		public static const editors_EXTENSION_POINT:String = "editors";	
		public static const editorContentType_EXTENSION_POINT:String = "editorContentType";
		
		public static const toolbars_EXTENSION_POINT:String = "toolbars";	
		
		public static const rightMenu_EXTENSION_POINT:String = "rightMenus";
		
		public static const adapter_EXTENSION_POINT:String = "adapterFactory";
		
	}
}